import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

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
          id: Uuid().v4(),
          function: () {},
        ),
      ),
    );
  }
}
