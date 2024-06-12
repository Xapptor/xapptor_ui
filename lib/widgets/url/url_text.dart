import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfUrlText extends pw.StatelessWidget {
  final String text;
  final String url;
  final double? font_size;

  PdfUrlText({
    required this.text,
    required this.url,
    this.font_size = 10,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: font_size,
          decoration: pw.TextDecoration.underline,
          color: PdfColors.blue,
        ),
      ),
    );
  }
}

class UrlText extends StatelessWidget {
  final String text;
  final String url;

  const UrlText({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  Widget build(context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
