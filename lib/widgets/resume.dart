import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/models/resume.dart';
import 'package:xapptor_ui/models/resume_section.dart';

resume({
  required Resume resume,
  required bool visible,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  bool portrait = screen_height > screen_width;

  List<Widget> jobs = [];

  double resume_section_width = screen_width * 0.65;

  resume.jobs.forEach((job) {
    jobs.add(
      resume_section(
        resume_section: job,
        context: context,
      ),
    );
  });

  List<Widget> sections = [];

  resume.sections.forEach((section) {
    sections.add(
      resume_section(
        resume_section: section,
        context: context,
      ),
    );
  });

  return Container(
      margin: EdgeInsets.symmetric(vertical: screen_height / 6),
      //color: Colors.orange,
      child: Row(
        children: [
          Spacer(flex: 1),
          Expanded(
            flex: portrait ? 12 : 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screen_width / (portrait ? 2 : 6),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  //color: Colors.lightBlue,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            child: Image.asset(
                              resume.image_src,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                resume.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: portrait ? 22 : 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              resume.job_title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.greenAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      resume_section(
                        resume_section: ResumeSection(
                          icon: Icons.account_circle_rounded,
                          title: "Profile",
                          description: resume.profile,
                        ),
                        context: context,
                      ),
                      resume_section(
                        resume_section: ResumeSection(
                          icon: Icons.account_circle_rounded,
                          title: "Details",
                          subtitle: (resume.address ?? "") +
                              " " +
                              (resume.phone_number ?? ""),
                          description: resume.email,
                        ),
                        context: context,
                      ),
                      Column(
                        children: jobs,
                      ),
                      Column(
                        children: sections,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 1),
        ],
      ));
}

resume_section({
  required ResumeSection resume_section,
  //required double width,
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
          child: Icon(
            resume_section.icon ?? Icons.ac_unit,
            color:
                resume_section.icon != null ? Colors.black : Colors.transparent,
          ),
        ),
        Expanded(
          flex: portrait ? 6 : 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resume_section.title != null
                  ? Text(
                      resume_section.title!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    )
                  : Container(),
              resume_section.subtitle != null
                  ? Text(
                      resume_section.subtitle!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    )
                  : Container(),
              resume_section.begin != null && resume_section.end != null
                  ? Text(
                      DateFormat.yMMMM().format(resume_section.begin!) +
                          " -- " +
                          DateFormat.yMMMM().format(resume_section.end!),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )
                  : Container(),
              resume_section.description != null
                  ? Text(
                      resume_section.description!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 20,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}
