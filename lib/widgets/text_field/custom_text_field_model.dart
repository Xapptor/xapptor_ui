import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFieldModel {
  final String title;
  final String? hint;
  final String? subtitle;
  final FocusNode focus_node;
  final Function(String fieldValue)? on_field_submitted;
  final TextInputType? keyboard_type;
  final int? max_lines;
  final String description;
  final TextEditingController controller;
  final int? length_limit;
  final Widget? suffix_icon;
  final bool enabled;
  final String? Function(String?)? validator;
  final FaIcon? helper_icon;
  final bool obscure_text;
  final String obscuring_character;
  final bool show_length_limit_counter;
  final List<TextInputFormatter>? input_formatters;
  final AutovalidateMode autovalidate_mode;
  final Color? fill_color;
  final Color? enabled_border_color;
  final Function? on_changed;

  const CustomTextFieldModel({
    required this.title,
    this.hint,
    this.subtitle,
    required this.focus_node,
    required this.on_field_submitted,
    this.keyboard_type = TextInputType.text,
    this.max_lines,
    this.description = "",
    required this.controller,
    this.length_limit,
    this.suffix_icon,
    this.enabled = true,
    this.validator,
    this.helper_icon,
    this.obscure_text = false,
    this.obscuring_character = "•",
    this.show_length_limit_counter = false,
    this.input_formatters,
    this.autovalidate_mode = AutovalidateMode.always,
    this.fill_color,
    this.enabled_border_color,
    this.on_changed,
  });
}
