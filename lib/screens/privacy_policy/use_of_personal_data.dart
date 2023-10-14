import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';

extension PrivacypolicyValuesExtension on PrivacypolicyValues {
  Widget use_of_personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Use of Your Personal Data",
          ),
          custom_text(
            "The Company may use Personal Data for the following purposes:",
          ),
          custom_text(
            "To provide and maintain our Service, including to monitor the usage of our Service.",
          ),
          custom_text(
            "To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.",
          ),
          custom_text(
            "For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.",
          ),
          custom_text(
            "To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.",
          ),
          custom_text(
            "To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.",
          ),
          custom_text(
            "To manage Your requests: To attend and manage Your requests to Us.",
          ),
          custom_text(
            "For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.",
          ),
          custom_text(
            "For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.",
          ),
          custom_text(
            "We may share Your personal information in the following situations:",
          ),
          custom_text(
            "With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.",
          ),
          custom_text(
            "For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.",
          ),
          custom_text(
            "With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.",
          ),
          custom_text(
            "With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.",
          ),
          custom_text(
            "With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.",
          ),
          custom_text(
            "With Your consent: We may disclose Your personal information for any other purpose with Your consent.",
          ),
        ],
      ),
    );
  }
}
