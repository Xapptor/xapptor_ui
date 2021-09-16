String xapptor_core_version = "3.0.0";
String abe_insurance_version = "2.0.0";
String lum_version = "1.0.6";
String xapptor_version = "1.0.0";
CurrentApp current_app = CurrentApp.Lum;

String current_software_version({
  required String app_version,
}) {
  return "Xapptor Core $xapptor_core_version - App $app_version";
}

enum CurrentApp {
  Abeinsurance,
  Lum,
  Xapptor,
}
