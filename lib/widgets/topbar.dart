import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

AppBar TopBar({
  required Color background_color,
  required List<Widget> actions,
  required bool has_back_button,
  required Widget? custom_leading,
  String? logo_path,
  Color? logo_color,
}) {
  double topbar_height = 65;
  return AppBar(
    leading: !has_back_button ? Container() : custom_leading,
    centerTitle: false,
    title: logo_path != null && logo_path.isNotEmpty
        ? logo_path.contains("https")
            ? Container(
                height: topbar_height,
                width: topbar_height,
                child: Webview(
                  src: logo_path,
                  id: Uuid().v4(),
                  function: () {},
                ),
              )
            : Image.asset(
                logo_path,
                height: topbar_height,
                width: topbar_height,
                color: logo_color,
              )
        : Container(),
    backgroundColor: background_color,
    elevation: 0,
    actions: actions,
  );
}
