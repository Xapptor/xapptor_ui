import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_model.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:universal_platform/universal_platform.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    required this.privacy_policy_model,
    required this.use_topbar,
    required this.topbar_color,
    this.logo_color,
    this.logo_path = "assets/images/logo.png",
    this.last_update_date,
  });

  final PrivacyPolicyModel privacy_policy_model;
  final bool use_topbar;
  final Color topbar_color;
  final Color? logo_color;
  final String logo_path;
  final DateTime? last_update_date;

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacypolicyValues privacy_policy = PrivacypolicyValues();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.use_topbar
          ? TopBar(
              background_color: widget.topbar_color,
              has_back_button: true,
              actions: [],
              custom_leading: null,
              logo_path: widget.logo_path,
              logo_color: widget.logo_color,
            )
          : null,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: FractionallySizedBox(
            widthFactor: widget.use_topbar ? 0.9 : 1,
            child: Container(
              color: Colors.white,
              child: UniversalPlatform.isWeb
                  ? SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            privacy_policy.introduction(
                              last_update_date:
                                  widget.last_update_date ?? DateTime.now(),
                            ),
                            //
                            privacy_policy.interpretation_definitions(
                              app_name: widget.privacy_policy_model.app_name,
                              company_name:
                                  widget.privacy_policy_model.company_name,
                              company_address:
                                  widget.privacy_policy_model.company_address,
                              company_country:
                                  widget.privacy_policy_model.company_country,
                              website: widget.privacy_policy_model.website,
                            ),
                            //
                            privacy_policy.personal_data(),
                            privacy_policy.usage_data(),
                            privacy_policy.information_collected(),
                            privacy_policy.use_of_personal_data(),
                            privacy_policy.retention_personal_data(),
                            privacy_policy.transfer_personal_data(),
                            privacy_policy.disclosure_personal_data(),
                            //
                            privacy_policy.security_personal_data(),
                            privacy_policy.children_privacy(),
                            privacy_policy.links_to_other_websites(),
                            privacy_policy.changes(),
                            privacy_policy.contact_us(
                              email: widget.privacy_policy_model.email,
                              phone_number:
                                  widget.privacy_policy_model.phone_number,
                              website: widget.privacy_policy_model.website,
                            ),
                            //
                          ],
                        ),
                      ),
                    )
                  : Webview(
                      src:
                          "${widget.privacy_policy_model.website}/privacy_policy",
                      id: Uuid().v4(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
