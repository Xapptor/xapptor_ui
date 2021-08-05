import 'package:flutter/material.dart';

PreferredSizeWidget TopBar({
  required Color background_color,
  required List<Widget> actions,
  required bool has_back_button,
  required Widget? custom_leading,
  required String? logo_path,
}) {
  double topbar_height = 65;
  return PreferredSize(
    child: AppBar(
      leading: !has_back_button ? Container() : custom_leading,
      title: logo_path != null
          ? Image.asset(
              logo_path!,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              height: topbar_height,
              width: topbar_height,
            )
          : Container(
              height: topbar_height,
              width: topbar_height,
            ),
      backgroundColor: background_color,
      elevation: 0,
      actions: actions,
    ),
    preferredSize: Size.fromHeight(topbar_height),
  );
}
