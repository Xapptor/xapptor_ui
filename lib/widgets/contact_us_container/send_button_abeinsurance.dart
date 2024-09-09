// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'package:xapptor_db/xapptor_db.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container_lead_form.dart';

extension StateExtension on ContactUsContainerLeadFormState {
  send_button() {
    if (insurance_type_value != "¿Qué seguro te interesa?" &&
        schedule_value != "¿A qué hora te gustaría que te llamaran?" &&
        birthday_label != "Fecha de Nacimiento") {
      String newMessage =
          "${name_input_controller.text} has a message for you! \n\nYou have a new Lead: \n\n Insurance Type: $insurance_type_value\nSchedule: $schedule_value\nName: ${name_input_controller.text}\nAddress: ${address_input_controller.text}\nZip Code: ${zip_code_input_controller.text}\nTelephone Number: ${telephone_number_input_controller.text}\nEmail: ${email_input_controller.text}\nDate of Birth: $birthday_label";

      XapptorDB.instance.collection("emails").doc().set({
        "to": widget.email,
        "message": {
          "subject": "You have a new Lead: ${name_input_controller.text}",
          "text": newMessage,
        }
      }).then((value) {
        insurance_type_value = insurance_type_values[0];
        schedule_value = schedule_values[0];
        name_input_controller.clear();
        address_input_controller.clear();
        zip_code_input_controller.clear();
        telephone_number_input_controller.clear();
        email_input_controller.clear();
        birthday_label = "Fecha de Nacimiento";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            widget.feedback_message,
          ),
          duration: const Duration(seconds: 2),
        ));

        setState(() {});
      }).catchError((err) {
        debugPrint(err);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Debes seleccionar seguro de interés, horario de contacto y fecha de nacimiento",
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
