import 'package:flutter/material.dart';

Widget custom_text(
  String text, {
  EdgeInsets margin = const EdgeInsets.only(bottom: 4),
  Color? text_color,
  Color? background_color,
}) {
  final Color txt_color = text_color ?? Colors.black87;
  final Color bg_color = background_color ?? Colors.white;
  return Container(
    color: bg_color,
    margin: margin,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: txt_color,
      ),
    ),
  );
}
