import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class BottomBarContainer extends StatefulWidget {
  const BottomBarContainer({
    required this.bottom_bar_buttons,
  });
  final List<BottomBarButton> bottom_bar_buttons;

  @override
  _BottomBarContainerState createState() => _BottomBarContainerState();
}

class _BottomBarContainerState extends State<BottomBarContainer> {
  int current_page = 0;
  PageController page_controller = PageController(initialPage: 0);
  List<Widget> buttons = [];
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pages = [];
    buttons = [];
    for (var button in widget.bottom_bar_buttons) {
      Color final_foreground_color =
          current_page == widget.bottom_bar_buttons.indexOf(button)
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
                duration: Duration(milliseconds: 150),
                curve: Curves.linear,
              );
            },
            elevation: null,
            border_radius: 0,
            linear_gradient: LinearGradient(
              colors: [
                button.background_color,
                button.background_color,
              ],
            ),
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
      );
    }

    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  current_page = page;
                });
              },
              controller: page_controller,
              children: pages,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
          ),
        ],
      ),
    );
  }
}
