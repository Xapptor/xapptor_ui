import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final Function()? on_pressed;
  final double elevation;
  final double border_radius;
  final LinearGradient linear_gradient;
  final Color splash_color;
  final Duration animation_duration;
  final BoxShape shape;
  final String? tooltip;

  const CustomCard({
    super.key,
    required this.child,
    required this.on_pressed,
    this.elevation = 3,
    this.border_radius = 18,
    this.linear_gradient = const LinearGradient(
      colors: [
        Colors.white,
        Colors.white,
      ],
    ),
    this.splash_color = Colors.transparent,
    this.animation_duration = const Duration(milliseconds: 100),
    this.shape = BoxShape.rectangle,
    this.tooltip,
  });

  @override
  State createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color shadow_color = Colors.transparent;
    if (widget.linear_gradient.colors.first == Colors.transparent) {
      shadow_color = Colors.transparent;
    } else {
      shadow_color = Colors.grey.withValues(alpha: 0.5);
    }

    Widget ink_well_widget(Widget child) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          widget.border_radius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: widget.on_pressed,
            splashColor: widget.splash_color,
            highlightColor: Colors.transparent,
            child: child,
          ),
        ),
      );
    }

    Widget body = Container(
      decoration: BoxDecoration(
        shape: widget.shape,
        gradient: widget.linear_gradient,
        borderRadius: widget.shape != BoxShape.circle
            ? BorderRadius.circular(
                widget.border_radius,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: shadow_color,
            offset: Offset(
              widget.elevation,
              widget.elevation,
            ),
            blurRadius: widget.elevation,
          ),
        ],
      ),
      child: ink_well_widget(widget.child),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: widget.tooltip == null
          ? body
          : Tooltip(
              message: widget.tooltip!,
              child: body,
            ),
    );
  }
}
