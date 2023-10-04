import 'package:flutter/material.dart';
export 'package:xapptor_ui/values/icons/font_awesome_flutter.dart';
import 'package:xapptor_ui/values/dimensions.dart';
import 'package:xapptor_ui/values/icons/font_awesome_flutter.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_model.dart';

on_custom_textfield_changed({
  required String value,
  required CustomTextFieldModel custom_textfield_model,
  required Function setState,
  required ValueNotifier<Color> enabled_border_color,
  required ValueNotifier<String> helper_text,
  required ValueNotifier<Color> helper_text_color,
  required ValueNotifier<Icon?> helper_icon,
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
        helper_icon.value = const Icon(
          FontAwesomeIcons.circleX,
          color: XapptorColors.error,
          size: Dimensions.d16,
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
