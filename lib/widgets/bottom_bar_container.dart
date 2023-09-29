import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class BottomBarContainer extends StatefulWidget {
  const BottomBarContainer({
    super.key,
    required this.bottom_bar_buttons,
    required this.initial_page,
    required this.current_page_callback,
  });
  final List<BottomBarButton> bottom_bar_buttons;
  final int initial_page;
  final Function(int i) current_page_callback;

  @override
  State<BottomBarContainer> createState() => _BottomBarContainerState();
}

class _BottomBarContainerState extends State<BottomBarContainer> {
  int current_page = 0;
  PageController page_controller = PageController(initialPage: 0);
  List<Widget> buttons = [];
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    update_current_page();
  }

  // Update current page.

  update_current_page() {
    Timer(const Duration(milliseconds: 500), () {
      current_page = widget.initial_page;
      page_controller.jumpToPage(current_page);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double view_padding_bottom = MediaQuery.of(context).viewPadding.bottom;
    bool has_view_padding_bottom = view_padding_bottom > 0;

    pages = [];
    buttons = [];
    for (var button in widget.bottom_bar_buttons) {
      Color final_foreground_color = current_page == widget.bottom_bar_buttons.indexOf(button)
          ? button.foreground_color
          : button.foreground_color.withOpacity(0.5);

      pages.add(button.page);
      buttons.add(
        Expanded(
          flex: 1,
          child: CustomCard(
            on_pressed: () {
              int new_page_index = pages.indexOf(button.page);
              page_controller.animateToPage(
                new_page_index,
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
              );
            },
            border_radius: 0,
            linear_gradient: LinearGradient(
              colors: [
                button.background_color,
                button.background_color,
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: has_view_padding_bottom ? 10 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    button.icon,
                    color: final_foreground_color,
                  ),
                  Text(
                    button.text,
                    style: TextStyle(
                      color: final_foreground_color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          flex: has_view_padding_bottom ? 28 : 11,
          child: PageView(
            onPageChanged: (int page) {
              setState(() {
                current_page = page;
                widget.current_page_callback(current_page);
              });
            },
            controller: page_controller,
            children: pages,
          ),
        ),
        Expanded(
          flex: has_view_padding_bottom ? 3 : 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ),
      ],
    );
  }
}
