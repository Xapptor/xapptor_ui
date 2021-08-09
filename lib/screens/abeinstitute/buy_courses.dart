import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_auth/xapptor_user.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/widgets/abeinstitute/princing_container.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class BuyCourses extends StatefulWidget {
  const BuyCourses({
    required this.topbar_color,
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final Color topbar_color;
  final Color language_picker_items_text_color;
  final bool language_picker;

  @override
  _BuyCoursesState createState() => _BuyCoursesState();
}

class _BuyCoursesState extends State<BuyCourses> {
  final GlobalKey<FormState> login_form_key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  String current_language = "en";
  TranslationStream translation_stream = TranslationStream();

  List<String> text_list = [
    "Our courses",
    "Learn and get certified in any of them.",
    "White Belt",
    "\$100",
    "Yellow Belt",
    "\$249",
    "Black Belt",
    "\$300",
    "Buy now",
  ];

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;
    translation_stream.translate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    translation_stream.init(text_list, update_text_list);
    translation_stream.translate();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: scaffold_key,
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            width: portrait ? 200 : 100,
            child: widget.language_picker
                ? LanguagePicker(
                    current_language: current_language,
                    language_picker_callback: language_picker_callback,
                    language_picker_items_text_color:
                        widget.language_picker_items_text_color,
                  )
                : Container(),
          ),
        ],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewport_constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewport_constraints.maxHeight,
              ),
              child: PricingContainer(
                texts: text_list.sublist(0, 8),
                background_color: Colors.blue.shade800,
                title_color: Colors.white,
                subtitle_color: Colors.white,
                image_1: 'assets/images/student_1.jpg',
                image_2: 'assets/images/student_2.jpg',
                image_3: 'assets/images/family.jpg',
              ),
            ),
          );
        },
      ),
    );
  }
}
