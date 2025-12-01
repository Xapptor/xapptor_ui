import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget personal_data({
    Color? background_color,
    Color? text_color,
  }) {
    final Color bg_color = background_color ?? Colors.white;
    final Color txt_color = text_color ?? Colors.black87;
    return Container(
      color: bg_color,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title(
            "Collecting and Using Your Personal Data",
            type: CustomTitleType.type1,
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_title(
            "Types of Data Collected",
            type: CustomTitleType.type2,
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_title(
            "Personal Data",
            type: CustomTitleType.type3,
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_text(
            "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:",
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_text(
            "Email address",
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_text(
            "First name and last name",
            text_color: txt_color,
            background_color: bg_color,
          ),
          custom_text(
            "Usage Data",
            text_color: txt_color,
            background_color: bg_color,
          ),
        ],
      ),
    );
  }
}
