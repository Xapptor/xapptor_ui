import 'package:flutter/material.dart';

custom_textfield_helper({
  required BuildContext context,
  required String helper_text,
  required Color helper_text_color,
  required ValueNotifier<Icon?> helper_icon,
  required int? length_limit,
  required bool show_length_limit_counter,
  required int text_length,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: 4,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            helper_icon.value ?? Container(),
            if (helper_text.isNotEmpty)
              Container(
                margin: EdgeInsets.only(
                  left: helper_icon.value == null ? 0 : 4,
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
