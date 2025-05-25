import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web';
import 'dart:js_interop';

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
  final web.HTMLIFrameElement _iframe_element = web.HTMLIFrameElement();
  bool page_loaded = false;

  @override
  void initState() {
    super.initState();

    _iframe_element.addEventListener(
      'load',
      ((web.Event event) {
        if (!page_loaded && widget.page_loaded_set_state) {
          page_loaded = true;
          setState(() {});
        }

        if (widget.loaded_callback != null) {
          widget.loaded_callback!(_iframe_element.src);
        }
      }).toJS,
    );
  }

  @override
  Widget build(BuildContext context) {
    String current_src = widget.src;

    platformViewRegistry.registerViewFactory(
      'iframeElement-${widget.id}',
      (int view_id) => _iframe_element,
    );

    _iframe_element.style.height = '100%';
    _iframe_element.style.width = '100%';

    if (widget.src.toLowerCase().contains("</html>")) {
      current_src = """
                  <!DOCTYPE html>
                  <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=0.2">
                        <title>Document</title>
                        <style>
                            html,
                            body {
                                height: 100%;
                                width: 100%;
                                background-color: transparent;
                            }
                        </style>
                    </head>
                    <body>
                        ${widget.src}"
                    </body>
                  </html>
                    """;
      _iframe_element.srcdoc = current_src.toJS;
    } else if (widget.src.toLowerCase().contains("http")) {
      _iframe_element.src = current_src;
    }

    _iframe_element.style.border = 'none';

    return Center(
      child: HtmlElementView(
        key: UniqueKey(),
        viewType: 'iframeElement-${widget.id}',
      ),
    );
  }
}
