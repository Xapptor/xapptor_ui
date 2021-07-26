import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundImageWithGradientColor extends StatelessWidget {
  const BackgroundImageWithGradientColor({
    required this.child,
    required this.background_image_path,
    required this.linear_gradient,
    required this.box_fit,
    required this.height,
    required this.width,
    this.blur_image,
    this.blur_imageColor,
    this.blur_image_parameters,
  });

  final Widget child;
  final String? background_image_path;
  final LinearGradient linear_gradient;
  final BoxFit box_fit;
  final bool? blur_image;
  final Color? blur_imageColor;
  final List<double>? blur_image_parameters;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: height,
            width: width,
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
            ),
            child: blur_image != null && blur_image!
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: blur_image_parameters![0],
                      sigmaY: blur_image_parameters![1],
                    ),
                    child: Container(
                      color: blur_imageColor,
                    ),
                  )
                : Container(),
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(gradient: linear_gradient),
          ),
          child,
        ],
      ),
    );
  }
}
