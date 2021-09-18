import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'get_source_for_webview_mobile.dart';

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
  bool page_loaded = false;
  late WebViewController controller;
  String current_url = "";

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        WebView(
          onWebViewCreated: (WebViewController webview_controller) {
            controller = webview_controller;
            if (widget.controller_callback != null) {
              widget.controller_callback!(controller);
            }
          },
          initialUrl: get_source_for_webview_mobile(widget.src),
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (action) {
            current_url = action.url;
            if (widget.loaded_callback != null) {
              widget.loaded_callback!(current_url);
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (value) {
            if (!page_loaded) {
              page_loaded = true;

              setState(() {});
            }
          },
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
