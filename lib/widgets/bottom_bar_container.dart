import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';

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

  List<List<Widget>> generate_widgets() {
    pages = [];
    buttons = [];
    List<List<Widget>> widgets = [];
    for (var button in widget.bottom_bar_buttons) {
      Color final_foreground_color =
          current_page == widget.bottom_bar_buttons.indexOf(button)
              ? button.foreground_color
              : button.foreground_color.withOpacity(0.5);

      pages.add(button.page);
      buttons.add(
        Expanded(
          flex: 1,
          child: Container(
            color: button.background_color,
            child: InkWell(
              onTap: () {
                int new_page_index = widget.bottom_bar_buttons.indexOf(button);

                page_controller.animateToPage(
                  new_page_index,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.linear,
                );
                setState(() {});
              },
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
    widgets.add(pages);
    widgets.add(buttons);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
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
              children: generate_widgets()[0],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generate_widgets()[1],
            ),
          ),
        ],
      ),
    );
  }
}
