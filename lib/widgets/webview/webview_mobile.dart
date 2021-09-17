import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool page_loaded = false;

  late WebViewController controller;

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
          },
          initialUrl: widget.src.toLowerCase().contains("html")
              ? Uri.dataFromString(
                  widget.src,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8'),
                ).toString()
              : widget.src,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (action) {
            String current_url = action.url;
            widget.function(current_url);
            return NavigationDecision.navigate;
          },
          onPageFinished: (value) {
            if (!page_loaded) {
              page_loaded = true;
              controller.loadUrl(widget.src);
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
