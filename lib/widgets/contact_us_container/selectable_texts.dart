import 'package:flutter/material.dart';

List<Widget> selectable_texts({
  required List<String> texts,
  required Color icon_color,
}) =>
    [
      Expanded(
        flex: 1,
        child: Icon(
          Icons.location_on,
          color: icon_color,
        ),
      ),
      const Spacer(flex: 1),
      Expanded(
        flex: 3,
        child: SelectableText(
          texts[7],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      const Spacer(flex: 2),
      Expanded(
        flex: 1,
        child: Icon(
          Icons.phone,
          color: icon_color,
        ),
      ),
      const Spacer(flex: 1),
      Expanded(
        flex: 2,
        child: SelectableText(
          texts[8],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      const Spacer(flex: 2),
      Expanded(
        flex: 1,
        child: Icon(
          Icons.email,
          color: icon_color,
        ),
      ),
      const Spacer(flex: 1),
      Expanded(
        flex: 4,
        child: SelectableText(
          texts[9],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    ];
