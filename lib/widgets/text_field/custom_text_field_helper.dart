import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/dimensions.dart';

custom_textfield_helper({
  required BuildContext context,
  required String helper_text,
  required Color helper_text_color,
  required Icon? helper_icon,
  required int? length_limit,
  required bool show_length_limit_counter,
  required int text_length,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: Dimensions.d4,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            helper_icon ?? Container(),
            if (helper_text.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(
                  left: helper_icon == null ? 0 : Dimensions.d4,
                ),
                child: Text(
                  helper_text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: helper_text_color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        if (length_limit != null && show_length_limit_counter)
          Text(
            "$text_length/$length_limit",
            style: TextStyle(
              color: helper_text_color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    ),
  );
}
