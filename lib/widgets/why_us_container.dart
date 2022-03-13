import 'package:flutter/material.dart';
import 'characteristics_container_item.dart';
import 'package:xapptor_logic/is_portrait.dart';

class WhyUsContainer extends StatefulWidget {
  const WhyUsContainer({
    required this.texts,
    required this.background_image,
    required this.background_color,
    required this.characteristic_titles,
    required this.characteristic_icons,
    required this.characteristic_icon_colors,
    required this.title_color,
    required this.subtitle_color,
    this.custom_height,
  });

  final List<String> texts;
  final String background_image;
  final Color background_color;
  final List<String> characteristic_titles;
  final List<IconData> characteristic_icons;
  final List<Color> characteristic_icon_colors;
  final Color title_color;
  final Color subtitle_color;
  final double? custom_height;

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
      height: widget.custom_height != null
          ? widget.custom_height
          : portrait
              ? (MediaQuery.of(context).size.height * 4)
              : (MediaQuery.of(context).size.height),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Text(
              widget.texts[0],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.title_color,
                fontSize: 40,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 60,
              bottom: 30,
            ),
            child: Text(
              widget.texts[1],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.subtitle_color,
                fontSize: 18,
              ),
            ),
          ),
          Flex(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            direction: portrait ? Axis.vertical : Axis.horizontal,
            children: [
              CharacteristicsContainerItem(
                title: widget.characteristic_titles[0],
                description: widget.texts[3],
                icon: widget.characteristic_icons[0],
                color: Colors.white.withAlpha(0),
                title_color: widget.title_color,
                subtitle_color: widget.subtitle_color,
                icon_color: widget.characteristic_icon_colors[0],
                side_icon: false,
                large_description: true,
                align_to_left_description: true,
              ),
              CharacteristicsContainerItem(
                title: widget.characteristic_titles[1],
                description: widget.texts[5],
                icon: widget.characteristic_icons[1],
                color: Colors.white.withAlpha(0),
                title_color: widget.title_color,
                subtitle_color: widget.subtitle_color,
                icon_color: widget.characteristic_icon_colors[1],
                side_icon: false,
                large_description: true,
                align_to_left_description: true,
              ),
              CharacteristicsContainerItem(
                title: widget.characteristic_titles[2],
                description: widget.texts[7],
                icon: widget.characteristic_icons[2],
                color: Colors.white.withAlpha(0),
                title_color: widget.title_color,
                subtitle_color: widget.subtitle_color,
                icon_color: widget.characteristic_icon_colors[2],
                side_icon: false,
                large_description: true,
                align_to_left_description: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
