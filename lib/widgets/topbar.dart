import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/values/version.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

AppBar TopBar({
  required BuildContext context,
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
    title: GestureDetector(
      onLongPress: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(await current_app_version()),
            duration: Duration(seconds: 4),
          ),
        );
      },
      child: logo_path != null && logo_path.isNotEmpty
          ? logo_path.contains("https")
              ? Container(
                  height: topbar_height,
                  width: topbar_height,
                  child: Webview(
                    src: logo_path,
                    id: Uuid().v4(),
                  ),
                )
              : Image.asset(
                  logo_path,
                  height: topbar_height,
                  width: topbar_height,
                  color: logo_color,
                )
          : Container(),
    ),
    backgroundColor: background_color,
    elevation: 0,
    actions: actions,
  );
}
