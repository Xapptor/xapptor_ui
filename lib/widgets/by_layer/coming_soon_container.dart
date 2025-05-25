import 'package:flutter/material.dart';

class ComingSoonContainer extends StatelessWidget {
  final String text;
  final Widget? child;
  final bool enable_cover;
  final double border_radius;

  const ComingSoonContainer({
    super.key,
    required this.text,
    this.child,
    required this.enable_cover,
    this.border_radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: child,
        ),
        if (enable_cover)
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(border_radius),
                color: Colors.blueGrey.shade500.withValues(alpha: 0.7),
              ),
              child: AbsorbPointer(
                absorbing: true,
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
