import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/models/description_card.dart';

description_card({
  required DescriptionCard description_card,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  bool portrait = screen_height > screen_width;

  List<Widget> widgets = [
    Container(
      //color: Colors.orange,
      width: screen_width * (portrait ? 0.6 : 0.25),
      child: Image.asset(
        description_card.image_src,
        fit: BoxFit.fitHeight,
      ),
    ),
    Container(
      width: screen_width * (portrait ? 0.35 : 0.25),
      //color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
            margin: EdgeInsets.only(top: 10),
            child: Text(
              description_card.description,
              style: TextStyle(
                color: description_card.text_color,
                fontSize: portrait ? 14 : 16,
              ),
              maxLines: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
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

  bool card_visible = description_card.current_offset >=
          (description_card.visible_offset - (screen_height * 1.05)) &&
      description_card.current_offset <=
          (description_card.visible_offset - (screen_height * 0.35));

  return Stack(
    alignment: Alignment.center,
    children: [
      AnimatedPositioned(
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        left: card_visible
            ? 0
            : description_card.reversed
                ? -screen_width
                : screen_width,
        child: AnimatedOpacity(
          opacity: card_visible ? 1 : 0,
          duration: Duration(milliseconds: card_visible ? 800 : 200),
          child: Container(
            height: (screen_height * 0.7),
            width: screen_width,
            //color: Colors.orange,
            child: Row(
              mainAxisAlignment: portrait
                  ? description_card.reversed
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start
                  : MainAxisAlignment.center,
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
