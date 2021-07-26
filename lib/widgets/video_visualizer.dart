import 'package:flutter/material.dart';
import 'package:xapptor_ui/webview/webview.dart';

class WebVideoVisualizer extends StatelessWidget {
  WebVideoVisualizer({
    required this.src,
  });

  final String src;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Webview(
          src: src,
          id: "",
          function: () {},
        ),
      ),
    );
  }
}
