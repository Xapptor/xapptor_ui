import 'package:flutter/material.dart';

class ClassQuizResult extends StatefulWidget {
  const ClassQuizResult({
    @required this.class_quiz,
  });

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
            flex: 1,
            child: Text(widget.class_quiz.quiz_passed
                ? "Well done!"
                : "You need to restart the quiz!"),
          ),
          Spacer(flex: 1),
          ElevatedButton(
            onPressed: () {
              if (widget.class_quiz.quiz_passed) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text("Continue"),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
