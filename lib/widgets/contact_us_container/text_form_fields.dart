import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container.dart';

extension StateExtension on ContactUsContainerState {
  List<Widget> text_form_fields() => [
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: name_input_controller,
            decoration: InputDecoration(
              labelText: widget.texts[2],
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
            decoration: InputDecoration(
              labelText: widget.texts[3],
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
            controller: subject_input_controller,
            decoration: InputDecoration(
              labelText: widget.texts[4],
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
            controller: message_input_controller,
            decoration: InputDecoration(
              labelText: widget.texts[5],
            ),
            onSaved: (value) {},
            validator: (value) {
              return value!.contains('@') ? 'Do not use the @ char.' : null;
            },
          ),
        ),
      ];
}
