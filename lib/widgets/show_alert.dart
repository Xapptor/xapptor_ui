import 'package:flutter/material.dart';

enum AlertType {
  success,
  neutral,
  error,
}

show_alert(
  BuildContext context,
  String message,
  AlertType alert_type,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: alert_type == AlertType.success
          ? Colors.green
          : alert_type == AlertType.error
              ? Colors.red
              : null,
      content: Text(
        message,
      ),
    ),
  );
}

show_success_alert(BuildContext context, String message) {
  show_alert(context, message, AlertType.success);
}

show_neutral_alert(BuildContext context, String message) {
  show_alert(context, message, AlertType.neutral);
}

show_error_alert(BuildContext context, String message) {
  show_alert(context, message, AlertType.error);
}
