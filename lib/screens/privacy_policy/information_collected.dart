import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget information_collected({
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
            "Information Collected while Using the Application",
            type: CustomTitleType.type3,
            text_color: txt_color,
          ),
          custom_text(
            "While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:",
            text_color: txt_color,
          ),
          custom_text(
            "Pictures and other information from your Device's camera and photo library",
            text_color: txt_color,
          ),
          custom_text(
            "We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.",
            text_color: txt_color,
          ),
          custom_text(
            "You can enable or disable access to this information at any time, through Your Device settings.",
            text_color: txt_color,
          ),
        ],
      ),
    );
  }
}
