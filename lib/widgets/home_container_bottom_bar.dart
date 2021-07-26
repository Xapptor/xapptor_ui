import 'package:flutter/material.dart';

class HomeContainerWithPagesAndBottomBar extends StatefulWidget {
  const HomeContainerWithPagesAndBottomBar({
    required this.bottom_bar_color,
    required this.icon_color,
    required this.pages,
    required this.icons,
    required this.texts,
  });

  final Color bottom_bar_color;
  final Color icon_color;
  final List<Widget> pages;
  final List<IconData> icons;
  final List<String>? texts;

  @override
  _HomeContainerWithPagesAndBottomBarState createState() =>
      _HomeContainerWithPagesAndBottomBarState();
}

class _HomeContainerWithPagesAndBottomBarState
    extends State<HomeContainerWithPagesAndBottomBar> {
  List<Widget> buttons = [];
  List<Icon> icons = [];
  List<Text> texts = [];

  int current_page = 0;
  PageController page_controller = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    populate_icons();
  }

  populate_icons() {
    icons = [];
    for (var icon in widget.icons) {
      icons.add(
        Icon(
          icon,
          color: current_page == widget.icons.indexOf(icon)
              ? widget.icon_color
              : widget.icon_color.withOpacity(0.5),
        ),
      );
    }
    populate_texts();
  }

  populate_texts() {
    texts = [];

    if (widget.texts != null) {
      for (var text in widget.texts!) {
        texts.add(
          Text(
            text,
            style: TextStyle(
              color: current_page == widget.texts!.indexOf(text)
                  ? widget.icon_color
                  : widget.icon_color.withOpacity(0.5),
            ),
          ),
        );
      }
    }
    populate_buttons();
  }

  populate_buttons() {
    buttons = [];

    setState(() {
      for (var icon in icons) {
        buttons.add(
          InkWell(
            onTap: () {
              int new_page_index = icons.indexOf(icon);

              print("new_page_index: " + new_page_index.toString());

              page_controller.animateToPage(
                new_page_index,
                duration: Duration(milliseconds: 150),
                curve: Curves.linear,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                texts[icons.indexOf(icon)],
              ],
            ),
          ),
        );
      }
    });
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
                  populate_icons();
                });
              },
              controller: page_controller,
              children: widget.pages,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: widget.bottom_bar_color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
