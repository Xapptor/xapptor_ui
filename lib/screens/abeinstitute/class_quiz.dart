import 'dart:math';
import 'package:xapptor_auth/get_user_info.dart';
import 'package:xapptor_logic/generate_certificate.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/abeinstitute/class_quiz_question.dart';
import 'package:xapptor_ui/widgets/abeinstitute/class_quiz_result.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String user_id = "";
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

        FirebaseFirestore.instance.collection("users").doc(user_id).update({
          "units_completed": FieldValue.arrayUnion([widget.unit_id]),
        }).catchError((err) => print(err));

        if (widget.last_unit)
          check_if_exist_certificate(
            user_id,
            widget.course_id,
            widget.course_name,
            context,
          );
      }

      setState(() {});
    }
  }

  set_user_info() async {
    user_id = FirebaseAuth.instance.currentUser!.uid;
    user_info = await get_user_info(user_id);
  }

  @override
  void initState() {
    super.initState();
    set_user_info();
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
