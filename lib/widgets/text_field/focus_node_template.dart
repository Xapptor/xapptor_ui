import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FocusNode focus_node_template({
  required TextEditingController controller,
  required Function callback,
}) {
  FocusNode focus_node = FocusNode();

  on_key_event(
    FocusNode node,
    KeyEvent event,
  ) {
    if (event is KeyDownEvent) {
      bool is_enter = event.logicalKey == LogicalKeyboardKey.enter;

      bool is_shift = HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
          HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.shiftRight);

      if (is_enter && !is_shift) {
        callback();
        return KeyEventResult.handled;
      } else if (is_enter && is_shift) {
        controller.text += "\n";
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    } else {
      return KeyEventResult.ignored;
    }
  }

  focus_node.onKeyEvent = on_key_event;
  return focus_node;
}
