import 'package:flutter/material.dart';
import 'characteristics_container_item.dart';
import 'package:xapptor_logic/is_portrait.dart';

class WhyUsContainer extends StatefulWidget {
  const WhyUsContainer({
    required this.texts,
    required this.background_image,
    required this.background_color,
    required this.characteristic_icon_1,
    required this.characteristic_icon_2,
    required this.characteristic_icon_3,
    required this.characteristic_icon_color_1,
    required this.characteristic_icon_color_2,
    required this.characteristic_icon_color_3,
    required this.title_color,
    required this.subtitle_color,
  });

  final List<String> texts;
  final String background_image;
  final Color background_color;
  final IconData characteristic_icon_1;
  final IconData characteristic_icon_2;
  final IconData characteristic_icon_3;
  final Color characteristic_icon_color_1;
  final Color characteristic_icon_color_2;
  final Color characteristic_icon_color_3;
  final Color title_color;
  final Color subtitle_color;

  @override
  _WhyUsContainerState createState() => _WhyUsContainerState();
}

class _WhyUsContainerState extends State<WhyUsContainer> {
  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    return Container(
      decoration: BoxDecoration(
        image: widget.background_image.isNotEmpty
            ? DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  widget.background_image,
                ),
              )
            : null,
        color: widget.background_color,
      ),
      height: portrait
          ? (MediaQuery.of(context).size.height * 3.2)
          : (MediaQuery.of(context).size.height),
      width: MediaQuery.of(context).size.width,
      child: FractionallySizedBox(
        widthFactor: portrait ? 1 : 0.8,
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Expanded(
              flex: portrait ? 3 : 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  widget.texts[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.title_color,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 2 : 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  widget.texts[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.subtitle_color,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 42 : 12,
              child: Flex(
                direction: portrait ? Axis.vertical : Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: portrait ? 5 : 1,
                    child: CharacteristicsContainerItem(
                      title: "American",
                      description: widget.texts[3],
                      icon: widget.characteristic_icon_1,
                      color: Colors.white.withAlpha(0),
                      title_color: widget.title_color,
                      subtitle_color: widget.subtitle_color,
                      icon_color: widget.characteristic_icon_color_1,
                      side_icon: false,
                      large_description: true,
                      align_to_left_description: true,
                    ),
                  ),
                  Expanded(
                    flex: portrait ? 5 : 1,
                    child: CharacteristicsContainerItem(
                      title: "Business",
                      description: widget.texts[5],
                      icon: widget.characteristic_icon_2,
                      color: Colors.white.withAlpha(0),
                      title_color: widget.title_color,
                      subtitle_color: widget.subtitle_color,
                      icon_color: widget.characteristic_icon_color_2,
                      side_icon: false,
                      large_description: true,
                      align_to_left_description: true,
                    ),
                  ),
                  Expanded(
                    flex: portrait ? 5 : 1,
                    child: CharacteristicsContainerItem(
                      title: "Excellence",
                      description: widget.texts[7],
                      icon: widget.characteristic_icon_3,
                      color: Colors.white.withAlpha(0),
                      title_color: widget.title_color,
                      subtitle_color: widget.subtitle_color,
                      icon_color: widget.characteristic_icon_color_3,
                      side_icon: false,
                      large_description: true,
                      align_to_left_description: true,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
