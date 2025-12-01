import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/screens/privacy_policy/contact_us.dart';
import 'package:xapptor_ui/screens/privacy_policy/disclosure_personal_data.dart';
import 'package:xapptor_ui/screens/privacy_policy/information_collected.dart';
import 'package:xapptor_ui/screens/privacy_policy/personal_data.dart';
import 'package:xapptor_ui/screens/privacy_policy/use_of_personal_data.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_model.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_ui/widgets/top_and_bottom/topbar.dart';
import 'package:universal_platform/universal_platform.dart';

class PrivacyPolicy extends StatefulWidget {
  final PrivacyPolicyModel privacy_policy_model;
  final bool use_topbar;
  final Color topbar_color;
  final Color? logo_color;
  final String logo_path;
  final DateTime? last_update_date;

  /// Background color for the privacy policy screen.
  /// Defaults to Colors.white if not specified.
  final Color? background_color;

  /// Text color for the privacy policy content.
  /// Defaults to black/dark text if not specified.
  final Color? text_color;

  /// Back button icon color.
  /// Defaults to Colors.white if not specified.
  final Color? back_button_color;

  const PrivacyPolicy({
    super.key,
    required this.privacy_policy_model,
    required this.use_topbar,
    required this.topbar_color,
    this.logo_color,
    this.logo_path = "assets/images/logo.png",
    this.last_update_date,
    this.background_color,
    this.text_color,
    this.back_button_color,
  });

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacypolicyValues privacy_policy = PrivacypolicyValues();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = is_portrait(context);

    // Use provided background color or default to white
    final Color bg_color = widget.background_color ?? Colors.white;
    final Color txt_color = widget.text_color ?? Colors.black87;

    return Scaffold(
      backgroundColor: bg_color,
      appBar: widget.use_topbar
          ? TopBar(
              context: context,
              background_color: widget.topbar_color,
              has_back_button: true,
              actions: [],
              custom_leading: null,
              logo_path: widget.logo_path,
              logo_color: widget.logo_color,
              back_button_color: widget.back_button_color,
            )
          : null,
      body: SafeArea(
        child: Container(
          width: screen_width,
          color: bg_color,
          child: UniversalPlatform.isWeb
              ? SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: portrait ? 0.85 : 0.5,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: Theme.of(context).textTheme.apply(
                              bodyColor: txt_color,
                              displayColor: txt_color,
                            ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          //
                          privacy_policy.introduction(
                            last_update_date: widget.last_update_date ?? DateTime.now(),
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          //
                          privacy_policy.interpretation(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.definitions(
                            app_name: widget.privacy_policy_model.app_name,
                            company_name: widget.privacy_policy_model.company_name,
                            company_address: widget.privacy_policy_model.company_address,
                            company_country: widget.privacy_policy_model.company_country,
                            website: widget.privacy_policy_model.website,
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          //
                          privacy_policy.personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.usage_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.information_collected(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.use_of_personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.retention_personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.transfer_personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.disclosure_personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          //
                          privacy_policy.security_personal_data(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.children_privacy(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.links_to_other_websites(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.changes(
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          privacy_policy.contact_us(
                            email: widget.privacy_policy_model.email,
                            phone_number: widget.privacy_policy_model.phone_number,
                            website: widget.privacy_policy_model.website,
                            background_color: bg_color,
                            text_color: txt_color,
                          ),
                          //
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                )
              : Webview(
                  src: "${widget.privacy_policy_model.website}/privacy_policy",
                  id: const Uuid().v8(),
                ),
        ),
      ),
    );
  }
}
