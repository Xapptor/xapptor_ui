import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'get_source_for_webview_mobile.dart';

class Webview extends StatefulWidget {
  const Webview({
    super.key,
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
  bool page_loaded = false;
  String current_url = "";

  final WebViewController _webview_controller = WebViewController();

  @override
  void initState() {
    super.initState();

    _webview_controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            current_url = url;
            if (widget.loaded_callback != null) {
              widget.loaded_callback!(current_url);
            }
          },
          onPageFinished: (value) {
            if (!page_loaded) {
              page_loaded = true;

              setState(() {});
            }
          },
        ),
      );

    _on_webview_created();
  }

  _on_webview_created() async {
    if (widget.controller_callback != null) {
      widget.controller_callback!(_webview_controller);
    }

    _webview_controller.loadRequest(
      Uri.parse(get_source_for_webview_mobile(widget.src)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        WebViewWidget(
          controller: _webview_controller,
        ),
        !page_loaded
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              )
            : Container(),
      ],
    );
  }
}
