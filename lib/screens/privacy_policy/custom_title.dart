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
}) {
  return Container(
    color: Colors.white,
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
        color: Colors.black87,
      ),
    ),
  );
}
