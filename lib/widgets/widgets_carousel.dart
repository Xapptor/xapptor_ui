import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:xapptor_ui/widgets/random_number_with_range.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class WidgetsCarousel extends StatefulWidget {
  const WidgetsCarousel({
    super.key,
    required this.dot_colors_active,
    required this.dot_color_inactive,
    required this.children,
    this.auto_scroll = false,
    required this.update_current_page,
  });

  final List<Color> dot_colors_active;
  final Color dot_color_inactive;
  final List<Widget> children;
  final bool auto_scroll;
  final Function(int new_current_page) update_current_page;

  @override
  State<WidgetsCarousel> createState() => _WidgetsCarouselState();
}

class _WidgetsCarouselState extends State<WidgetsCarousel> {
  int current_offset = 0;
  int current_page = 1;
  PageController page_controller = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  Curve animation_curve = Curves.easeInOutCirc;
  late Timer timer;

  // Auto scroll carousel.

  auto_scroll() {
    int delay_seconds = random_number_with_range(5, 9);

    timer = Timer(Duration(seconds: delay_seconds), () {
      if (current_page < widget.children.length - 1) {
        page_controller.nextPage(
          duration: const Duration(milliseconds: 900),
          curve: animation_curve,
        );
      } else {
        page_controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 900),
          curve: animation_curve,
        );
      }

      if (widget.auto_scroll) {
        auto_scroll();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.auto_scroll) auto_scroll();
  }

  @override
  void dispose() {
    page_controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    PageController new_page_controller = PageController(
      initialPage: page_controller.initialPage,
      viewportFraction: portrait ? 0.7 : 0.3,
    );

    page_controller = new_page_controller;

    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: PageView.builder(
            controller: page_controller,
            itemCount: widget.children.length,
            onPageChanged: (int page) {
              setState(() {
                current_page = page;
                widget.update_current_page(page);
              });
            },
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: widget.children[index],
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: SmoothPageIndicator(
            controller: page_controller,
            count: widget.children.length,
            effect: SwapEffect(
              dotColor: widget.dot_color_inactive,
              activeDotColor: current_page < widget.dot_colors_active.length
                  ? widget.dot_colors_active[current_page]
                  : widget.dot_colors_active.last,
              spacing: portrait ? 12 : 20,
              dotHeight: portrait ? 10 : 13,
              dotWidth: portrait ? 10 : 13,
            ),
          ),
        ),
      ],
    );
  }
}
