import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundImageWithGradientColor extends StatelessWidget {
  final Widget child;
  final double height;
  final String? image_path;
  final LinearGradient linear_gradient;
  final BoxFit box_fit;
  final bool? blur_image;
  final Color? blur_image_color;
  final List<double>? blur_image_parameters;
  final double border_radius;

  const BackgroundImageWithGradientColor({
    super.key,
    required this.child,
    required this.height,
    required this.image_path,
    required this.linear_gradient,
    required this.box_fit,
    this.blur_image,
    this.blur_image_color,
    this.blur_image_parameters,
    this.border_radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              border_radius,
            ),
            child: image_path != null
                ? Image.asset(
                    image_path!,
                    fit: box_fit,
                  )
                : null,
          ),
        ),
        if (blur_image != null && blur_image!)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur_image_parameters![0],
              sigmaY: blur_image_parameters![1],
            ),
            child: Container(
              color: blur_image_color,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(border_radius),
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            gradient: linear_gradient,
            borderRadius: BorderRadius.circular(border_radius),
          ),
        ),
        child,
      ],
    );
  }
}
