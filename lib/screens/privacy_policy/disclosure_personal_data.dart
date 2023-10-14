import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget disclosure_personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Disclosure of Your Personal Data",
          ),
          custom_title_3(
            "Business Transactions",
          ),
          custom_text(
            "If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.",
            margin: margin_text_2,
          ),
          custom_title_3(
            "Law enforcement",
          ),
          custom_text(
            "Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).",
            margin: margin_text_2,
          ),
          custom_title_3(
            "Other legal requirements",
          ),
          custom_text(
            "The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:",
          ),
          custom_text(
            "Comply with a legal obligation",
          ),
          custom_text(
            "Protect and defend the rights or property of the Company",
          ),
          custom_text(
            "Prevent or investigate possible wrongdoing in connection with the Service",
          ),
          custom_text(
            "Protect the personal safety of Users of the Service or the public",
          ),
          custom_text(
            "Protect against legal liability",
          ),
        ],
      ),
    );
  }
}
