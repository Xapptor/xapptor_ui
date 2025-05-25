import 'package:flutter/material.dart';

Widget switch_button({
  required String text,
  required bool value,
  required bool enabled,
  required Color active_track_color,
  required Color active_color,
  required Color inactive_color,
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
        const Spacer(flex: 1),
        Expanded(
          flex: 9,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Switch(
            value: value,
            onChanged: enabled
                ? (new_value) {
                    callback(new_value);
                  }
                : null,
            activeTrackColor: Colors.grey.withValues(alpha: 0.5),
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.5),
            activeColor: active_color,
            inactiveThumbColor: inactive_color,
          ),
        ),
        const Spacer(flex: 2),
      ],
    ),
  );
}
