import 'package:flutter/material.dart';

class CoveredContainerComingSoon extends StatelessWidget {
  const CoveredContainerComingSoon({
    this.child,
    required this.enable_cover,
    this.border_radius = 0,
  });

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
                    color: Colors.grey.shade500.withOpacity(0.7),
                  ),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Center(
                      child: Text(
                        "Coming Soon",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
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
