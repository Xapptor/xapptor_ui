import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    required this.elevation,
    required this.border_radius,
    required this.on_pressed,
    required this.linear_gradient,
    this.splash_color,
  });

  final Widget child;
  final double? elevation;
  final double? border_radius;
  final Function() on_pressed;
  final LinearGradient? linear_gradient;
  final Color? splash_color;

  @override
  Widget build(BuildContext context) {
    double default_elevation = 2;
    double default_border_radius = 30;

    Color shadow_color = Colors.transparent;
    if (linear_gradient == null) {
      shadow_color = Colors.grey.withOpacity(0.5);
    } else {
      if (linear_gradient!.colors.first == Colors.transparent) {
        shadow_color = Colors.transparent;
      } else {
        shadow_color = Colors.grey.withOpacity(0.5);
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: linear_gradient ??
            LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
        borderRadius: BorderRadius.circular(
          border_radius ?? default_border_radius,
        ),
        boxShadow: [
          BoxShadow(
            color: shadow_color,
            offset: Offset(
              elevation ?? default_elevation,
              elevation ?? default_elevation,
            ),
            blurRadius: elevation ?? default_elevation,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            border_radius ?? default_border_radius,
          ),
          onTap: on_pressed,
          splashColor: splash_color ?? Colors.white.withOpacity(0.3),
          highlightColor: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
