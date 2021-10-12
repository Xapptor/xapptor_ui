import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/models/resume.dart';
import 'package:xapptor_ui/models/resume_section.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

pw.Widget resume_section_pw({
  required Resume resume,
  required ResumeSection resume_section,
  required double text_bottom_margin,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;

  return pw.Container(
    margin: pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 1,
          child: resume_section.icon != null
              ? pw.Icon(
                  pw.IconData(0xe530),
                  color: PdfColor.fromInt(
                    resume.icon_color.value,
                  ),
                  size: 16,
                )
              : pw.Container(),
        ),
        pw.Expanded(
          flex: 20,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              resume_section.title != null
                  ? pw.Container(
                      margin: pw.EdgeInsets.only(bottom: text_bottom_margin),
                      child: pw.Text(
                        resume_section.title!,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    )
                  : pw.Container(),
              resume_section.subtitle != null
                  ? pw.Container(
                      margin: pw.EdgeInsets.only(bottom: text_bottom_margin),
                      child: pw.Text(
                        resume_section.subtitle!,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    )
                  : pw.Container(),
              resume_section.begin != null && resume_section.end != null
                  ? pw.Container(
                      margin: pw.EdgeInsets.only(bottom: text_bottom_margin),
                      child: pw.Text(
                        DateFormat.yMMMM().format(resume_section.begin!) +
                            " - " +
                            (resume_section.end!
                                        .difference(DateTime.now())
                                        .inDays ==
                                    0
                                ? "Present"
                                : DateFormat.yMMMM()
                                    .format(resume_section.end!)),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 8,
                        ),
                      ),
                    )
                  : pw.Container(),
              resume_section.description != null
                  ? pw.Container(
                      margin: pw.EdgeInsets.only(bottom: text_bottom_margin),
                      child: pw.Text(
                        resume_section.description!,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 10,
                        ),
                      ),
                    )
                  : pw.Container(),
            ],
          ),
        ),
      ],
    ),
  );
}

resume_section({
  required Resume resume,
  required ResumeSection resume_section,
  required double text_bottom_margin,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  bool portrait = screen_height > screen_width;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: resume_section.icon != null
              ? Icon(
                  resume_section.icon,
                  color: resume.icon_color,
                  size: portrait ? 16 : 22,
                )
              : Container(),
        ),
        Expanded(
          flex: portrait ? 8 : 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resume_section.title != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: text_bottom_margin),
                      child: SelectableText(
                        resume_section.title!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: portrait ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              resume_section.subtitle != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: text_bottom_margin),
                      child: SelectableText(
                        resume_section.subtitle!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: portrait ? 12 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              resume_section.begin != null && resume_section.end != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: text_bottom_margin),
                      child: SelectableText(
                        DateFormat.yMMMM().format(resume_section.begin!) +
                            " - " +
                            (resume_section.end!
                                        .difference(DateTime.now())
                                        .inDays ==
                                    0
                                ? "Present"
                                : DateFormat.yMMMM()
                                    .format(resume_section.end!)),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: portrait ? 8 : 12,
                        ),
                      ),
                    )
                  : Container(),
              resume_section.description != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: text_bottom_margin),
                      child: SelectableText(
                        resume_section.description!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: portrait ? 10 : 14,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}
