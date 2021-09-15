String xapptor_core_version = "2.0.9";
String abeinstitute_version = "2.0.9";
String abe_insurance_version = "2.0.0";
String lum_version = "1.0.6";
String xapptor_version = "1.0.0";
CurrentApp current_app = CurrentApp.Abeinstitute;

String current_software_version() {
  String app_version = "";

  if (current_app == CurrentApp.Abeinstitute) {
    app_version = abeinstitute_version;
  } else if (current_app == CurrentApp.Abeinsurance) {
    app_version = abe_insurance_version;
  } else if (current_app == CurrentApp.Lum) {
    app_version = lum_version;
  } else if (current_app == CurrentApp.Xapptor) {
    app_version = xapptor_version;
  }

  return "Xapptor Core $xapptor_core_version - App $app_version";
}

enum CurrentApp {
  Abeinstitute,
  Abeinsurance,
  Lum,
  Xapptor,
}
