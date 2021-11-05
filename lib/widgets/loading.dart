import 'package:flutter/material.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer({
    required this.loading,
    required this.background_color,
    required this.progress_indicator_color,
    required this.child,
  });

  final bool loading;
  final Color background_color;
  final Color progress_indicator_color;
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
    List<Widget> stack_children = [widget.child];

    if (widget.loading) {
      stack_children.add(
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: widget.background_color,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              child: CircularProgressIndicator(
                color: widget.progress_indicator_color,
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
