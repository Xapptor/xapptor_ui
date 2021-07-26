import 'package:xapptor_routing/app_screen.dart';
import 'package:xapptor_routing/app_screens.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_auth/get_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/screens/abeinstitute/class_session.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class CoursesList extends StatefulWidget {
  const CoursesList({
    required this.topbar_color,
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final Color topbar_color;
  final Color language_picker_items_text_color;
  final bool language_picker;

  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  late SharedPreferences prefs;

  List<String> courses_buyed = <String>[];
  List<Map<String, dynamic>> courses_and_units = <Map<String, dynamic>>[];
  List<Course> courses = <Course>[];

  Map<String, dynamic> user_info = {};
  late String uid;

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid")!;
    get_courses_and_units();
  }

  get_courses_and_units() async {
    user_info = await get_user_info(uid);

    courses.clear();

    if (user_info["courses_buyed"] != null) {
      if (user_info["courses_buyed"].length > 0) {
        courses_buyed = List.from(user_info["courses_buyed"]);

        for (int i = 0; i < courses_buyed.length; i++) {
          DocumentSnapshot firestore_course = await FirebaseFirestore.instance
              .collection("courses")
              .doc(courses_buyed[i])
              .get();

          List<String> units = List.from(firestore_course.get("units"));

          List<String> units_name = List<String>.generate(
              units.length, (counter) => "Unit ${counter + 1}");

          List<bool> units_completed_status =
              List<bool>.generate(units.length, (counter) => false);

          for (int i = 0; i < units.length; i++) {
            if (user_info["units_completed"] != null) {
              if (user_info["units_completed"].length > 0) {
                for (int j = 0; j < user_info["units_completed"].length; j++) {
                  if (units[i] == user_info["units_completed"][j]) {
                    units_completed_status[i] = true;
                  }
                }
              }
            }
          }

          courses.add(
            Course(
              courses_buyed[i],
              firestore_course.get("name"),
              units_name,
              Icons.check_circle_outline,
              units,
              units_completed_status,
            ),
          );
        }
      }
    }

    setState(() {});
  }

  List<String> text_list = [
    "Account",
    "Notifications",
    "My courses",
    "Buy courses",
    "Certificates and Rewards",
    "Settings",
  ];

  String current_language = "en";

  TranslationStream translation_stream = TranslationStream();

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;
    translation_stream.translate();
    setState(() {});
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      Container(
        width: portrait ? 100 : 150,
        child: widget.language_picker
            ? LanguagePicker(
                current_language: current_language,
                language_picker_callback: language_picker_callback,
                language_picker_items_text_color:
                    widget.language_picker_items_text_color,
              )
            : Container(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    init_prefs();
    translation_stream.init(text_list, update_text_list);
    translation_stream.translate();
  }

  @override
  Widget build(BuildContext context) {
    double app_bar_height = 65;
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(app_bar_height),
        child: Topbar(
          background_color: widget.topbar_color,
          size: app_bar_height,
          has_back_button: true,
          actions: widgets_action(portrait),
          custom_leading: null,
          logo_path: "assets/images/logo.png",
        ),
      ),
      body: courses.length > 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.8,
                widthFactor: 0.8,
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        ExpansionTile(
                          backgroundColor: Colors.grey[100],
                          title: Text(
                            courses[i].title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          initiallyExpanded: true,
                          children: <Widget>[
                            Column(
                              children: _buildExpandableContent(
                                courses[i],
                                context,
                                get_courses_and_units,
                                widget.language_picker_items_text_color,
                                widget.language_picker,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
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

_buildExpandableContent(
  Course course,
  BuildContext context,
  Function get_courses_and_units,
  Color language_picker_items_text_color,
  bool language_picker,
) {
  List<Widget> column_content = [];

  for (String content in course.contents) {
    int content_index = course.contents.indexOf(content);
    column_content.add(
      GestureDetector(
        onTap: () async {
          String unit_id = course.unit_ids[content_index];

          if (content_index == 0) {
            open_class_session(
              course_id: course.id,
              course_name: course.title,
              unit_id: unit_id,
              language_picker_items_text_color:
                  language_picker_items_text_color,
              language_picker: language_picker,
            );

            //getCoursesAndUnits();
          } else {
            if (course.units_completed_status[content_index - 1]) {
              open_class_session(
                course_id: course.id,
                course_name: course.title,
                unit_id: unit_id,
                language_picker_items_text_color:
                    language_picker_items_text_color,
                language_picker: language_picker,
              );
            }
          }
        },
        child: ListTile(
          title: Text(
            content,
            style: TextStyle(fontSize: 18.0),
          ),
          leading: Icon(
            course.icon,
            color: course.units_completed_status[content_index]
                ? Colors.lightGreen
                : Colors.transparent,
          ),
        ),
      ),
    );
  }

  return column_content;
}

open_class_session({
  required String course_id,
  required String course_name,
  required String unit_id,
  required Color language_picker_items_text_color,
  required bool language_picker,
}) {
  add_new_app_screen(
    AppScreen(
      name: "home/courses/unit_$unit_id",
      child: ClassSession(
        course_id: course_id,
        course_name: course_name,
        unit_id: unit_id,
        language_picker_items_text_color: language_picker_items_text_color,
        language_picker: language_picker,
        topbar_color: color_abeinstitute_dark_aqua.withOpacity(0.7),
      ),
    ),
  );
  open_screen("home/courses/unit_$unit_id");
}

class Course {
  Course(
    this.id,
    this.title,
    this.contents,
    this.icon,
    this.unit_ids,
    this.units_completed_status,
  );

  final String id;
  final String title;
  List<String> contents = [];
  final IconData icon;
  List<String> unit_ids = [];
  List<bool> units_completed_status = [];
}
