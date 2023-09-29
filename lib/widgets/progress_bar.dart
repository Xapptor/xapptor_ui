import 'dart:async';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.color,
    required this.background_color,
    required this.height,
    required this.parent_width,
    required this.initial_percentage,
    required this.final_percentage,
    required this.animation_delay,
    required this.show_percentage_text,
    required this.border_radius,
    required this.elevation,
    required this.alignment,
  });

  final Color color;
  final Color background_color;
  final double height;
  final double parent_width;
  final double initial_percentage;
  final double final_percentage;
  final int animation_delay;
  final bool show_percentage_text;
  final double border_radius;
  final double elevation;
  final Alignment alignment;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  Color current_text_color = Colors.transparent;
  Color percentage_text_color = Colors.transparent;
  double current_percentage = 0;

  @override
  void initState() {
    super.initState();

    percentage_text_color = widget.background_color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    current_percentage = widget.initial_percentage;
    Timer(Duration(seconds: widget.animation_delay), () {
      current_percentage = widget.final_percentage;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //setState(() {});
      },
      child: MouseRegion(
        onEnter: (PointerEvent details) {
          if (widget.show_percentage_text) {
            current_text_color = percentage_text_color;
            setState(() {});
          }
        },
        onExit: (PointerEvent details) {
          if (widget.show_percentage_text) {
            current_text_color = Colors.transparent;
            setState(() {});
          }
        },
        child: Container(
          height: widget.height,
          width: widget.parent_width,
          decoration: BoxDecoration(
            color: widget.background_color,
            borderRadius: BorderRadius.circular(
              widget.border_radius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(widget.elevation, widget.elevation),
                blurRadius: widget.elevation,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: widget.alignment,
                child: AnimatedContainer(
                  height: widget.height,
                  width: (widget.parent_width * current_percentage) / 100,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(
                      widget.border_radius,
                    ),
                  ),
                ),
              ),
              Text(
                current_percentage.toString(),
                style: TextStyle(
                  color: current_text_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
