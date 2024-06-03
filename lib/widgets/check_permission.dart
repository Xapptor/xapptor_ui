// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xapptor_ui/utils/copy_to_clipboard.dart';

// Check permission.

Future<bool> check_permission({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String title,
  required String label_no,
  required String label_yes,
  required Permission permission_type,
  bool is_last_permission_asked = true,
  Function(bool granted)? callback,
}) async {
  PermissionStatus permission_status = await permission_type.request();

  bool is_granted = permission_status.isGranted;
  if (!is_granted) {}

  if (is_granted) {
    if (callback != null) {
      callback(permission_status.isGranted);
    }
    return true;
  } else {
    if (context.mounted) {
      _check_platform_and_browser(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        title: title,
        label_no: label_no,
        label_yes: label_yes,
        permission_type_label: permission_type.toString().split(".").last,
        callback: () {
          if (callback != null) {
            callback(permission_status.isGranted);
            if (is_last_permission_asked) {
              Navigator.pop(context);
            }
          }
        },
      );
    }
    return false;
  }
}

_check_platform_and_browser({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String title,
  required String label_no,
  required String label_yes,
  required String permission_type_label,
  required Function callback,
}) {
  if (UniversalPlatform.isWeb) {
    if (platform_name.contains("macos") && browser_name.contains("safari")) {
      String message = """
1) Click on "Safari" in the menu bar at the top left of the screen.
2) Select "Settings" from the drop-down menu.
3) Click on Website -> $permission_type_label
""";

      _call_info_settings_alert(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        title: title,
        message: message,
        label_yes: label_yes,
        permission_type_label: permission_type_label,
        callback: callback,
      );
    } else {
      _platform_dependant_action(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        title: title,
        label_no: label_no,
        label_yes: label_yes,
        permission_type_label: permission_type_label,
        callback: callback,
      );
    }
  } else {
    _platform_dependant_action(
      platform_name: platform_name,
      browser_name: browser_name,
      context: context,
      title: title,
      label_no: label_no,
      label_yes: label_yes,
      permission_type_label: permission_type_label,
      callback: callback,
    );
  }
}

_call_info_settings_alert({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String title,
  required String message,
  required String label_yes,
  required String permission_type_label,
  required Function callback,
}) {
  Widget button_yes = TextButton(
    child: Text(label_yes),
    onPressed: () {
      callback();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
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

// Platform and Browser dependant action.

_platform_dependant_action({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String title,
  required String label_no,
  required String label_yes,
  required String permission_type_label,
  required Function callback,
}) {
  if (UniversalPlatform.isMobile) {
    openAppSettings();
  } else if (UniversalPlatform.isWeb) {
    if (platform_name.contains("ios")) {
      String settings_path = "prefs:root=SAFARI&path=$permission_type_label";
      launchUrlString(settings_path);
    } else if (platform_name.contains("android")) {
      String message = """
1) To the right of the address bar, tap More and then Settings.
2) Under "Advanced," tap Site settings.
3) Tap the $permission_type_label permission.
""";

      _call_info_settings_alert(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        title: title,
        message: message,
        label_yes: label_yes,
        permission_type_label: permission_type_label,
        callback: callback,
      );
    } else {
      _encourage_give_web_permission(
        platform_name: platform_name,
        browser_name: browser_name,
        context: context,
        title: title,
        label_no: label_no,
        label_yes: label_yes,
        permission_type_label: permission_type_label,
        callback: callback,
      );
    }
  }
}

// Open alert dialog to encourage give permission.

_encourage_give_web_permission({
  required String platform_name,
  required String browser_name,
  required BuildContext context,
  required String title,
  required String label_no,
  required String label_yes,
  required String permission_type_label,
  required Function callback,
}) {
  String settings_path = "";
  bool copy_settings_to_clipboard = true;

  if (browser_name.contains("firefox") || browser_name.contains("tor")) {
    settings_path = "about:preferences";
  } else if (browser_name.contains("duckduckgo")) {
    settings_path = "Left side of the SearchBar";
    copy_settings_to_clipboard = false;
  } else {
    settings_path = "$browser_name://settings/content/$permission_type_label";
  }

  Widget button_yes = TextButton(
    child: Text(label_yes),
    onPressed: () {
      Navigator.pop(context);
      if (copy_settings_to_clipboard) {
        copy_to_clipboard(
          data: settings_path,
          message: "Settings path \"$settings_path\" copied to clipboard",
          context: context,
        );
      }
      callback();
    },
  );

  String message =
      "If your browser is $browser_name, you must go to \"$settings_path\" to give the $permission_type_label permission.";

  AlertDialog alert = AlertDialog(
    title: const Text("Permission Required"),
    content: Text(
      message,
    ),
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
