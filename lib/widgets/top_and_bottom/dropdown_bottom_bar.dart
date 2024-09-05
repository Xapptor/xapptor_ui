import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class DropdownBottomBar extends StatefulWidget {
  final Widget child;
  final Color bottom_bar_color;
  final String? title;

  const DropdownBottomBar({
    super.key,
    required this.child,
    required this.bottom_bar_color,
    this.title,
  });

  @override
  State<DropdownBottomBar> createState() => _DropdownBottomBarState();
}

class _DropdownBottomBarState extends State<DropdownBottomBar> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  bool show_animated_container = false;
  bool show_child = false;

  final double bottom_bar_height = 40;

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: AnimatedContainer(
        height: show_animated_container ? (screen_height * 0.6) + bottom_bar_height : bottom_bar_height,
        color: Colors.white,
        duration: const Duration(milliseconds: 300),
        child: PointerInterceptor(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (!show_animated_container) {
                    show_animated_container = true;
                    setState(() {});

                    Timer(const Duration(milliseconds: 350), () {
                      show_child = true;
                      setState(() {});
                    });
                  } else {
                    show_animated_container = false;
                    show_child = false;
                    setState(() {});
                  }
                },
                child: Container(
                  height: bottom_bar_height,
                  width: double.maxFinite,
                  color: widget.bottom_bar_color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        show_child ? Icons.arrow_downward : Icons.arrow_upward,
                        color: Colors.white,
                      ),
                      if (widget.title != null)
                        Text(
                          widget.title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (show_child)
                SizedBox(
                  height: screen_height * 0.6,
                  child: widget.child,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
