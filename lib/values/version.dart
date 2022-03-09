import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_platform/universal_platform.dart';

// Return Xapptor and App version.

Future<String> current_app_version() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String app_name = packageInfo.appName[0].toUpperCase() +
      packageInfo.appName.substring(
        1,
        packageInfo.appName.length,
      );
  String platform_char = "";

  if (UniversalPlatform.isAndroid) {
    platform_char = "a";
  } else if (UniversalPlatform.isIOS) {
    platform_char = "i";
  } else if (UniversalPlatform.isWeb) {
    platform_char = "wb";
  }

  return "Xapptor Core 3.1.0 - ${app_name} ${packageInfo.version}_p_$platform_char";
}
