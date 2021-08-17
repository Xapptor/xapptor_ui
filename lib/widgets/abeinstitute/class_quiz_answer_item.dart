import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassQuizAnswerItem extends StatefulWidget {
  const ClassQuizAnswerItem({
    required this.answer_text,
    required this.index,
    required this.class_quiz_question,
    required this.selected,
    required this.background_color,
  });

  final String answer_text;
  final int index;
  final class_quiz_question;
  final bool selected;
  final Color background_color;

  @override
  _ClassQuizAnswerItemState createState() => _ClassQuizAnswerItemState();
}

class _ClassQuizAnswerItemState extends State<ClassQuizAnswerItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool is_image = widget.answer_text.contains("http") &&
        widget.answer_text.contains(".com");

    return Container(
      height: MediaQuery.of(context).size.height / 6,
      color: Colors.blueGrey,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            widget.selected ? Colors.cyan : widget.background_color,
          ),
        ),
        onPressed: () {
          widget.class_quiz_question.current_index = widget.index;
          widget.class_quiz_question.setState(() {});
        },
        child: is_image
            ? Image.network(
                widget.answer_text,
                fit: BoxFit.fitHeight,
              )
            : Text(
                widget.answer_text,
                style: TextStyle(
                  color:
                      !widget.selected ? Colors.cyan : widget.background_color,
                ),
              ),
      ),
    );
  }
}
