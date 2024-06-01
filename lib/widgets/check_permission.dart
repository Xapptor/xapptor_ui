// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Check permission.

Future<bool> check_permission({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String message,
  required String message_no,
  required String message_yes,
  required Permission permission_type,
  Function(bool granted)? callback,
}) async {
  bool must_encourage_give_permission = false;
  bool is_granted = false;

  PermissionStatus status = await permission_type.request().then((new_status) {
    if (callback != null) {
      callback(new_status.isGranted);
    }
    return new_status;
  });

  is_granted = status.isGranted;
  if (!is_granted) {
    must_encourage_give_permission = true;
  }

  if (is_granted) {
    return true;
  } else {
    if (must_encourage_give_permission) {
      if (context.mounted) {
        _check_platform_and_browser(
          platform_name: platform_name,
          browser_name: browser_name,
          context: context,
          message: message,
          message_no: message_no,
          message_yes: message_yes,
          permission_type: permission_type,
        );
      }
      return false;
    } else {
      return false;
    }
  }
}

_check_platform_and_browser({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String message,
  required String message_no,
  required String message_yes,
  required Permission permission_type,
}) {
  if (UniversalPlatform.isWeb) {
    if (platform_name.contains("macos") && browser_name.contains("safari")) {
      _call_macos_safari_alert(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        message_yes: message_yes,
        permission_type: permission_type,
      );
    } else {
      _encourage_give_permission(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        message: message,
        message_no: message_no,
        message_yes: message_yes,
        permission_type: permission_type,
      );
    }
  } else {
    _encourage_give_permission(
      platform_name: platform_name,
      browser_name: browser_name,
      context: context,
      message: message,
      message_no: message_no,
      message_yes: message_yes,
      permission_type: permission_type,
    );
  }
}

_call_macos_safari_alert({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String message_yes,
  required Permission permission_type,
}) {
  String message = """
1) Click on "Safari" in the menu bar at the top left of the screen.
2) Select "Settings" from the drop-down menu.
3) Click on Website -> $permission_type
""";

  Widget button_yes = TextButton(
    child: Text(message_yes),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Permission Required"),
    content: Text(message),
    actions: [
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

// Open alert dialog to encourage give permission.

_encourage_give_permission({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String message,
  required String message_no,
  required String message_yes,
  required Permission permission_type,
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
      Navigator.of(context).pop();
      _platform_dependant_action(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        message_yes: message_yes,
        permission_type: permission_type,
      );
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Permission Required"),
    content: Text(message),
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

// Platform and Browser dependant action.

_platform_dependant_action({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String message_yes,
  required Permission permission_type,
}) {
  if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
    openAppSettings();
  } else if (UniversalPlatform.isWeb) {
    if (platform_name.contains("ios")) {
      String settings_path = "prefs:root=SAFARI&path=${permission_type.toString().split(".").last}";
      launchUrlString(settings_path);
    } else if (platform_name.contains("android")) {
      Navigator.of(context).pop();
    } else {
      _desktop_browser_dependant_action(
        browser_name: browser_name,
        context: context,
        message_yes: message_yes,
        permission_type: permission_type,
      );
    }
  }
}

_desktop_browser_dependant_action({
  required String browser_name,
  required BuildContext context,
  required String message_yes,
  required Permission permission_type,
}) {
  String settings_path = "";

  if (browser_name.contains("firefox") || browser_name.contains("tor")) {
    settings_path = "about:preferences";
    launchUrlString(settings_path);
  } else if (browser_name.contains("duckduckgo")) {
    Navigator.pop(context);
  } else {
    settings_path = "$browser_name://settings/content/${permission_type.toString().split(".").last}";
    launchUrlString(settings_path);
  }
}
