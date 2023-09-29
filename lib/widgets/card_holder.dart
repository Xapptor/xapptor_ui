// ignore_for_file: must_be_immutable

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';
import 'custom_card.dart';

class CardHolder extends StatefulWidget {
  CardHolder({
    super.key,
    required this.on_pressed,
    this.title,
    this.subtitle = "",
    this.text_color = Colors.black,
    this.image_src = "",
    this.image_fit = BoxFit.fitWidth,
    this.background_image_alignment = Alignment.center,
    this.icon,
    this.icon_background_color = Colors.white,
    this.elevation = 3,
    this.border_radius = 20,
    this.is_focused = false,
    this.delete_function,
    this.edit_function,
  });

  Function() on_pressed;
  String? title;
  String subtitle;
  Color text_color;
  String image_src;
  BoxFit image_fit;
  Alignment background_image_alignment;
  IconData? icon;
  Color? icon_background_color;
  double elevation;
  double border_radius;
  bool is_focused;
  Function? delete_function;
  Function? edit_function;

  @override
  State<CardHolder> createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  double size_multiplier = 0.85;
  Duration animation_duration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double text_padding = MediaQuery.of(context).size.height / 40;
    bool portrait = is_portrait(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        LayoutBuilder(
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
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: animation_duration,
                      height: constraints.maxHeight * (widget.is_focused ? 1 : size_multiplier),
                      width: constraints.maxWidth * (widget.is_focused ? 1 : size_multiplier),
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
                            widthFactor: 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                AutoSizeText(
                                  widget.title ?? "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: widget.text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 18,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                ),
                                AutoSizeText(
                                  widget.subtitle,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: widget.text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment:
                          widget.title == null && widget.subtitle.isEmpty ? Alignment.center : Alignment.topCenter,
                      child: AnimatedContainer(
                        height: widget.title == null && widget.subtitle.isEmpty
                            ? (constraints.maxHeight * (widget.is_focused ? 1 : size_multiplier))
                            : (constraints.maxHeight / (portrait ? 2.2 : 1.8)),
                        width: constraints.maxWidth * (widget.is_focused ? 1 : size_multiplier),
                        duration: animation_duration,
                        curve: Curves.linear,
                        child: CustomCard(
                          on_pressed: widget.on_pressed,
                          elevation: 0,
                          border_radius: widget.border_radius,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.icon_background_color,
                              borderRadius: BorderRadius.circular(
                                widget.border_radius,
                              ),
                            ),
                            child: widget.icon != null
                                ? Icon(
                                    widget.icon,
                                    color: Colors.white.withOpacity(1.0),
                                    size: MediaQuery.of(context).size.height / 20,
                                  )
                                : widget.image_src != ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          widget.border_radius,
                                        ),
                                        child: widget.image_src.contains('http')
                                            ? Image.network(
                                                widget.image_src,
                                                fit: widget.image_fit,
                                                alignment: widget.background_image_alignment,
                                              )
                                            : Image.asset(
                                                widget.image_src,
                                                fit: widget.image_fit,
                                                alignment: widget.background_image_alignment,
                                              ),
                                      )
                                    : Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        widget.delete_function != null
            ? Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 25,
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: Colors.blueGrey.withOpacity(0.5),
                      onTap: () {
                        widget.delete_function!();
                      },
                      child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        widget.edit_function != null
            ? Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 25,
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: Colors.blueGrey.withOpacity(0.5),
                      onTap: () {
                        widget.edit_function!();
                      },
                      child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
