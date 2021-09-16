import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

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
  final IFrameElement _iframe_element = IFrameElement();
  bool page_loaded = false;
  var new_stream;

  @override
  void initState() {
    super.initState();
    new_stream = _iframe_element.onLoad;

    new_stream.listen((event) {
      if (!page_loaded) {
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
      print("Source 1");
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
      print("Source 2");
      _iframe_element.src = current_src;
    }

    _iframe_element.style.border = 'none';

    return Center(
      child: Container(
        // child: !page_loaded
        //     ? CircularProgressIndicator(
        //         valueColor: AlwaysStoppedAnimation<Color>(
        //           Theme.of(context).primaryColor,
        //         ),
        //       )
        //     : HtmlElementView(
        //         key: UniqueKey(),
        //         viewType: 'iframeElement-${widget.id}',
        //       ),
        child: HtmlElementView(
          key: UniqueKey(),
          viewType: 'iframeElement-${widget.id}',
        ),
      ),
    );
  }
}
