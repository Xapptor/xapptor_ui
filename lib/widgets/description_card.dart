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
      width: screen_width *
          (description_card.direction == Axis.horizontal
              ? portrait
                  ? 0.5
                  : 0.25
              : portrait
                  ? 0.85
                  : 0.5),
      child: Image.asset(
        description_card.image_src,
        fit: BoxFit.contain,
      ),
    ),
    Container(
      width: screen_width *
          (description_card.direction == Axis.horizontal
              ? portrait
                  ? 0.45
                  : 0.25
              : portrait
                  ? 0.85
                  : 0.25),
      //color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: SelectableText(
              description_card.title,
              style: TextStyle(
                color: description_card.text_color,
                fontSize: portrait ? 20 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: SelectableText(
              description_card.description,
              style: TextStyle(
                color: description_card.text_color,
                fontSize: portrait ? 14 : 16,
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                launch(description_card.url);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              child: Text(
                description_card.url_title,
                style: TextStyle(
                  color: description_card.text_color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
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
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        left: card_visible
            ? 0
            : description_card.reversed
                ? -screen_width
                : screen_width,
        child: AnimatedOpacity(
          opacity: card_visible ? 1 : 0,
          duration: Duration(milliseconds: card_visible ? 1000 : 500),
          child: Container(
            height: (screen_height * 0.7),
            width: screen_width,
            //color: Colors.orange,
            child: Flex(
              direction:
                  portrait ? description_card.direction : Axis.horizontal,
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
