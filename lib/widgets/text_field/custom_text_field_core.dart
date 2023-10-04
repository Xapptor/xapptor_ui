import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_model.dart';
import 'package:xapptor_ui/widgets/text_field/obscure_text_icon.dart';
import 'package:xapptor_ui/widgets/text_field/on_custom_text_field_changed.dart';

custom_textfield_core({
  required BuildContext context,
  required CustomTextFieldModel model,
  required Function setState,
  required ValueNotifier<Color> enabled_border_color,
  required ValueNotifier<String> helper_text,
  required ValueNotifier<Color> helper_text_color,
  required ValueNotifier<Icon?> helper_icon,
  required ValueNotifier<bool> show_obscure_text,
  required Color fill_color,
  required Function? on_changed,
}) {
  return TextFormField(
    enabled: model.enabled,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    onChanged: (String value) {
      if (on_changed != null) {
        on_changed(value);
      } else {
        on_custom_textfield_changed(
          value: value,
          custom_textfield_model: model,
          setState: setState,
          enabled_border_color: enabled_border_color,
          helper_text: helper_text,
          helper_text_color: helper_text_color,
          helper_icon: helper_icon,
          has_interacted_by_user: true,
        );
      }
    },
    decoration: InputDecoration(
      hintText: model.hint,
      suffixIcon: model.obscure_text
          ? obscure_text_icon(
              show_obscure_text: show_obscure_text.value,
              on_pressed: () {
                show_obscure_text.value = !show_obscure_text.value;
                setState(() {});
              },
            )
          : model.suffix_icon,
      fillColor: fill_color,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: enabled_border_color.value,
        ),
      ),
    ),
    controller: model.controller,
    focusNode: model.focus_node,
    onFieldSubmitted: model.on_field_submitted,
    keyboardType: model.keyboard_type,
    textInputAction: TextInputAction.next,
    inputFormatters: [
      if (model.input_formatters != null) ...model.input_formatters!,
      if (model.keyboard_type == const TextInputType.numberWithOptions(signed: true) ||
          model.keyboard_type ==
              const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ))
        FilteringTextInputFormatter.digitsOnly,
      if (model.length_limit != null) LengthLimitingTextInputFormatter(model.length_limit!),
    ],
    maxLines: model.max_lines,
    obscureText: model.obscure_text && !show_obscure_text.value,
    obscuringCharacter: model.obscuring_character,
  );
}
