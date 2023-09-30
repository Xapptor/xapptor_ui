// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class Webview extends StatefulWidget {
  const Webview({
    super.key,
    required this.src,
    required this.id,
    this.controller_callback,
    this.loaded_callback,
    this.page_loaded_set_state = true,
  });

  final String src;
  final String id;
  final Function? controller_callback;
  final Function(String url)? loaded_callback;
  final bool page_loaded_set_state;

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final IFrameElement _iframe_element = IFrameElement();
  bool page_loaded = false;
  late ElementStream new_stream;

  @override
  void initState() {
    super.initState();
    new_stream = _iframe_element.onLoad;

    new_stream.listen((event) {
      if (!page_loaded && widget.page_loaded_set_state) {
        page_loaded = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String current_src = widget.src;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement-${widget.id}',
      (int view_id) => _iframe_element,
    );

    _iframe_element.style.height = '100%';
    _iframe_element.style.width = '100%';

    if (widget.src.toLowerCase().contains("</html>")) {
      //debugPrint("webview source 1");
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
      _iframe_element.srcdoc = current_src;
    } else if (widget.src.toLowerCase().contains("http")) {
      //debugPrint("webview source 2");
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
