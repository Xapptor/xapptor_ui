import 'package:flutter/widgets.dart';

class Webview extends StatefulWidget {
  const Webview({
    required this.src,
    required this.id,
    required this.function,
  });

  final String src;
  final String id;
  final Function function;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}