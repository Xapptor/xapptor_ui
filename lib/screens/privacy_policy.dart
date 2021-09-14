import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_platform/universal_platform.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    required this.url_base,
    required this.use_topbar,
  });

  final String url_base;
  final bool use_topbar;

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String src = "";

  check_src() async {
    src = UniversalPlatform.isWeb
        ? await rootBundle.loadString("assets/privacy_policy.html")
        : "${widget.url_base}/#/privacy_policy";
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
              background_color: color_lum_topbar,
              has_back_button: true,
              actions: [],
              custom_leading: null,
              logo_path: "assets/images/logo.png",
              logo_color: Colors.white,
            )
          : null,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: widget.use_topbar ? 0.8 : 1,
              child: Container(
                color: Colors.white,
                child: Webview(
                  src: src,
                  id: Uuid().v4(),
                  function: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
