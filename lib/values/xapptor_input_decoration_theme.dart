import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';

InputDecorationTheme xapptor_input_decoration_theme = InputDecorationTheme(
  fillColor: Colors.white,
  filled: true,
  floatingLabelStyle: const TextStyle(
    color: XapptorColors.blue,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  labelStyle: TextStyle(
    color: XapptorColors.neutral[700],
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    color: XapptorColors.neutral[700],
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  helperStyle: TextStyle(
    color: XapptorColors.neutral[800],
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: XapptorColors.neutral[700]!,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: XapptorColors.neutral[700]!,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: XapptorColors.neutral[100]!,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: XapptorColors.blue,
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: XapptorColors.error,
    ),
  ),
);
