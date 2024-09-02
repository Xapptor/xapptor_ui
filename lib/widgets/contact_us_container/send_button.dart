// ignore_for_file: use_build_context_synchronously

import 'package:xapptor_db/xapptor_db.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container.dart';

extension StateExtension on ContactUsContainerState {
  send_button() {
    if (name_input_controller.text.isNotEmpty &&
        email_input_controller.text.isNotEmpty &&
        subject_input_controller.text.isNotEmpty &&
        message_input_controller.text.isNotEmpty) {
      String newMessage =
          "${name_input_controller.text} has a message for you! \n\n Email: ${email_input_controller.text}\n\n Message: ${message_input_controller.text}";

      XapptorDB.instance.collection("emails").doc().set({
        "to": widget.email,
        "message": {
          "subject": "Message from contact us section: \"${subject_input_controller.text}\"",
          "text": newMessage,
        }
      }).then((value) {
        name_input_controller.clear();
        email_input_controller.clear();
        subject_input_controller.clear();
        message_input_controller.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText(
              widget.feedback_message,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }).catchError((err) {
        debugPrint(err);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: SelectableText(
            widget.texts[10],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
