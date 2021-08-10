String xapptor_core_version = "3.0.1";
String abeinstitute_version = "2.0.1";
String abe_insurance_version = "2.0.0";
String emissor_version = "2.0.0";
String lum_version = "1.0.0";
String xapptor_version = "1.0.0";
CurrentApp current_app = CurrentApp.Abeinstitute;

String current_software_version() {
  String app_name_char = "";
  String app_version = "";

  if (current_app == CurrentApp.Abeinstitute) {
    app_name_char = "a";
    app_version = abeinstitute_version;
  } else if (current_app == CurrentApp.AbeinstituteInsurance) {
    app_name_char = "ai";
    app_version = abe_insurance_version;
  } else if (current_app == CurrentApp.Emissor) {
    app_name_char = "e";
    app_version = emissor_version;
  } else if (current_app == CurrentApp.Lum) {
    app_name_char = "l";
    app_version = lum_version;
  } else if (current_app == CurrentApp.Xapptor) {
    app_name_char = "x";
    app_version = xapptor_version;
  }

  return "xcv$xapptor_core_version-${app_name_char}v$app_version";
}

enum CurrentApp {
  Abeinstitute,
  AbeinstituteInsurance,
  Lum,
  Emissor,
  Xapptor,
}
