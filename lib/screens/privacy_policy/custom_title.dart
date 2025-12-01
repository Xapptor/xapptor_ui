import 'package:flutter/material.dart';

var _margin_title = const EdgeInsets.only(bottom: 10);

enum CustomTitleType {
  type1,
  type2,
  type3,
}

Widget custom_title(
  String text, {
  required CustomTitleType type,
  Color? text_color,
  Color? background_color,
}) {
  final Color txt_color = text_color ?? Colors.black87;
  final Color bg_color = background_color ?? Colors.white;
  return Container(
    color: bg_color,
    margin: _margin_title,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: type == CustomTitleType.type1
            ? 20
            : type == CustomTitleType.type2
                ? 18
                : 16,
        color: txt_color,
      ),
    ),
  );
}
