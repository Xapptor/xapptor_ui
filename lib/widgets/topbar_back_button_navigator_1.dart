import 'package:flutter/material.dart';

Widget topbar_back_button_navigator_1({
  required BuildContext context,
  required Color background_color,
}) {
  return Container(
    color: background_color,
    height: 60,
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Spacer(flex: 6),
      ],
    ),
  );
}
