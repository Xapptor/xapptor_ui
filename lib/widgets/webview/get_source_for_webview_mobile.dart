import 'dart:convert';

String get_source_for_webview_mobile(String original_src) {
  return original_src.toLowerCase().contains("html")
      ? Uri.dataFromString(
          original_src,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString()
      : original_src;
}
