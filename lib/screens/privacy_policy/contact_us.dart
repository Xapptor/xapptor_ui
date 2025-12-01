import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget contact_us({
    required String email,
    required String? phone_number,
    required String website,
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
            "Contact Us",
            type: CustomTitleType.type1,
            text_color: txt_color,
          ),
          custom_text(
            "If you have any questions about this Privacy Policy, You can contact us:",
            text_color: txt_color,
          ),
          custom_text(
            "By email: $email",
            text_color: txt_color,
          ),
          custom_text(
            "By visiting this page on our website: $website",
            text_color: txt_color,
          ),
          phone_number != null
              ? custom_text(
                  "By phone number: $phone_number",
                  text_color: txt_color,
                )
              : null,
        ].whereType<Widget>().toList(),
      ),
    );
  }
}
