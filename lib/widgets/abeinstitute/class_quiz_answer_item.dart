import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

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

    Color background_color =
        widget.selected ? Colors.cyan : widget.background_color;

    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: CustomCard(
        splash_color: color_abeinstitute_text.withOpacity(0.3),
        linear_gradient: LinearGradient(
          colors: [
            background_color,
            background_color,
          ],
        ),
        on_pressed: () {
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
