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
    Container(
      margin: EdgeInsets.all(20),
      height: (screen_height * (portrait ? 0.4 : 0.6)),
      width: (screen_height * (portrait ? 0.2 : 0.3)),
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
    Container(
      width: (screen_height * (portrait ? 0.2 : 0.3)),
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
  ];

  bool card_visible = (description_card.current_offset >=
          description_card.visible_offset - screen_height) &&
      (description_card.current_offset <=
          description_card.visible_offset - current_height);

  return Stack(
    alignment: Alignment.center,
    children: [
      AnimatedPositioned(
        duration: Duration(milliseconds: 1500),
        curve: Curves.elasticOut,
        left: !description_card.reversed
            ? card_visible
                ? (screen_width / 2) - (screen_height * (portrait ? 0.25 : 0.3))
                : 0
            : null,
        right: description_card.reversed
            ? card_visible
                ? (screen_width / 2) - (screen_height * (portrait ? 0.25 : 0.3))
                : 0
            : null,
        child: AnimatedOpacity(
          opacity: card_visible ? 1 : 0,
          duration: Duration(milliseconds: card_visible ? 800 : 100),
          child: Container(
            height: (screen_height * 0.7),
            child: Row(
              children: description_card.reversed
                  ? widgets.reversed.toList()
                  : widgets,
            ),
          ),
        ),
      ),
    ],
  );
}
