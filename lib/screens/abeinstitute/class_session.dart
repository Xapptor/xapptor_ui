import 'package:xapptor_ui/screens/abeinstitute/class_quiz.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/models/abeinstitute/class_unit_arguments.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/webview/webview.dart';

class ClassSession extends StatefulWidget {
  const ClassSession({
    required this.topbar_color,
    required this.course_id,
    required this.course_name,
    required this.unit_id,
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final Color topbar_color;
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
  TranslationStream translation_stream = TranslationStream();
  List<String> text_list = [
    "text",
    "text",
    "text",
    "text",
    "text",
  ];

  String video_url = "";
  late ClassUnitArguments args;
  bool already_have_texts = false;
  bool fullscreen_mode = false;
  String class_session_html = "class_session";
  bool last_unit = false;

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  String generate_video_url_for_current_platform(String original_url) {
    if (UniversalPlatform.isWeb) {
      String new_url =
          "https://www.abeinstitute.com/#/video${original_url.substring(original_url.lastIndexOf("/"), original_url.length)}";
      return new_url;
    } else {
      String new_url =
          "https://www.abeinstitute.com/#/video${original_url.substring(original_url.lastIndexOf("/"), original_url.length)}";
      return new_url;
    }
  }

  get_class_texts() async {
    await FirebaseFirestore.instance
        .collection('units')
        .doc(widget.unit_id)
        .get()
        .then((DocumentSnapshot doc_snap) {
      text_list = [
        doc_snap.get("title"),
        doc_snap.get("subtitle"),
        doc_snap.get("description"),
        doc_snap.get("recomendation"),
        "Class session",
      ];

      video_url = generate_video_url_for_current_platform(
          doc_snap.get("video_urls")[current_language]);

      last_unit = doc_snap.get('last_unit');

      setState(() {});

      translation_stream.init(text_list, update_text_list);
      translation_stream.translate();

      return null;
    });
  }

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;
    translation_stream.translate();
    setState(() {});

    await FirebaseFirestore.instance
        .collection('units')
        .doc(widget.unit_id)
        .get()
        .then((DocumentSnapshot doc_snap) {
      video_url = generate_video_url_for_current_platform(
          doc_snap.get("video_urls")[current_language]);

      setState(() {});
      return null;
    });
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      Container(
        width: portrait ? 100 : 150,
        child: LanguagePicker(
          current_language: current_language,
          language_picker_callback: language_picker_callback,
          language_picker_items_text_color: Theme.of(context).primaryColor,
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 100,
          right: MediaQuery.of(context).size.width / 100,
        ),
        child: TextButton(
          onPressed: () {
            fullscreen_mode = !fullscreen_mode;
            setState(() {});
          },
          child: Row(
            children: <Widget>[
              Text(
                "Fullscreen",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                fullscreen_mode ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    get_class_texts();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: widgets_action(portrait),
        custom_leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        logo_path: "assets/images/logo.png",
      ),
      body: Stack(
        children: <Widget>[
          fullscreen_mode
              ? Container()
              : Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Spacer(flex: 1),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: portrait ? 300 : 500,
                            child: AutoSizeText(
                              text_list[0],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 22,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: portrait ? 300 : 500,
                            child: AutoSizeText(
                              text_list[1],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: portrait ? 300 : 500,
                            child: AutoSizeText(
                              text_list[2],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 12,
                              maxLines: 4,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: portrait ? double.infinity : 700,
                            child: Webview(
                              src: video_url,
                              id: Uuid().v4(),
                              function: () {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: portrait ? 300 : 500,
                            child: AutoSizeText(
                              text_list[3],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 12,
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
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
                                  topbar_color: widget.topbar_color,
                                ),
                              ),
                            );
                          },
                          child: Text('Start Quiz'),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
          fullscreen_mode
              ? Container(
                  child: Webview(
                    src: video_url,
                    id: Uuid().v4(),
                    function: () {},
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}