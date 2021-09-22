import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_logic/file_downloader/file_downloader.dart';
import 'package:xapptor_logic/generate_certificate.dart';
import 'package:xapptor_ui/models/certificate.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CertificatesVisualizer extends StatefulWidget {
  const CertificatesVisualizer({
    required this.certificate,
    required this.topbar_color,
  });

  final CourseCertificate certificate;
  final Color topbar_color;

  @override
  _CertificatesVisualizerState createState() => _CertificatesVisualizerState();
}

class _CertificatesVisualizerState extends State<CertificatesVisualizer> {
  String html_string = "";
  String pdf_base64 = "";
  Uint8List? pdf_bytes = null;

  get_html_certificate() async {
    html_string = await generate_html_certificate(
      course_name: widget.certificate.course_name,
      user_name: widget.certificate.user_name,
      date: widget.certificate.date,
      id: widget.certificate.id,
    );
    download_certificate();
  }

  download_certificate() async {
    String base_url = Uri.base.toString().contains("localhost")
        ? "http://localhost:5001/xapptor/us-central1/"
        : "https://us-central1-xapptor.cloudfunctions.net/";

    int pdf_height = 940;
    int pdf_width = 1200;

    await http
        .post(
      Uri.parse(
          base_url + "convert_html_to_pdf?height=$pdf_height&width=$pdf_width"),
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
      body: json.encode(
        {
          "html_base64": base64.encode(utf8.encode(html_string)),
        },
      ),
    )
        .then((response) {
      pdf_base64 = response.body.toString();
      pdf_bytes = base64.decode(pdf_base64);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    get_html_certificate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: [
          IconButton(
            icon: Icon(
              UniversalPlatform.isWeb ? Icons.download_rounded : Icons.share,
              color: Colors.white,
            ),
            onPressed: () async {
              String file_name =
                  "certificate_${widget.certificate.user_name.split(" ").join("_")}_${widget.certificate.course_name.split(" ").join("_")}_${widget.certificate.id}.pdf";

              FileDownloader.save(
                base64_string: pdf_base64,
                file_name: file_name,
              );
            },
          ),
        ],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: pdf_bytes != null
          ? SafeArea(
              child: SfPdfViewer.memory(
                pdf_bytes!,
                enableDoubleTapZooming: true,
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
    );
  }
}
