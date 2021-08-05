import 'package:xapptor_auth/check_if_user_is_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_logic/file_downloader/file_downloader.dart';
import 'package:xapptor_logic/generate_certificate_html_from_values.dart';
import 'package:xapptor_logic/timestamp_to_date.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class CertificatesVisualizer extends StatefulWidget {
  const CertificatesVisualizer({
    required this.topbar_color,
    required this.id,
    required this.uid,
    required this.user_name,
    required this.course_name,
    required this.date,
  });

  final Color topbar_color;
  final String id;
  final String uid;
  final String user_name;
  final String course_name;
  final String date;

  @override
  _CertificatesVisualizerState createState() => _CertificatesVisualizerState();
}

class _CertificatesVisualizerState extends State<CertificatesVisualizer> {
  TextEditingController certificate_id_input_controller =
      TextEditingController();
  String html_certificate = "";
  bool waiting_pdf_base64 = false;
  bool user_is_admin = false;

  String other_course_name = "";
  String other_date = "";
  String other_user_id = "";
  String other_user_name = "";

  String attributes_for_user = "";
  String attributes_for_admin = "";
  bool attributes_are_for_admin = false;

  get_html_certificate() async {
    html_certificate = await HtmlCertificateFromValues().generate(
      course_name: widget.course_name,
      user_name: widget.user_name,
      date: widget.date,
      id: widget.id,
    );
    setState(() {});
  }

  download_certificate(http.Response response) async {
    String base64_pdf = response.body.toString();

    attributes_for_user =
        "certificate_${widget.user_name.split(" ").join("_")}_${widget.course_name.split(" ").join("_")}_${widget.id}.pdf";
    attributes_for_admin =
        "certificate_${other_user_name.split(" ").join("_")}_${other_course_name.split(" ").join("_")}_${certificate_id_input_controller.text}.pdf";

    FileDownloader.save(
      base64_pdf,
      attributes_are_for_admin ? attributes_for_admin : attributes_for_user,
    );

    waiting_pdf_base64 = false;
    setState(() {});
  }

  check_if_is_admin() async {
    user_is_admin = await check_if_user_is_admin(widget.uid);
    setState(() {});
  }

  generate_certificate() async {
    String url_user =
        'https://us-central1-abei-21f7c.cloudfunctions.net/createPDF?userName=${widget.user_name}&courseName=${widget.course_name}&date=${widget.date}&certificateID=${widget.id}';
    String url_admin =
        'https://us-central1-abei-21f7c.cloudfunctions.net/createPDF?userName=$other_user_name&courseName=$other_course_name&date=$other_date&certificateID=${certificate_id_input_controller.text}';

    attributes_are_for_admin =
        user_is_admin && certificate_id_input_controller.text != "";

    await http.get(
      Uri.parse(attributes_are_for_admin ? url_admin : url_user),
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
    ).then((response) => download_certificate(response));
  }

  get_other_certificate_info() async {
    await FirebaseFirestore.instance
        .collection("certificates")
        .doc(certificate_id_input_controller.text)
        .get()
        .then((DocumentSnapshot certificate_doc) async {
      other_date = TimestampToDate().convert(certificate_doc.get("date"));
      other_user_id = certificate_doc.get("user_id");

      await FirebaseFirestore.instance
          .collection("courses")
          .doc(certificate_doc.get("course_id"))
          .get()
          .then((DocumentSnapshot course_doc) async {
        other_course_name = course_doc.get("name");

        await FirebaseFirestore.instance
            .collection("users")
            .doc(other_user_id)
            .get()
            .then((DocumentSnapshot user_doc) async {
          other_user_name =
              user_doc.get("firstname") + " " + user_doc.get("lastname");
          generate_certificate();
          return null;
        });

        return null;
      });
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
    get_html_certificate();
    check_if_is_admin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: <Widget>[],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: html_certificate != "" && !waiting_pdf_base64
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              UniversalPlatform.isWeb
                                  ? Icons.download_rounded
                                  : Icons.share,
                            ),
                            onPressed: () async {
                              waiting_pdf_base64 = true;
                              setState(() {});

                              if (user_is_admin &&
                                  certificate_id_input_controller.text != "") {
                                get_other_certificate_info();
                              } else {
                                generate_certificate();
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: user_is_admin
                              ? TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Other certificate ID",
                                  ),
                                  controller: certificate_id_input_controller,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 17,
                    child: Webview(
                      src: html_certificate,
                      id: Uuid().v4(),
                      function: () {},
                    ),
                  ),
                ],
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