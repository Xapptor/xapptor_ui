import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/dimensions.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';

custom_textfield_title({
  required String title,
  required String? subtitle,
  required bool enabled,
}) {
  return Container(
    margin: const EdgeInsets.only(
      bottom: Dimensions.d4,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: enabled ? XapptorColors.blue[700] : XapptorColors.neutral[700],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: XapptorColors.neutral[800],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    ),
  );
}
