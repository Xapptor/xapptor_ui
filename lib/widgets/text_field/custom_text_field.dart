import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/xapptor_theme.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_core.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_helper.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_model.dart';
import 'package:xapptor_ui/widgets/text_field/custom_text_field_title.dart';
import 'package:xapptor_ui/widgets/text_field/on_custom_text_field_changed.dart';

class CustomTextField extends StatefulWidget {
  final CustomTextFieldModel model;

  const CustomTextField({
    super.key,
    required this.model,
  });

  String? validate() {
    String? validated;
    if (model.validator != null) {
      validated = model.validator!(model.controller.text);
    }
    return validated;
  }

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late Color fill_color = widget.model.fill_color ?? Colors.white;
  late ValueNotifier<Color> enabled_border_color =
      ValueNotifier(widget.model.enabled_border_color ?? XapptorColors.neutral[800]!);
  ValueNotifier<String> helper_text = ValueNotifier("");
  ValueNotifier<Color> helper_text_Color = ValueNotifier(XapptorColors.neutral[800]!);
  ValueNotifier<Icon?> helper_icon = ValueNotifier(null);
  ValueNotifier<bool> show_obscure_text = ValueNotifier(false);

  void custom_validate() {
    on_custom_textfield_changed(
      value: widget.model.controller.text,
      custom_textfield_model: widget.model,
      setState: setState,
      enabled_border_color: enabled_border_color,
      helper_text: helper_text,
      helper_text_color: helper_text_Color,
      helper_icon: helper_icon,
      has_interacted_by_user: true,
    );
  }

  @override
  void initState() {
    super.initState();
    helper_text.value = widget.model.description;

    String textfield_value = widget.model.controller.text;

    if (widget.model.on_changed != null) {
      widget.model.on_changed!(textfield_value);
    } else {
      on_custom_textfield_changed(
        value: textfield_value,
        custom_textfield_model: widget.model,
        setState: setState,
        enabled_border_color: enabled_border_color,
        helper_text: helper_text,
        helper_text_color: helper_text_Color,
        helper_icon: helper_icon,
        has_interacted_by_user: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: xapptor_theme,
      child: Focus(
        onFocusChange: (hasFocus) {
          fill_color = (hasFocus ? XapptorColors.blue[100] : widget.model.fill_color ?? Colors.white)!;
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            custom_textfield_title(
              title: widget.model.title,
              subtitle: widget.model.subtitle,
              enabled: widget.model.enabled,
            ),
            custom_textfield_core(
              context: context,
              model: widget.model,
              setState: setState,
              enabled_border_color: enabled_border_color,
              helper_text: helper_text,
              helper_text_color: helper_text_Color,
              helper_icon: helper_icon,
              show_obscure_text: show_obscure_text,
              fill_color: fill_color,
              on_changed: widget.model.on_changed,
            ),
            custom_textfield_helper(
              context: context,
              helper_text: helper_text.value,
              helper_text_color: helper_text_Color.value,
              helper_icon: helper_icon,
              length_limit: widget.model.length_limit,
              show_length_limit_counter: widget.model.show_length_limit_counter,
              text_length: widget.model.controller.text.length,
            ),
          ],
        ),
      ),
    );
  }
}
