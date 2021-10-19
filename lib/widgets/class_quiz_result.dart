import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class ClassQuizResult extends StatefulWidget {
  const ClassQuizResult({
    required this.button_text,
    required this.class_quiz,
    required this.text_color,
  });

  final String button_text;
  final class_quiz;
  final Color text_color;

  @override
  _ClassQuizResultState createState() => _ClassQuizResultState();
}

class _ClassQuizResultState extends State<ClassQuizResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Spacer(flex: 1),
          Expanded(
            flex: 14,
            child: Center(
              child: Icon(
                widget.class_quiz.quiz_passed
                    ? Icons.check_circle_outline_rounded
                    : Icons.highlight_off_rounded,
                color: widget.text_color,
                size: 200,
              ),
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: Container(
              width: 200,
              child: CustomCard(
                linear_gradient: LinearGradient(
                  colors: [
                    widget.text_color,
                    widget.text_color,
                  ],
                ),
                border_radius: 1000,
                on_pressed: () {
                  if (widget.class_quiz.quiz_passed) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Center(
                  child: Text(
                    widget.button_text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
