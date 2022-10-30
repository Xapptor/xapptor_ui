import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class DropdownBottomBar extends StatefulWidget {
  const DropdownBottomBar({
    required this.child,
    required this.bottom_bar_color,
    this.title,
  });

  final Widget child;
  final Color bottom_bar_color;
  final String? title;

  @override
  State<DropdownBottomBar> createState() => _DropdownBottomBarState();
}

class _DropdownBottomBarState extends State<DropdownBottomBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  bool show_animated_container = false;
  bool show_child = false;

  final double bottom_bar_height = 40;

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: AnimatedContainer(
        height: show_animated_container
            ? (screen_height * 0.6) + bottom_bar_height
            : bottom_bar_height,
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

                    Timer(Duration(milliseconds: 350), () {
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
                      widget.title != null
                          ? Text(
                              widget.title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Container(
                height: show_child ? (screen_height * 0.6) : 0,
                child: show_child ? widget.child : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
