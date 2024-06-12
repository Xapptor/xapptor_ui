import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/widgets/card/description_card_model.dart';

description_card({
  required DescriptionCardModel model,
  required BuildContext context,
}) {
  double screen_height = MediaQuery.of(context).size.height;
  double screen_width = MediaQuery.of(context).size.width;
  bool portrait = screen_height > screen_width;

  List<Widget> widgets = [
    SizedBox(
      //color: Colors.orange,
      width: screen_width *
          (model.direction == Axis.horizontal
              ? portrait
                  ? 0.5
                  : 0.25
              : portrait
                  ? 0.85
                  : 0.5),
      child: Image.asset(
        model.image_src,
        fit: BoxFit.contain,
      ),
    ),
    SizedBox(
      width: screen_width *
          (model.direction == Axis.horizontal
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
          SelectableText(
            model.title,
            style: TextStyle(
              color: model.text_color,
              fontSize: portrait ? 20 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: SelectableText(
              model.description,
              style: TextStyle(
                color: model.text_color,
                fontSize: portrait ? 14 : 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse(model.url));
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Text(
              model.url_title,
              style: TextStyle(
                color: model.text_color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  bool card_visible = model.current_offset >= (model.visible_offset - (screen_height * 1.05)) &&
      model.current_offset <= (model.visible_offset - (screen_height * 0.35));

  return Stack(
    alignment: Alignment.center,
    children: [
      AnimatedPositioned(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        left: card_visible
            ? 0
            : model.reversed
                ? -screen_width
                : screen_width,
        child: AnimatedOpacity(
          opacity: card_visible ? 1 : 0,
          duration: Duration(milliseconds: card_visible ? 1000 : 500),
          child: SizedBox(
            height: (screen_height * 0.7),
            width: screen_width,
            //color: Colors.orange,
            child: Flex(
              direction: portrait ? model.direction : Axis.horizontal,
              mainAxisAlignment: portrait
                  ? model.reversed
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: model.reversed ? widgets.reversed.toList() : widgets,
            ),
          ),
        ),
      ),
    ],
  );
}
