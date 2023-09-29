import 'package:flutter/material.dart';

class CropWidget extends StatefulWidget {
  const CropWidget({
    super.key,
    required this.child,
    required this.general_alignment,
    required this.vertical_alignment,
    required this.horizontal_alignment,
    required this.height_factor,
    required this.width_factor,
  });

  final Widget child;
  final Alignment general_alignment;
  final Alignment vertical_alignment;
  final Alignment horizontal_alignment;
  final double height_factor;
  final double width_factor;

  @override
  State<CropWidget> createState() => _CropWidgetState();
}

class _CropWidgetState extends State<CropWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.general_alignment,
      child: ClipRect(
        child: Align(
          alignment: widget.horizontal_alignment,
          widthFactor: widget.width_factor,
          heightFactor: 1.0,
          child: ClipRect(
            child: Align(
              alignment: widget.vertical_alignment,
              widthFactor: 1.0,
              heightFactor: widget.height_factor,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
