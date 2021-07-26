import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/card_holder.dart';

Widget generic_card_holder({
  required String image_path,
  required String title,
  required String subtitle,
  required Alignment background_image_alignment,
  required IconData? icon,
  required Color? icon_background_color,
  required Function() on_pressed,
  required double card_holder_elevation,
  required double card_holder_border_radius,
  required BuildContext context,
}) {
  return CardHolder(
    elevation: card_holder_elevation,
    border_radius: card_holder_border_radius,
    text_color: Colors.black,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              card_holder_border_radius,
            ),
            image: DecorationImage(
              alignment: background_image_alignment,
              fit: BoxFit.cover,
              image: image_path.contains("http")
                  ? Image.network(image_path).image
                  : AssetImage(
                      image_path,
                    ),
            ),
          ),
        ),
        icon != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: icon_background_color,
                  borderRadius: BorderRadius.circular(
                    card_holder_border_radius,
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white.withOpacity(1.0),
                  size: MediaQuery.of(context).size.height / 20,
                ),
              )
            : Container(),
      ],
    ),
    title: title,
    subtitle: subtitle,
    text: "",
    on_pressed: on_pressed,
  );
}
