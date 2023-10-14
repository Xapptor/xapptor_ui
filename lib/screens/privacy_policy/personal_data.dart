import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Collecting and Using Your Personal Data",
          ),
          custom_title_2(
            "Types of Data Collected",
          ),
          custom_title_3(
            "Personal Data",
          ),
          custom_text(
            "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:",
          ),
          custom_text(
            "Email address",
          ),
          custom_text(
            "First name and last name",
          ),
          custom_text(
            "Usage Data",
          ),
        ],
      ),
    );
  }
}
