import 'package:flutter/material.dart';

show_custom_dialog({
  required BuildContext context,
  required String title,
  required String message,
  required String button_text,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(button_text),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

show_payment_result_alert_dialog(
  bool payment_success,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          payment_success ? "Payment successful" : "Payment failed",
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Accept"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
