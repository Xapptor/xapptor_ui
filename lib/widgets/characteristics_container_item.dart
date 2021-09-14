import 'package:flutter/material.dart';

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
    return Container(
      color: widget.color,
      child: Row(
        children: <Widget>[
          widget.side_icon
              ? Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          widget.icon,
                          color: widget.icon_color,
                          size: 40,
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: widget.side_icon
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                !widget.side_icon ? Spacer(flex: 1) : Container(),
                !widget.side_icon
                    ? Expanded(
                        flex: 5,
                        child: Icon(
                          widget.icon,
                          color: widget.icon_color,
                          size: 40,
                        ),
                      )
                    : Container(),
                Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: Text(
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
                Spacer(flex: 1),
                Expanded(
                  flex: widget.large_description ? 50 : 3,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: SingleChildScrollView(
                      child: Text(
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
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
