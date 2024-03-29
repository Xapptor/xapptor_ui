import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';

// Check permission.

Future<bool> check_permission({
  required BuildContext context,
  required String message,
  required String message_no,
  required String message_yes,
  required Permission permission_type,
}) async {
  bool must_encourage_give_permission = false;

  if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
    PermissionStatus status = await permission_type.request();
    if (!status.isGranted) {
      must_encourage_give_permission = true;
    }
  }

  if (must_encourage_give_permission) {
    if (context.mounted) {
      encourage_give_permission(
        context: context,
        message: message,
        message_no: message_no,
        message_yes: message_yes,
      );
    }
    return !must_encourage_give_permission;
  } else {
    return !must_encourage_give_permission;
  }
}

// Open alert dialog to encourage give permission.

encourage_give_permission({
  required BuildContext context,
  required String message,
  required String message_no,
  required String message_yes,
}) {
  Widget button_no = TextButton(
    child: Text(message_no),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget button_yes = TextButton(
    child: Text(message_yes),
    onPressed: () {
      openAppSettings();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(message),
    //content: Text(message),
    actions: [
      button_no,
      button_yes,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
