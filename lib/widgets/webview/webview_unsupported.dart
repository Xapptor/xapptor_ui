import 'package:flutter/widgets.dart';

class Webview extends StatefulWidget {
  final String src;
  final String id;
  final Function? controller_callback;
  final Function(String url)? loaded_callback;
  final bool page_loaded_set_state;

  const Webview({
    super.key,
    required this.src,
    required this.id,
    this.controller_callback,
    this.loaded_callback,
    this.page_loaded_set_state = true,
  });

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
