import 'package:xapptor_translation/translate.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_logic/is_portrait.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class_quiz.dart';

class ClassSession extends StatefulWidget {
  const ClassSession({
    required this.course_id,
    required this.course_name,
    required this.unit_id,
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final String course_id;
  final String course_name;
  final String unit_id;
  final Color language_picker_items_text_color;
  final bool language_picker;

  @override
  _ClassSessionState createState() => _ClassSessionState();
}

class _ClassSessionState extends State<ClassSession> {
  String current_language = "en";
  late TranslationStream translation_stream;
  List<TranslationStream> translation_stream_list = [];

  List<String> text_list = [
    "text",
    "text",
    "text",
    "text",
    "text",
  ];

  String video_url = "";
  bool last_unit = false;

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    text_list[index] = new_text;
    setState(() {});
  }

  String generate_video_url_for_current_platform(String original_url) {
    String new_url = "";
    String video_id = original_url.substring(
      original_url.lastIndexOf("/"),
      original_url.length,
    );
    new_url = "https://www.abeinstitute.com/#/video$video_id";
    return new_url;
  }

  set_texts_and_video_url() {
    FirebaseFirestore.instance
        .collection('units')
        .doc(widget.unit_id)
        .get()
        .then((DocumentSnapshot doc_snap) {
      text_list = [
        doc_snap.get("title"),
        doc_snap.get("subtitle"),
        doc_snap.get("description"),
        doc_snap.get("recomendation"),
        "Start Quiz",
      ];

      video_url = generate_video_url_for_current_platform(
          doc_snap.get("video_urls")[
              (current_language == "en" || current_language == "es")
                  ? current_language
                  : "en"]);

      last_unit = doc_snap.get('last_unit');

      setState(() {});

      translation_stream = TranslationStream(
        text_list: text_list,
        update_text_list_function: update_text_list,
        list_index: 0,
        active_translation: true,
      );
      translation_stream_list = [translation_stream];
    });
  }

  late SharedPreferences prefs;

  get_current_language() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language_target") != null) {
      current_language = prefs.getString("language_target")!;
    }
    setState(() {});
    set_texts_and_video_url();
  }

  @override
  void initState() {
    super.initState();
    get_current_language();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    return Scaffold(
      appBar: TopBar(
        background_color: color_abeinstitute_topbar,
        has_back_button: true,
        actions: [
          Container(
            width: 150,
            margin: EdgeInsets.only(right: 20),
            child: LanguagePicker(
              translation_stream_list: translation_stream_list,
              language_picker_items_text_color: color_abeinstitute_text,
            ),
          ),
        ],
        custom_leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        logo_path: "assets/images/logo.png",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: portrait ? 0.85 : 0.3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: sized_box_space * 4,
                    ),
                    AutoSizeText(
                      text_list[0] + " - " + text_list[1],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 18,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                    SelectableText(
                      text_list[2],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Webview(
                  src: video_url,
                  id: Uuid().v4(),
                  function: () {},
                ),
              ),
              FractionallySizedBox(
                widthFactor: portrait ? 0.85 : 0.3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                    SelectableText(
                      text_list[3],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      child: CustomCard(
                        linear_gradient: LinearGradient(
                          colors: [
                            color_abeinstitute_text,
                            color_abeinstitute_text,
                          ],
                        ),
                        border_radius: 1000,
                        on_pressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassQuiz(
                                course_id: widget.course_id,
                                course_name: widget.course_name,
                                unit_id: widget.unit_id,
                                last_unit: last_unit,
                                language_picker_items_text_color:
                                    widget.language_picker_items_text_color,
                                language_picker: widget.language_picker,
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            text_list[4],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sized_box_space * 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
