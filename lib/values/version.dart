String xapptor_core_version = "3.0.0";
String abeinstitute_version = "2.0.0";
String abe_insurance_version = "2.0.0";
String emissor_version = "2.0.0";
String lum_version = "1.0.0";
String xapptor_version = "1.0.0";
String app_name = "";

String current_software_version() {
  String app_name_char = "";
  String app_version = "";

  if (app_name == "abeinstitute") {
    app_name_char = "a";
    app_version = abeinstitute_version;
  } else if (app_name == "abeinstitute_insurance") {
    app_name_char = "ai";
    app_version = abe_insurance_version;
  } else if (app_name == "emissor") {
    app_name_char = "e";
    app_version = emissor_version;
  } else if (app_name == "lum") {
    app_name_char = "l";
    app_version = lum_version;
  } else if (app_name == "xapptor") {
    app_name_char = "x";
    app_version = xapptor_version;
  }

  return "xcv$xapptor_core_version-${app_name_char}v$app_version";
}
