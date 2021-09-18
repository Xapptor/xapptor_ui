import 'package:flutter/widgets.dart';

class Webview extends StatefulWidget {
  const Webview({
    required this.src,
    required this.id,
    this.controller_callback,
    this.loaded_callback,
  });

  final String src;
  final String id;
  final Function? controller_callback;
  final Function(String url)? loaded_callback;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
