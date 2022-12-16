import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_router/get_last_path_segment.dart';

class WebVideoVisualizer extends StatefulWidget {
  WebVideoVisualizer({
    required this.base_url,
    this.id,
  });

  String base_url;
  String? id;

  @override
  State<WebVideoVisualizer> createState() => _WebVideoVisualizerState();
}

class _WebVideoVisualizerState extends State<WebVideoVisualizer> {
  String complete_url = "";

  @override
  void initState() {
    super.initState();
    check_url();
  }

  check_url() async {
    if (widget.id == null) {
      widget.id = get_last_path_segment();
    }
    complete_url = widget.base_url + widget.id!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: complete_url.isNotEmpty
            ? Webview(
                src: complete_url,
                id: Uuid().v4(),
              )
            : Container(),
      ),
    );
  }
}
