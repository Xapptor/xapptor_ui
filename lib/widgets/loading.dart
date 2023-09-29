import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer({super.key, 
    required this.loading,
    required this.background_color,
    required this.progress_indicator_color,
    this.stroke_width = 0,
    required this.child,
  });

  final bool loading;
  final Color background_color;
  final Color progress_indicator_color;
  final double stroke_width;
  final Widget child;

  @override
  _LoadingContainerState createState() => _LoadingContainerState();
}

class _LoadingContainerState extends State<LoadingContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    double loading_size = (portrait ? screen_width : screen_height) * 0.1;
    double loading_stroke_width =
        widget.stroke_width == 0 ? loading_size * 0.1 : widget.stroke_width;

    List<Widget> stack_children = [widget.child];

    if (widget.loading) {
      stack_children.add(
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: widget.background_color,
          child: Center(
            child: Container(
              height: loading_size,
              width: loading_size,
              child: CircularProgressIndicator(
                color: widget.progress_indicator_color,
                strokeWidth: loading_stroke_width,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: stack_children,
    );
  }
}
