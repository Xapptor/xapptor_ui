import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    required this.src,
  });

  final String src;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        background_color: color_lum_topbar,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
        logo_color: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
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
