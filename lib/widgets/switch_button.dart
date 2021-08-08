import 'package:flutter/material.dart';

Widget switch_button({
  required String text,
  required bool value,
  required bool enabled,
  required Color active_track_color,
  required Color active_color,
  required Color background_color,
  required Function(bool) callback,
  required double border_radius,
}) {
  return Container(
    decoration: BoxDecoration(
      color: background_color,
      borderRadius: BorderRadius.all(
        Radius.circular(border_radius),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Switch(
            value: value,
            onChanged: enabled
                ? (new_value) {
                    callback(new_value);
                  }
                : null,
            activeTrackColor: active_track_color,
            activeColor: active_color,
          ),
        ),
      ],
    ),
  );
}
