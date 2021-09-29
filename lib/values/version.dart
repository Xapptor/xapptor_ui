import 'package:package_info_plus/package_info_plus.dart';

Future<String> current_software_version() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return "Xapptor 3.0.6 - ${packageInfo.appName} ${packageInfo.version}";
}
