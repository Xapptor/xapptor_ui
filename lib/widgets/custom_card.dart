import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.elevation = 2,
    required this.border_radius,
    required this.on_pressed,
    required this.linear_gradient,
    this.splash_color,
    this.use_pointer_interceptor = false,
  });

  final Widget child;
  final double elevation;
  final double? border_radius;
  final Function() on_pressed;
  final LinearGradient? linear_gradient;
  final Color? splash_color;
  final bool use_pointer_interceptor;

  @override
  Widget build(BuildContext context) {
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
    Widget ink_well_widget = Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(
          border_radius ?? default_border_radius,
        ),
        onTap: on_pressed,
        splashColor: splash_color ?? Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );

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
              elevation,
              elevation,
            ),
            blurRadius: elevation,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          use_pointer_interceptor
              ? PointerInterceptor(
                  child: ink_well_widget,
                )
              : ink_well_widget,
        ],
      ),
    );
  }
}
