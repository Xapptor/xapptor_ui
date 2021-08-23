import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/crop_widget.dart';
import 'custom_colors.dart';

// General

double sized_box_space = 14;
double outline_border_radius = 20;
double outline_width = 3;
double outline_padding = 15;
double logo_height(BuildContext context) {
  bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return MediaQuery.of(context).size.width * (portrait ? 0.3 : 0.1);
}

double logo_width(BuildContext context) {
  bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return MediaQuery.of(context).size.width * (portrait ? 0.6 : 0.2);
}

// Abeinstitute

double card_elevation_abeinstitute = 0;
String logo_image_path_abeinstitute = "assets/images/logo.png";
bool has_language_picker_abeinstitute = true;

// Abeinstitute Insurance

double card_elevation_abeinstitute_insurance = 0;
String logo_image_path_abeinstitute_insurance = "assets/images/logo.png";
bool has_language_picker_abeinstitute_insurance = true;

custom_background_abeinstitute_insurance(BuildContext context) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width,
    child: Align(
      alignment: Alignment.bottomLeft,
      child: CropWidget(
        child: Image.asset(
          "assets/images/logo.png",
          color: color_abeinstitute_ocean_blue.withOpacity(0.40),
          fit: BoxFit.cover,
        ),
        general_alignment: Alignment.bottomLeft,
        vertical_alignment: Alignment.topCenter,
        horizontal_alignment: Alignment.centerRight,
        height_factor: 0.8,
        width_factor: 0.75,
      ),
    ),
  );
}

// Lum

double card_elevation_lum = 0;
// String logo_image_path_lum =
//     "https://firebasestorage.googleapis.com/v0/b/lumapp-d8eb7.appspot.com/o/images%2Flogos%2FLOGOTIPO.svg?alt=media&token=2789476c-744f-4a5c-9ebd-3a762d7e80e2";
String logo_image_path_lum = "assets/images/logo.png";

String logo_gotas_path_lum =
    "https://firebasestorage.googleapis.com/v0/b/lumapp-d8eb7.appspot.com/o/images%2Flogos%2FGOTAS%20AV.svg?alt=media&token=01f2e344-5dfb-48d8-9deb-e0c1718d3a5b";
bool has_language_picker_lum = false;

custom_background_lum() {
  return Stack(
    children: [
      Column(
        children: [
          Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: Webview(
              src: logo_gotas_path_lum,
              function: () {},
              id: Uuid().v4(),
            ),
          ),
        ],
      ),
      Container(
        color: Colors.white.withOpacity(0.9),
      ),
    ],
  );
}
