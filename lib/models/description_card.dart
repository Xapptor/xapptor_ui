import 'package:flutter/material.dart';

class DescriptionCard {
  final String image_src;
  final String title;
  final String description;
  final String url;
  final Color text_color;
  final bool reversed;
  final double current_offset;
  final double visible_offset;

  const DescriptionCard({
    required this.image_src,
    required this.title,
    required this.description,
    required this.url,
    required this.text_color,
    required this.reversed,
    required this.current_offset,
    required this.visible_offset,
  });
}
