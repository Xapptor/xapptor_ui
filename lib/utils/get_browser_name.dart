import 'package:device_info_plus/device_info_plus.dart';

Future<String> get_browser_name() async {
  DeviceInfoPlugin device_info_plugin = DeviceInfoPlugin();
  BaseDeviceInfo device_info = await device_info_plugin.deviceInfo;
  Map<String, dynamic> device_info_map = device_info.data;
  String browser_name = device_info_map["browserName"].toString().toLowerCase();

  if (browser_name.contains(".")) {
    browser_name = browser_name.split(".").last;
  }
  return browser_name;
}
