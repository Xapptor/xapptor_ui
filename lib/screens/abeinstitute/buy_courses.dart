import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/abeinstitute/princing_container.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_logic/is_portrait.dart';

class BuyCourses extends StatefulWidget {
  const BuyCourses({
    required this.language_picker_items_text_color,
    required this.language_picker,
  });

  final Color language_picker_items_text_color;
  final bool language_picker;

  @override
  _BuyCoursesState createState() => _BuyCoursesState();
}

class _BuyCoursesState extends State<BuyCourses> {
  ScrollController scroll_controller = ScrollController();
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

  bool show_items = false;

  @override
  void initState() {
    super.initState();
    translation_stream.init(text_list, update_text_list);
    translation_stream.translate();
    change_show_items();
  }

  change_show_items() {
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        show_items = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    AppBar appbar = TopBar(
      background_color: color_abeinstitute_topbar,
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
    );

    return Scaffold(
      appBar: appbar,
      body: show_items
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    appbar.preferredSize.height,
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
            )
          : Container(),
    );
  }
}
