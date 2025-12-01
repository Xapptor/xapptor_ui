import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget disclosure_personal_data({
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
            "Disclosure of Your Personal Data",
            type: CustomTitleType.type2,
            text_color: txt_color,
          ),
          custom_title(
            "Business Transactions",
            type: CustomTitleType.type3,
            text_color: txt_color,
          ),
          custom_text(
            "If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.",
            margin: margin_text_2,
            text_color: txt_color,
          ),
          custom_title(
            "Law enforcement",
            type: CustomTitleType.type3,
            text_color: txt_color,
          ),
          custom_text(
            "Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).",
            margin: margin_text_2,
            text_color: txt_color,
          ),
          custom_title(
            "Other legal requirements",
            type: CustomTitleType.type3,
            text_color: txt_color,
          ),
          custom_text(
            "The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:",
            text_color: txt_color,
          ),
          custom_text(
            "Comply with a legal obligation",
            text_color: txt_color,
          ),
          custom_text(
            "Protect and defend the rights or property of the Company",
            text_color: txt_color,
          ),
          custom_text(
            "Prevent or investigate possible wrongdoing in connection with the Service",
            text_color: txt_color,
          ),
          custom_text(
            "Protect the personal safety of Users of the Service or the public",
            text_color: txt_color,
          ),
          custom_text(
            "Protect against legal liability",
            text_color: txt_color,
          ),
        ],
      ),
    );
  }
}
