import 'package:flutter/material.dart';

class KeyboardHider extends StatelessWidget {
  final Widget child;
  final Function? callback;

  const KeyboardHider({
    super.key,
    required this.child,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (callback != null) callback!();
      },
      child: child,
    );
  }
}
