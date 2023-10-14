import 'package:flutter/material.dart';

var margin_title = const EdgeInsets.only(bottom: 10);

Widget custom_title_1(String text) {
  return Container(
    color: Colors.white,
    margin: margin_title,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

Widget custom_title_2(String text) {
  return Container(
    color: Colors.white,
    margin: margin_title,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}

Widget custom_title_3(String text) {
  return Container(
    color: Colors.white,
    margin: margin_title,
    child: SelectableText(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
