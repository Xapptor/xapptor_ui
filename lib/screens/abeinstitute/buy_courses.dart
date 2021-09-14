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
  bool show_items = false;

  late TranslationStream translation_stream;
  List<TranslationStream> translation_stream_list = [];
  List<String> text_list = [
    "Our courses",
    "Learn and get certified in any of them.",
    "Buy now",
    "Upcoming",
    "Coupon ID",
    "Enter",
    "Coupon is not valid",
  ];

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    text_list[index] = new_text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    translation_stream = TranslationStream(
      text_list: text_list,
      update_text_list_function: update_text_list,
      list_index: 0,
    );
    translation_stream_list = [translation_stream];

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
          width: 150,
          child: widget.language_picker
              ? LanguagePicker(
                  translation_stream_list: translation_stream_list,
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
          ? Container(
              child: SingleChildScrollView(
                child: Container(
                  height: portrait
                      ? (MediaQuery.of(context).size.height * 3)
                      : (MediaQuery.of(context).size.height),
                  child: PricingContainer(
                    texts: text_list,
                    background_color: Colors.blue.shade800,
                    title_color: Colors.white,
                    subtitle_color: Colors.white,
                    image_1: 'assets/images/student_1.jpg',
                    image_2: 'assets/images/student_2.jpg',
                    image_3: 'assets/images/family.jpg',
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
