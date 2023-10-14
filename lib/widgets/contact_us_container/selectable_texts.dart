import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container.dart';

extension StateExtension on ContactUsContainerState {
  selectable_texts() => Column(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.location_on,
              color: widget.icon_color,
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 3,
            child: SelectableText(
              widget.texts[7],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.phone,
              color: widget.icon_color,
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: SelectableText(
              widget.texts[8],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.email,
              color: widget.icon_color,
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 4,
            child: SelectableText(
              widget.texts[9],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      );
}
