// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:xapptor_router/V2/get_last_path_segment_v2.dart';

class WebVideoVisualizer extends StatefulWidget {
  String base_url;
  String? id;

  WebVideoVisualizer({
    super.key,
    required this.base_url,
    this.id,
  });

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
    widget.id ??= get_last_path_segment_v2();
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
                id: const Uuid().v8(),
              )
            : null,
      ),
    );
  }
}
