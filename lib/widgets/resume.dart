import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/models/resume.dart' as ResumeData;
import 'package:xapptor_ui/models/resume_section.dart';
import 'package:xapptor_ui/models/resume_skill.dart' as SkillData;

class Resume extends StatefulWidget {
  const Resume({
    required this.resume,
    required this.visible,
  });

  final ResumeData.Resume resume;
  final bool visible;
  @override
  _ResumeState createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = screen_height > screen_width;

    List<Widget> skills = [];
    widget.resume.skills.forEach((skill) {
      skills.add(
        ResumeSkill(
          skill: skill,
        ),
      );
    });

    List<Widget> sections = [];
    widget.resume.sections.forEach((section) {
      sections.add(
        resume_section(
          resume_section: section,
        ),
      );
    });

    Widget image = Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          20,
        ),
        child: Image.asset(
          widget.resume.image_src,
          fit: BoxFit.contain,
        ),
      ),
    );

    Widget name_and_skills = Container(
      margin:
          EdgeInsets.symmetric(horizontal: portrait ? 0 : (screen_width / 100)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  widget.resume.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: portrait ? 18 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.resume.job_title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: portrait ? 16 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: skills,
            ),
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: screen_height / 20),
      //color: Colors.cyan,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: widget.visible ? 1 : 0,
            duration: Duration(milliseconds: 600),
            child: FractionallySizedBox(
              widthFactor: portrait ? 0.8 : 0.4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: portrait ? 0 : 10),
                    //color: Colors.lightBlue,
                    child: Flex(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      direction: portrait ? Axis.vertical : Axis.horizontal,
                      children: portrait
                          ? [
                              image,
                              name_and_skills,
                            ]
                          : [
                              Expanded(
                                flex: 1,
                                child: image,
                              ),
                              Expanded(
                                flex: 1,
                                child: name_and_skills,
                              ),
                            ],
                    ),
                  ),
                  Container(
                    //color: Colors.greenAccent,
                    child: Column(
                      children: sections,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  resume_section({
    required ResumeSection resume_section,
  }) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = screen_height > screen_width;
    double text_bottom_margin = 3;

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
                    color: widget.resume.icon_color,
                    size: portrait ? 18 : 22,
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
                            fontSize: portrait ? 18 : 22,
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
                            fontSize: portrait ? 14 : 18,
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
                              DateFormat.yMMMM().format(resume_section.end!),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                            fontSize: portrait ? 12 : 14,
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
}

class ResumeSkill extends StatefulWidget {
  const ResumeSkill({
    required this.skill,
  });

  final SkillData.ResumeSkill skill;

  @override
  _ResumeSkillState createState() => _ResumeSkillState();
}

class _ResumeSkillState extends State<ResumeSkill> {
  double current_percentage = 0.1;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), () {
      current_percentage = widget.skill.percentage;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = screen_height > screen_width;
    double current_bar_width =
        (screen_width * (portrait ? 0.8 : 0.18)) * current_percentage;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: SelectableText(
              widget.skill.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: 7,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: widget.skill.color.withOpacity(0.5),
                ),
              ),
              AnimatedContainer(
                curve: Curves.elasticOut,
                duration: Duration(milliseconds: 1700),
                height: 7,
                width: current_bar_width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: widget.skill.color,
                  boxShadow: [
                    BoxShadow(
                      color: widget.skill.color,
                      blurRadius: 7,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
