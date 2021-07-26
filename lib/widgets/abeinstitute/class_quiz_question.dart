import 'package:xapptor_translation/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'class_quiz_answer_item.dart';

class ClassQuizQuestion extends StatefulWidget {
  const ClassQuizQuestion({
    required this.question_title,
    required this.answers,
    required this.demos,
    required this.class_quiz,
    required this.correct_answer,
    required this.question_id,
  });

  final String question_title;
  final List answers;
  final List? demos;
  final class_quiz;
  final String correct_answer;
  final int question_id;

  @override
  _ClassQuizQuestionState createState() => _ClassQuizQuestionState();
}

class _ClassQuizQuestionState extends State<ClassQuizQuestion> {
  int current_index = -1;

  List<bool> answers_selected = <bool>[];

  TranslationStream translation_stream = TranslationStream();

  List<String> text_list = [
    "Lives:",
    "Validate",
    "Progress:",
  ];

  get_quiz_data() {
    for (var i = 0; i < widget.answers.length; i++) {
      answers_selected.add(false);
    }

    widget.answers.shuffle();
    setState(() {});
  }

  late SharedPreferences prefs;
  String current_language = "en";

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language_target") != null)
      current_language = prefs.getString("language_target") ?? "";

    text_list = [
      widget.question_title,
      "Validate",
      widget.correct_answer,
    ];

    for (int i = 0; i < widget.answers.length; i++) {
      text_list.add(widget.answers[i].toString());
    }

    setState(() {});

    translation_stream.init(text_list, update_text_list);
    translation_stream.translate();

    get_quiz_data();
  }

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init_prefs();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      child: Column(
        children: <Widget>[
          Spacer(flex: 1),
          Expanded(
            flex: 3,
            child: Container(
              width: portrait ? 300 : 700,
              child: AutoSizeText(
                text_list[0],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 12,
                maxLines: 5,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          widget.demos == null
              ? Container()
              : Expanded(
                  flex: 3,
                  child: Image.network(
                    widget.demos![0],
                    fit: BoxFit.fitHeight,
                  ),
                ),
          Expanded(
            flex: 10,
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.answers.length,
                itemBuilder: (BuildContext context, int index) =>
                    FractionallySizedBox(
                  widthFactor: portrait ? 0.8 : 0.65,
                  child: ClassQuizAnswerItem(
                    answer_text: text_list[index + 3],
                    index: index,
                    class_quiz_question: this,
                    selected: current_index == index,
                    background_color: widget.answers.length > 2
                        ? (index % 2 == 0)
                            ? Colors.white
                            : Color(0xffe4eded)
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
          ElevatedButton(
            onPressed: () {
              bool answer_is_correct =
                  text_list[current_index + 3] == text_list[2];

              print("answer_is_correct: " + answer_is_correct.toString());

              widget.class_quiz
                  .get_next_question(answer_is_correct, widget.question_id);
            },
            child: Text(text_list[1]),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
