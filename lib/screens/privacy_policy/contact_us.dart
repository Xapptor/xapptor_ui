import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget contact_us({
    required String email,
    required String? phone_number,
    required String website,
  }) {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title(
            "Contact Us",
            type: CustomTitleType.type1,
          ),
          custom_text(
            "If you have any questions about this Privacy Policy, You can contact us:",
          ),
          custom_text(
            "By email: $email",
          ),
          custom_text(
            "By visiting this page on our website: $website",
          ),
          phone_number != null
              ? custom_text(
                  "By phone number: $phone_number",
                )
              : null,
        ].whereType<Widget>().toList(),
      ),
    );
  }
}
