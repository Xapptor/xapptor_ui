import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/card/custom_card.dart';
import 'package:xapptor_ui/widgets/url/url_launcher.dart';

Widget custom_icon_button({
  required List<String> urls,
  required IconData icon,
  required Color icon_color,
}) {
  return CustomCard(
    splash_color: icon_color.withOpacity(0.3),
    linear_gradient: const LinearGradient(
      colors: [
        Colors.transparent,
        Colors.transparent,
      ],
    ),
    on_pressed: () async {
      launch_url(
        urls[0],
        urls[1],
      );
    },
    shape: BoxShape.circle,
    child: Icon(
      icon,
      color: icon_color,
    ),
  );
}
