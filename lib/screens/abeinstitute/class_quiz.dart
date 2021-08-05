import 'dart:math';
import 'package:xapptor_auth/get_user_info.dart';
import 'package:xapptor_logic/email_sender.dart';
import 'package:xapptor_logic/generate_certificate_html_from_values.dart';
import 'package:xapptor_logic/timestamp_to_date.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_ui/widgets/abeinstitute/class_quiz_question.dart';
import 'package:xapptor_ui/widgets/abeinstitute/class_quiz_result.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class ClassQuiz extends StatefulWidget {
  const ClassQuiz({
    required this.topbar_color,
    required this.course_id,
    required this.course_name,
    required this.unit_id,
    required this.last_unit,
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final Color topbar_color;
  final String course_id;
  final String course_name;
  final String unit_id;
  final bool last_unit;
  final Color language_picker_items_text_color;
  final bool language_picker;

  @override
  _ClassQuizState createState() => _ClassQuizState();
}

class _ClassQuizState extends State<ClassQuiz> {
  late SharedPreferences prefs;

  String uid = "";

  Map<String, dynamic> user_info = {};

  String current_language = "en";

  TranslationStream translation_stream = TranslationStream();

  List<String> text_list = [
    "Lives:",
    "Validate",
    "Progress:",
  ];

  bool quiz_passed = false;

  List questions_result = [];

  double percentage_progress = 0;

  int lives = 3;

  final PageController page_controller = PageController(initialPage: 0);

  int current_page = 0;

  List<Widget> widgets_list = <Widget>[];

  String html_certificate = "";

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;
    translation_stream.translate();
    setState(() {});
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      Container(
        width: portrait ? 100 : 150,
        child: widget.language_picker
            ? LanguagePicker(
                current_language: current_language,
                language_picker_callback: language_picker_callback,
                language_picker_items_text_color:
                    widget.language_picker_items_text_color,
              )
            : Container(),
      ),
    ];
  }

  get_quiz_data(String unit_id) {
    FirebaseFirestore.instance
        .collection('templates')
        .doc("certificate")
        .get()
        .then((DocumentSnapshot doc_snap) {
      html_certificate = doc_snap.get("html");
    });

    FirebaseFirestore.instance
        .collection('quizzes')
        .doc(unit_id)
        .get()
        .then((DocumentSnapshot doc_snap) {
      List questions_object = doc_snap.get("questions");

      questions_object.shuffle();

      for (var i = 0; i < questions_object.length; i++) {
        questions_result.add(false);

        List final_possible_answers = [];

        List current_answers = questions_object[i]["answers"];

        if (current_answers.length > 2) {
          while (final_possible_answers.length <
              (current_answers.length == 3 ? 2 : 3)) {
            print(final_possible_answers);

            final random = new Random();

            String random_possible_answer =
                current_answers[random.nextInt(current_answers.length)]
                    .toString();

            if (random_possible_answer !=
                questions_object[i]["correct_answer"].toString()) {
              bool random_possible_answer_already_exist = false;

              for (var four_possible_answers_element
                  in final_possible_answers) {
                if (four_possible_answers_element == random_possible_answer)
                  random_possible_answer_already_exist = true;
              }

              if (!random_possible_answer_already_exist)
                final_possible_answers.add(random_possible_answer);
            }
          }

          final_possible_answers.add(
            questions_object[i]["correct_answer"].toString(),
          );
        } else {
          final_possible_answers = current_answers;
        }

        widgets_list.add(
          ClassQuizQuestion(
            question_title: questions_object[i]["question_title"],
            answers: final_possible_answers,
            demos: questions_object[i]["demos"],
            class_quiz: this,
            correct_answer: questions_object[i]["correct_answer"].toString(),
            question_id: i,
          ),
        );
      }

      widgets_list.add(
        ClassQuizResult(
          class_quiz: this,
        ),
      );

      setState(() {});

      translation_stream.init(text_list, update_text_list);
      translation_stream.translate();
    });
  }

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  get_next_question(bool answer_is_correct, int question_id) {
    if (answer_is_correct) {
      questions_result[question_id] = true;
    } else {
      lives--;
    }

    if (lives == 0) {
      quiz_passed = false;

      page_controller.animateToPage(
        widgets_list.length - 1,
        duration: Duration(milliseconds: 800),
        curve: Curves.elasticOut,
      );
    } else {
      List possible_next_page_index = [];

      for (int i = 0; i < questions_result.length; i++) {
        if (!questions_result[i]) {
          possible_next_page_index.add(i);
        }
      }

      percentage_progress =
          (100 * (questions_result.length - possible_next_page_index.length)) /
              questions_result.length;

      if (possible_next_page_index.length > 0) {
        int nextPageIndex = 0;

        if (possible_next_page_index.length > 1) {
          nextPageIndex = possible_next_page_index
              .firstWhere((possible) => possible != current_page);
        } else {
          nextPageIndex = possible_next_page_index[0];
        }

        page_controller.animateToPage(nextPageIndex,
            duration: Duration(milliseconds: 800), curve: Curves.elasticOut);
      } else {
        quiz_passed = true;

        page_controller.animateToPage(widgets_list.length - 1,
            duration: Duration(milliseconds: 800), curve: Curves.elasticOut);

        FirebaseFirestore.instance.collection("users").doc(uid).update({
          "units_completed": FieldValue.arrayUnion([widget.unit_id]),
        }).catchError((err) => print(err));

        if (widget.last_unit) check_if_exist_certificate();
      }

      setState(() {});
    }
  }

  generate_certificate(bool exist_certificate) {
    if (!exist_certificate) {
      FirebaseFirestore.instance
          .collection("certificates")
          .add({
            "course_id": widget.course_id,
            "date": FieldValue.serverTimestamp(),
            "user_id": uid,
          })
          .then((new_doc) => {
                FirebaseFirestore.instance.collection("users").doc(uid).update({
                  "certificates": FieldValue.arrayUnion([new_doc.id]),
                }).catchError((err) => print(err)),
                FirebaseFirestore.instance
                    .collection('templates')
                    .doc("certificate")
                    .get()
                    .then((DocumentSnapshot doc_snap) async {
                  DocumentSnapshot new_doc_snap = await new_doc.get();

                  String html_certificate_result =
                      await HtmlCertificateFromValues().generate(
                    course_name: widget.course_name,
                    user_name:
                        user_info["firstname"] + " " + user_info["lastname"],
                    date: TimestampToDate().convert(new_doc_snap.get("date")),
                    id: new_doc.id,
                  );

                  User user = FirebaseAuth.instance.currentUser!;

                  EmailSender()
                      .send(
                        to: user.email!,
                        subject:
                            "${user_info["firstname"] + " " + user_info["lastname"]}, here is your certificate for Lean Six Sigma",
                        text: "New Message",
                        html: html_certificate_result,
                      )
                      .then((value) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Certificate sent! ✉️"),
                                duration: Duration(seconds: 3),
                              ),
                            ),
                          })
                      .catchError((err) => print(err));
                }),
              })
          .catchError((err) {
            print(err);
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You already have this certificate 👍"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  check_if_exist_certificate() async {
    bool user_already_has_courses_certificate = false;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot doc_snap_user) {
      List? certificates = doc_snap_user.get("certificates");

      if (certificates == null || certificates.length == 0) {
        generate_certificate(false);
      } else {
        print(certificates);

        for (int i = 0; i < certificates.length; i++) {
          FirebaseFirestore.instance
              .collection('certificates')
              .doc(certificates[i])
              .get()
              .then((DocumentSnapshot doc_snap_certificate) {
            print(doc_snap_certificate.data);

            print("course_id: " + doc_snap_certificate.get("course_id"));
            print("widget.courseID: " + widget.course_id);

            if (doc_snap_certificate.get("course_id") == widget.course_id)
              user_already_has_courses_certificate = true;

            if (i == certificates.length - 1) {
              print("final checkIfExistCertificate: " +
                  user_already_has_courses_certificate.toString());

              generate_certificate(user_already_has_courses_certificate);
            }
          });
        }
      }
    });
  }

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid") ?? "";
    user_info = await get_user_info(uid);
  }

  @override
  void initState() {
    super.initState();
    init_prefs();
    get_quiz_data(widget.unit_id);
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: widgets_action(portrait),
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: Container(
        child: widgets_list.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(text_list[0] + " " + lives.toString()),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.33,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int page) {
                        setState(() {
                          current_page = page;
                        });
                      },
                      pageSnapping: true,
                      controller: page_controller,
                      children: widgets_list,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      text_list[2] + " " + percentage_progress.toString(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
