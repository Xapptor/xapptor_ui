import 'package:flutter/material.dart';

Widget custom_text(
  String text, {
  EdgeInsets margin = const EdgeInsets.only(bottom: 4),
}) {
  return Container(
    color: Colors.white,
    margin: margin,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}
