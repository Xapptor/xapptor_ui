import 'package:flutter/material.dart';

class ComingSoonContainer extends StatelessWidget {
  const ComingSoonContainer({
    required this.text,
    this.child,
    required this.enable_cover,
    this.border_radius = 0,
  });

  final String text;
  final Widget? child;
  final bool enable_cover;
  final double border_radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: child,
        ),
        enable_cover
            ? Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(border_radius),
                    color: Colors.blueGrey.shade500.withOpacity(0.7),
                  ),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Center(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
