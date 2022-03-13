import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_platform/universal_platform.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    required this.base_url,
    required this.use_topbar,
    this.logo_color,
    required this.topbar_color,
    this.logo_path = "assets/images/logo.png",
  });

  final String base_url;
  final bool use_topbar;
  final Color? logo_color;
  final Color topbar_color;
  final String logo_path;

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String src = "";

  // Selecting privacy policy source for each platform.

  check_src() async {
    src = UniversalPlatform.isWeb
        ? await rootBundle.loadString("assets/privacy_policy.html")
        : "${widget.base_url}/privacy_policy";
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
                child: Webview(
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
