import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundImageWithGradientColor extends StatelessWidget {
  const BackgroundImageWithGradientColor({
    required this.child,
    required this.background_image_path,
    required this.linear_gradient,
    required this.box_fit,
    this.blur_image,
    this.blur_imageColor,
    this.blur_image_parameters,
    this.border_radius = 0,
  });

  final Widget child;
  final String? background_image_path;
  final LinearGradient linear_gradient;
  final BoxFit box_fit;
  final bool? blur_image;
  final Color? blur_imageColor;
  final List<double>? blur_image_parameters;
  final double border_radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: background_image_path != null
                ? DecorationImage(
                    fit: box_fit,
                    image: background_image_path!.contains("http") ||
                            background_image_path!.contains(".com")
                        ? Image.network(
                            background_image_path!,
                          ).image
                        : AssetImage(
                            background_image_path!,
                          ),
                  )
                : null,
            borderRadius: BorderRadius.circular(border_radius),
          ),
          child: blur_image != null && blur_image!
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blur_image_parameters![0],
                    sigmaY: blur_image_parameters![1],
                  ),
                  child: Container(
                    color: blur_imageColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(border_radius),
                    ),
                  ),
                )
              : Container(),
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
