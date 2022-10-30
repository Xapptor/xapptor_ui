import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class CharacteristicsContainerItem extends StatefulWidget {
  const CharacteristicsContainerItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.title_color,
    required this.subtitle_color,
    required this.icon_color,
    required this.side_icon,
    required this.large_description,
    required this.align_to_left_description,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color title_color;
  final Color subtitle_color;
  final Color icon_color;
  final bool side_icon;
  final bool large_description;
  final bool align_to_left_description;

  @override
  _CharacteristicsContainerItemState createState() =>
      _CharacteristicsContainerItemState();
}

class _CharacteristicsContainerItemState
    extends State<CharacteristicsContainerItem> {
  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = is_portrait(context);

    return Container(
      margin: EdgeInsets.only(
        top: screen_height / 40,
        bottom: screen_height / 40,
      ),
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.side_icon
              ? Icon(
                  widget.icon,
                  color: widget.icon_color,
                  size: 40,
                )
              : Container(),
          Column(
            crossAxisAlignment: widget.side_icon
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              !widget.side_icon
                  ? Icon(
                      widget.icon,
                      color: widget.icon_color,
                      size: 40,
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.all(10),
                child: SelectableText(
                  widget.title,
                  textAlign:
                      widget.side_icon ? TextAlign.left : TextAlign.center,
                  style: TextStyle(
                    color: widget.title_color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: ((screen_width / (portrait ? 1 : 3)) * 0.8),
                margin: EdgeInsets.all(10),
                child: SelectableText(
                  widget.description,
                  textAlign: widget.align_to_left_description
                      ? TextAlign.left
                      : TextAlign.center,
                  style: TextStyle(
                    color: widget.subtitle_color,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
