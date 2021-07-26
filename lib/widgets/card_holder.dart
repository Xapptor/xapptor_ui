import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_card.dart';

class CardHolder extends StatefulWidget {
  const CardHolder({
    required this.child,
    required this.title,
    required this.subtitle,
    required this.text,
    required this.text_color,
    required this.on_pressed,
    required this.elevation,
    required this.border_radius,
  });

  final Widget child;
  final String title;
  final String subtitle;
  final String text;
  final Color text_color;
  final Function() on_pressed;
  final double elevation;
  final double border_radius;

  @override
  _CardHolderState createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  double top_card_margin = 0;
  double margin_effect = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MouseRegion(
          onEnter: (PointerEvent details) {
            top_card_margin =
                (constraints.maxHeight / 3.5) + (constraints.maxHeight / 8);
            setState(() {});
          },
          onExit: (PointerEvent details) {
            top_card_margin = (constraints.maxHeight / 3.5);
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: constraints.maxWidth,
                  margin: EdgeInsets.only(
                    left: margin_effect,
                    right: margin_effect,
                  ),
                  child: CustomCard(
                    on_pressed: widget.on_pressed,
                    elevation: widget.elevation,
                    border_radius: widget.border_radius,
                    linear_gradient: null,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            widget.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: widget.text_color,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: widget.text_color,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.text,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: widget.text_color,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  height: constraints.maxHeight / 2,
                  width: constraints.maxWidth,
                  margin: EdgeInsets.only(
                    bottom: top_card_margin != 0
                        ? top_card_margin
                        : (constraints.maxHeight / 3.5),
                  ),
                  duration: Duration(milliseconds: 100),
                  curve: Curves.linear,
                  child: CustomCard(
                    on_pressed: widget.on_pressed,
                    elevation: 0,
                    border_radius: widget.border_radius,
                    linear_gradient: null,
                    child: widget.child,
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
