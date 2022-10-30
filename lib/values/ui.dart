import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

// General UI data.

double sized_box_space = 14;
double outline_border_radius = 20;
double outline_width = 3;
double outline_padding = 15;
double logo_height(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.3 : 0.1);
}

double logo_width(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.6 : 0.2);
}
