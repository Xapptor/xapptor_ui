import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xapptor_translation/pgc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_translation/translate.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({
    required this.translation_stream_list,
    required this.language_picker_items_text_color,
  });

  final List<TranslationStream> translation_stream_list;
  final Color language_picker_items_text_color;

  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  String language_value = 'English';
  List<String> language_values = [
    'English',
  ];
  String target = "";
  late List languages_list;
  late SharedPreferences prefs;

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language_target") != null) {
      target = prefs.getString("language_target")!;
    } else {
      target = "en";
      prefs.setString("language_target", target);
    }

    translate();
    get_languages_list();
  }

  translate() {
    widget.translation_stream_list.forEach((translation_stream) {
      translation_stream.translate();
    });
  }

  get_languages_list() async {
    if (prefs.getStringList("languages_list") != null) {
      print("return languages list from local storage");
      language_values = prefs.getStringList("languages_list")!;
    } else {
      String pgc_data = await pgc();
      String url =
          "https://translation.googleapis.com/language/translate/v2/languages?key=$pgc_data&target=en";

      Response response = await get(Uri.parse(url));
      Map<String, dynamic> body = jsonDecode(response.body);

      languages_list = body['data']['languages'];
      language_values.clear();

      languages_list
          .forEach((language) => language_values.add(language['name']));
      language_value = (languages_list
          .firstWhere((language) => language["language"] == target))["name"];

      print("return languages list from api");
      prefs.setStringList("languages_list", language_values);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init_prefs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        isExpanded: true,
        value: language_value,
        iconSize: 24,
        elevation: 16,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.yellow,
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (new_value) async {
          language_value = new_value!;

          var selectedLanguage = languages_list
              .singleWhere((language) => language['name'] == language_value);

          await prefs.setString(
              'language_target', selectedLanguage['language']);

          setState(() {});
          translate();
        },
        selectedItemBuilder: (BuildContext context) {
          return language_values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          }).toList();
        },
        items: language_values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: widget.language_picker_items_text_color,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
