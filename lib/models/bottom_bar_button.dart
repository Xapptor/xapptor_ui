import 'package:flutter/material.dart';

// BottomBarButton model.

class BottomBarButton {
  final IconData icon;
  final String text;
  final Color foreground_color;
  final Color background_color;
  final Widget page;

  const BottomBarButton({
    required this.icon,
    required this.text,
    required this.foreground_color,
    required this.background_color,
    required this.page,
  });
}
