import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    required this.src,
    required this.use_topbar,
  });

  final String src;
  final bool use_topbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: use_topbar
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
              widthFactor: use_topbar ? 0.8 : 1,
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
