import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_model.dart';

on_custom_textfield_changed({
  required String value,
  required CustomTextFieldModel custom_textfield_model,
  required Function setState,
  required ValueNotifier<Color> enabled_border_color,
  required ValueNotifier<String> helper_text,
  required ValueNotifier<Color> helper_text_color,
  required ValueNotifier<FaIcon?> helper_icon,
  required bool has_interacted_by_user,
}) {
  helper_icon.value = custom_textfield_model.helper_icon;
  if (custom_textfield_model.validator != null) {
    if (custom_textfield_model.autovalidate_mode == AutovalidateMode.always ||
        (custom_textfield_model.autovalidate_mode == AutovalidateMode.onUserInteraction && has_interacted_by_user)) {
      String current_text = custom_textfield_model.controller.text;
      String? validation = custom_textfield_model.validator!(current_text);

      if (validation != null) {
        enabled_border_color.value = XapptorColors.error;
        helper_text.value = validation;
        helper_text_color.value = XapptorColors.error;
        helper_icon.value = const FaIcon(
          FontAwesomeIcons.circleXmark,
          color: XapptorColors.error,
          size: 16,
        );
      } else {
        enabled_border_color.value = XapptorColors.neutral[800]!;
        helper_text.value = custom_textfield_model.description;
        helper_text_color.value = XapptorColors.neutral[800]!;
        helper_icon.value = null;
      }
    }
  }
  setState(() {});
}
