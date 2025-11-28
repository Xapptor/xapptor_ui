import 'package:flutter/material.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';

// General UI data.

const double sized_box_space = 16;
const double outline_border_radius = 16;
const double outline_width = 3;
const double outline_padding = 16;

double logo_height(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.3 : 0.1);
}

double logo_width(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.6 : 0.2);
}
