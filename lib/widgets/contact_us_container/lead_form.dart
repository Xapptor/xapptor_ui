// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container_lead_form.dart';

extension StateExtension on ContactUsContainerLeadFormState {
  Future _select_date(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selected_date,
      firstDate: first_date,
      lastDate: over_18,
    ));
    if (picked != null) {
      setState(() {
        selected_date = picked;

        DateFormat date_formatter = DateFormat.yMMMMd('en_US');
        String date_now_formatted = date_formatter.format(selected_date);
        birthday_label = date_now_formatted;
      });
    }
  }

  lead_form({
    required bool portrait,
  }) {
    return Flex(
      direction: portrait ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: insurance_type_value,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: widget.icon_color,
                      ),
                      underline: Container(
                        height: 1,
                        color: widget.icon_color,
                      ),
                      onChanged: (new_value) {
                        setState(() {
                          insurance_type_value = new_value!;
                        });
                      },
                      items: insurance_type_values.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SelectableText(value),
                        );
                      }).toList(),
                    ),
                    const Spacer(flex: 10),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: schedule_value,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: widget.icon_color,
                      ),
                      underline: Container(
                        height: 1,
                        color: widget.icon_color,
                      ),
                      onChanged: (new_value) {
                        setState(() {
                          schedule_value = new_value!;
                        });
                      },
                      items: schedule_values.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SelectableText(value),
                        );
                      }).toList(),
                    ),
                    const Spacer(flex: 8),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: name_input_controller,
                  decoration: const InputDecoration(
                    labelText: "Nombre completo",
                  ),
                  onSaved: (value) {},
                  validator: (value) {
                    return value!.contains('@') ? 'Do not use the @ char.' : null;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: address_input_controller,
                  decoration: const InputDecoration(
                    labelText: "Dirección",
                  ),
                  onSaved: (value) {},
                  validator: (value) {
                    return value!.contains('@') ? 'Do not use the @ char.' : null;
                  },
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: zip_code_input_controller,
                  decoration: const InputDecoration(
                    labelText: "Código postal",
                  ),
                  onSaved: (value) {},
                  validator: (value) {
                    return value!.contains('@') ? 'Do not use the @ char.' : null;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: telephone_number_input_controller,
                  decoration: const InputDecoration(
                    labelText: "Número de teléfono",
                  ),
                  onSaved: (value) {},
                  validator: (value) {
                    return value!.contains('@') ? 'Do not use the @ char.' : null;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: email_input_controller,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                  ),
                  onSaved: (value) {},
                  validator: (value) {
                    return value!.contains('@') ? 'Do not use the @ char.' : null;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      _select_date(context);
                    },
                    child: SelectableText(
                      birthday_label,
                      style: TextStyle(
                        color: widget.icon_color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
