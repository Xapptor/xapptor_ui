import 'package:package_info_plus/package_info_plus.dart';

// Return Xapptor and App version

Future<String> current_app_version() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String app_name = packageInfo.appName[0].toUpperCase() +
      packageInfo.appName.substring(
        1,
        packageInfo.appName.length,
      );
  return "Xapptor 3.0.7 - ${app_name} ${packageInfo.version}";
}
