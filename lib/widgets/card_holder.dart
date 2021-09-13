import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'custom_card.dart';

class CardHolder extends StatefulWidget {
  CardHolder({
    required this.on_pressed,
    this.title = "",
    this.subtitle = "",
    this.text_color = Colors.black,
    this.image_path = "",
    this.background_image_alignment = Alignment.center,
    this.icon,
    this.icon_background_color = Colors.blue,
    this.elevation = 3,
    this.border_radius = 20,
    this.is_focused = false,
  });

  final Function() on_pressed;
  final String title;
  final String subtitle;
  final Color text_color;
  final String image_path;
  final Alignment background_image_alignment;
  final IconData? icon;
  final Color? icon_background_color;
  final double elevation;
  final double border_radius;
  bool is_focused;

  @override
  _CardHolderState createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  double size_multiplier = 0.85;
  Duration animation_duration = Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double text_padding = MediaQuery.of(context).size.height / 40;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MouseRegion(
          onEnter: (PointerEvent details) {
            size_multiplier = 1;
            widget.is_focused = true;
            setState(() {});
          },
          onExit: (PointerEvent details) {
            size_multiplier = 0.85;
            widget.is_focused = false;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: animation_duration,
                  height: constraints.maxHeight *
                      (widget.is_focused ? 1 : size_multiplier),
                  width: constraints.maxWidth *
                      (widget.is_focused ? 1 : size_multiplier),
                  child: CustomCard(
                    animation_duration: animation_duration,
                    on_pressed: widget.on_pressed,
                    elevation: widget.is_focused ? 12 : widget.elevation,
                    border_radius: widget.border_radius,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: text_padding,
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            AutoSizeText(
                              widget.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.text_color,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 18,
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              widget.subtitle,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.text_color,
                                fontSize: 18,
                              ),
                              minFontSize: 14,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    height: (constraints.maxHeight / 2),
                    width: constraints.maxWidth *
                        (widget.is_focused ? 1 : size_multiplier),
                    duration: animation_duration,
                    curve: Curves.linear,
                    child: CustomCard(
                      on_pressed: widget.on_pressed,
                      elevation: 0,
                      border_radius: widget.border_radius,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                widget.border_radius,
                              ),
                              image: DecorationImage(
                                alignment: widget.background_image_alignment,
                                fit: BoxFit.cover,
                                image: widget.image_path.contains("http")
                                    ? Image.network(widget.image_path).image
                                    : AssetImage(
                                        widget.image_path,
                                      ),
                              ),
                            ),
                          ),
                          widget.icon != null
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: widget.icon_background_color,
                                    borderRadius: BorderRadius.circular(
                                      widget.border_radius,
                                    ),
                                  ),
                                  child: Icon(
                                    widget.icon,
                                    color: Colors.white.withOpacity(1.0),
                                    size:
                                        MediaQuery.of(context).size.height / 20,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
