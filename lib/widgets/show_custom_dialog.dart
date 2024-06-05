import 'package:flutter/material.dart';

show_custom_dialog({
  required BuildContext context,
  required String title,
  required String message,
  required String button_text,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(button_text),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
