import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_logic/random_number_with_range.dart';
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
  double text_bottom_margin = 3;

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
          apply_variation: true,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: text_bottom_margin,
                ),
                child: Text(
                  widget.resume.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: portrait ? 18 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: text_bottom_margin),
                child: Text(
                  widget.resume.job_title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: portrait ? 16 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ResumeSkill(
                skill: SkillData.ResumeSkill(
                  name:
                      "Years of Experience:\nLevel ${widget.resume.years_of_experience}",
                  percentage: widget.resume.years_of_experience / 10,
                  color: widget.resume.icon_color,
                ),
                apply_variation: false,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: text_bottom_margin,
                ),
                child: Text(
                  "Dextery Points",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: portrait ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ] +
            skills,
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
                  Flex(
                    direction: portrait ? Axis.vertical : Axis.horizontal,
                    children: portrait
                        ? <Widget>[
                            image,
                            name_and_skills,
                          ]
                        : <Widget>[
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
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
    required this.apply_variation,
  });

  final SkillData.ResumeSkill skill;
  final bool apply_variation;

  @override
  _ResumeSkillState createState() => _ResumeSkillState();
}

class _ResumeSkillState extends State<ResumeSkill> {
  double current_percentage = 0.1;
  double percentage_variation = 0;

  update_bar_width() {
    Timer(Duration(milliseconds: 2000), () {
      current_percentage = widget.skill.percentage;
      setState(() {});
    });

    if (widget.apply_variation) {
      Timer(Duration(milliseconds: 3000), () {
        Timer.periodic(
            Duration(milliseconds: random_number_with_range(2000, 3500)),
            (timer) {
          percentage_variation = random_number_with_range(-50, 50) / 1000;
          setState(() {});
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    update_bar_width();
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = screen_height > screen_width;
    double current_bar_width = (screen_width * (portrait ? 0.8 : 0.18)) *
        (current_percentage + percentage_variation);

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
                duration: Duration(milliseconds: 2000),
                height: 7,
                width: current_bar_width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: widget.skill.color,
                  boxShadow: [
                    BoxShadow(
                      color: widget.skill.color,
                      blurRadius: 4,
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
