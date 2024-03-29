import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xapptor_ui/utils/show_alert.dart';

copy_to_clipboard({
  required String data,
  required String message,
  required BuildContext context,
}) async {
  await Clipboard.setData(
    ClipboardData(
      text: data,
    ),
  );
  if (context.mounted) show_success_alert(context: context, message: message);
}
