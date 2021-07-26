import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MadeByContainer extends StatelessWidget {
  MadeByContainer({
    required this.text,
    required this.text_color,
    required this.background_color,
  });

  final String text;
  final Color text_color;
  final Color background_color;

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      alignment: Alignment.center,
      height: portrait
          ? (MediaQuery.of(context).size.height / 18)
          : (MediaQuery.of(context).size.height / 28),
      width: MediaQuery.of(context).size.width,
      color: background_color,
      child: FractionallySizedBox(
        heightFactor: 0.7,
        widthFactor: 0.7,
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text_color,
            fontWeight: FontWeight.bold,
          ),
          minFontSize: 8,
          maxFontSize: 14,
          maxLines: 4,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
