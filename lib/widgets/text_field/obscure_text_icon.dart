import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xapptor_ui/values/dimensions.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';

IconButton obscure_text_icon({
  required bool show_obscure_text,
  required Function() on_pressed,
}) {
  return IconButton(
    icon: Icon(
      show_obscure_text ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeLowVision,
      size: Dimensions.d16,
      color: XapptorColors.blue,
    ),
    onPressed: on_pressed,
  );
}
