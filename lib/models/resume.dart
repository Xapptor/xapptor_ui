import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/resume_section.dart';
import 'resume_skill.dart';

class Resume {
  final String image_src;
  final String name;
  final String job_title;
  final int years_of_experience;
  final List<ResumeSkill> skills;
  final List<ResumeSection> sections;
  final Color icon_color;

  const Resume({
    required this.image_src,
    required this.name,
    required this.job_title,
    required this.years_of_experience,
    required this.skills,
    required this.sections,
    required this.icon_color,
  });
}
