// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Check permission.

Future<bool> check_permission({
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

  //if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
  is_granted = status.isGranted;
  if (!is_granted) {
    must_encourage_give_permission = true;
  }
  //}

  if (is_granted) {
    return true;
  } else {
    if (must_encourage_give_permission) {
      if (context.mounted) {
        _encourage_give_permission(
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

// Open alert dialog to encourage give permission.

_encourage_give_permission({
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
      _platform_and_browser_dependant_action(
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

_platform_and_browser_dependant_action({
  required BuildContext context,
  required String message_yes,
  required Permission permission_type,
}) async {
  if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
    openAppSettings();
  } else if (UniversalPlatform.isWeb) {
    String platform_name = defaultTargetPlatform.name.toLowerCase();

    DeviceInfoPlugin device_info_plugin = DeviceInfoPlugin();
    BaseDeviceInfo device_info = await device_info_plugin.deviceInfo;
    Map<String, dynamic> device_info_map = device_info.data;

    String browser_name = device_info_map["browserName"].toString();
    browser_name = browser_name.toLowerCase();
    if (browser_name.contains(".")) {
      browser_name = browser_name.split(".").last;
    }

    debugPrint("platform_name: $platform_name");
    debugPrint("browser_name: $browser_name");

    if (platform_name == "ios") {
      String settings_path = "prefs:root=SAFARI&path=${permission_type.toString().split(".").last}";
      launchUrlString(settings_path);
    } else if (platform_name == "android") {
      openAppSettings();
    } else if (platform_name == "macos") {
      if (browser_name == "safari") {
        _call_safari_alert(
          context: context,
          message_yes: message_yes,
          permission_type: permission_type,
        );
      } else if (browser_name == "chrome" ||
          browser_name == "edge" ||
          browser_name == "opera" ||
          browser_name == "brave") {
        _call_settings_path(
          browser_name: browser_name,
          permission_type: permission_type,
        );
      } else if (browser_name == "firefox") {
        _call_settings_path(
          browser_name: browser_name,
          permission_type: permission_type,
        );
      } else if (browser_name == "samsunginternet") {
        _call_settings_path(
          browser_name: browser_name,
          permission_type: permission_type,
        );
      } else if (browser_name == "duckduckgobrowser") {
        _call_settings_path(
          browser_name: browser_name,
          permission_type: permission_type,
        );
      } else if (browser_name == "chromium") {
        _call_settings_path(
          browser_name: browser_name,
          permission_type: permission_type,
        );
      }
    }
  }
}

_call_settings_path({
  required String browser_name,
  required Permission permission_type,
}) {
  String settings_path = "";

  if (browser_name == "safari") {
  } else if (browser_name == "firefox" || browser_name == "tor") {
    settings_path = "about:preferences";
  } else {
    settings_path = "$browser_name://settings/content/${permission_type.toString().split(".").last}";
  }
  launchUrlString(settings_path);
}

_call_safari_alert({
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
