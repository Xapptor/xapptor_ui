import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

set_orientations({required Function callback}) async {
  List<DeviceOrientation> preferred_orientations = [DeviceOrientation.portraitUp];
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (UniversalPlatform.isIOS) {
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.name.toLowerCase().contains("ipad")) {
      debugPrint("this is a ipad 5");
      preferred_orientations = [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ];
    }
  }
  SystemChrome.setPreferredOrientations(preferred_orientations).then((value) {
    callback();
  });
}
