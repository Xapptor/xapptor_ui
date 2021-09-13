import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class ClassQuizResult extends StatefulWidget {
  const ClassQuizResult({
    required this.text_list,
    required this.class_quiz,
  });

  final List<String> text_list;
  final class_quiz;

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
            flex: 4,
            child: Text(
              widget.text_list[0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
                    color_abeinstitute_text,
                    color_abeinstitute_text,
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
                child: Text(
                  widget.text_list[1],
                  style: TextStyle(
                    color: Colors.white,
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
