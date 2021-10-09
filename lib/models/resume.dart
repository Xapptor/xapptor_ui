import 'package:xapptor_ui/models/resume_section.dart';
import 'resume_skill.dart';

class Resume {
  final String image_src;
  final String name;
  final String job_title;
  final String? address;
  final String? phone_number;
  final String email;
  final List<ResumeSkill> skills;
  final String profile;
  final List<ResumeSection> jobs;
  final List<ResumeSection> sections;

  const Resume({
    required this.image_src,
    required this.name,
    required this.job_title,
    required this.address,
    required this.phone_number,
    required this.email,
    required this.skills,
    required this.profile,
    required this.jobs,
    required this.sections,
  });
}
