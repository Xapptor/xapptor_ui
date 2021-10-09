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
    height: screen_height * 2,
    width: screen_width * (portrait ? 0.8 : 1.0),
    color: Colors.orange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screen_height / 10,
          width: screen_width * 0.5,
          color: Colors.lightBlue,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Image.asset(
                  resume.image_src,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      resume.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      resume.job_title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screen_width * 0.65,
                color: Colors.green,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: jobs,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: sections,
                    ),
                  ],
                ),
              ),
              Container(
                width: screen_width * 0.35,
                color: Colors.redAccent,
                child: Column(
                  children: [
                    Text(
                      "Details",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    resume.address != null
                        ? Text(
                            resume.address!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    resume.phone_number != null
                        ? Text(
                            resume.phone_number!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    Text(
                      resume.email,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

resume_section({
  required ResumeSection resume_section,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  bool portrait = screen_height > screen_width;

  return Container(
    height: screen_height / 6,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          resume_section.icon ?? Icons.ac_unit,
          color:
              resume_section.icon != null ? Colors.black : Colors.transparent,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            resume_section.title != null
                ? Text(
                    resume_section.title!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
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
                      fontSize: 20,
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
      ],
    ),
  );
}
