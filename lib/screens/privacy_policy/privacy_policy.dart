import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/screens/privacy_policy/privacy_policy_values.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_platform/universal_platform.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    required this.app_name,
    required this.company_name,
    required this.company_address,
    required this.company_country,
    required this.website,
    required this.email,
    required this.phone_number,
    required this.use_topbar,
    this.logo_color,
    required this.topbar_color,
    this.logo_path = "assets/images/logo.png",
  });

  final String app_name;
  final String company_name;
  final String company_address;
  final String company_country;
  final String website;
  final String email;
  final String phone_number;
  final bool use_topbar;
  final Color? logo_color;
  final Color topbar_color;
  final String logo_path;

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String src = "";
  PrivacypolicyValues privacy_policy = PrivacypolicyValues();

  // Selecting privacy policy source for each platform.

  check_src() async {
    src = UniversalPlatform.isWeb
        ? await rootBundle.loadString("assets/privacy_policy.html")
        : "${widget.website}/privacy_policy";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    check_src();
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
          child: Center(
            child: FractionallySizedBox(
              widthFactor: widget.use_topbar ? 0.9 : 1,
              child: Container(
                color: Colors.white,
                child: UniversalPlatform.isWeb
                    ? Column(
                        children: [
                          //
                          privacy_policy.introduction(
                            last_update_date: DateTime(
                              2022,
                              5,
                              1,
                            ),
                          ),
                          //
                          privacy_policy.interpretation_definitions(
                            app_name: widget.app_name,
                            company_name: widget.company_name,
                            company_address: widget.company_address,
                            company_country: widget.company_country,
                            website: widget.website,
                          ),
                          //
                          privacy_policy.collecting_data(),
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
                            email: widget.website,
                            phone_number: widget.phone_number,
                            website: widget.website,
                          ),
                          //
                        ],
                      )
                    : Webview(
                        src: src,
                        id: Uuid().v4(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
