import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/models/description_card.dart';
import 'custom_card.dart';

description_card({
  required DescriptionCard description_card,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  double current_height = screen_height * 0.5;
  bool portrait = screen_height > screen_width;

  List<Widget> widgets = [
    Spacer(flex: 1),
    Expanded(
      flex: 4,
      child: Container(
        margin: EdgeInsets.all(20),
        child: CustomCard(
          elevation: 6,
          border_radius: 18,
          child: Image.asset(
            description_card.image_src,
            fit: BoxFit.fill,
          ),
          on_pressed: () {
            //
          },
        ),
      ),
    ),
    Spacer(flex: 1),
    Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              description_card.title,
              style: TextStyle(
                color: description_card.text_color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              description_card.description,
              style: TextStyle(
                color: description_card.text_color,
                fontSize: 18,
              ),
              maxLines: 6,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                launch(description_card.url);
              },
              child: Text(
                "Github Repo",
                style: TextStyle(
                  color: description_card.text_color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Spacer(flex: 1),
  ];

  return AnimatedOpacity(
    opacity: (description_card.current_offset >=
                description_card.visible_offset - screen_height) &&
            (description_card.current_offset <=
                description_card.visible_offset - current_height)
        ? 1
        : 0,
    duration: Duration(milliseconds: 300),
    child: Container(
      width: 200,
      child: Row(
        children:
            description_card.reversed ? widgets.reversed.toList() : widgets,
      ),
    ),
  );
}
