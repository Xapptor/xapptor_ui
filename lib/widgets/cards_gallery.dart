import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/widgets_carousel.dart';
import 'card_holder.dart';

Widget generate_cards_gallery({
  required double screen_height,
  required List<String> text_list,
  required List<Color> dot_colors_active,
  required Color dot_color_inactive,
  required bool auto_scroll,
  required Function({required int new_current_page}) update_current_page,
  required Function on_pressed,
  required int current_page,
  required int carousel_number,
  required int carousel_length,
  required int title_mod,
  required List<String> image_src_list,
  required String image_extension,
  bool add_initial_space = false,
}) {
  int index = 0;
  bool reverse = true;

  List<Widget> card_holders = [];

  if (add_initial_space) {
    card_holders.add(
      SizedBox(
        height: 30,
      ),
    );
  }

  for (var i = 0; i < carousel_number; i++) {
    card_holders.add(
      SelectableText(
        text_list[i],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
    card_holders.add(
      Container(
        height: screen_height / 2,
        padding: EdgeInsets.only(bottom: screen_height / 12),
        child: WidgetsCarousel(
          update_current_page: (int new_current_page) {
            update_current_page(new_current_page: new_current_page);
          },
          auto_scroll: auto_scroll,
          dot_colors_active: dot_colors_active,
          dot_color_inactive: dot_color_inactive,
          children: generate_card_holders(
            index: index,
            length: carousel_length,
            reverse: false,
            text_list: text_list,
            on_pressed: on_pressed,
            current_page: current_page,
            title_mod: title_mod,
            image_src_list: image_src_list,
            image_extension: image_extension,
          ),
        ),
      ),
    );
    reverse = !reverse;
    index += carousel_length;
  }

  return Column(children: card_holders);
}

List<Widget> generate_card_holders({
  required int index,
  required int length,
  required bool reverse,
  required List<String> text_list,
  required Function on_pressed,
  required int current_page,
  required int title_mod,
  required List<String> image_src_list,
  required String image_extension,
}) {
  double elevation = 3;
  double border_radius = 20;

  List<Widget> card_holders = [];
  for (var i = 0; i < length; i++) {
    card_holders.add(
      CardHolder(
        title: i % title_mod == 0 ? text_list.last : null,
        image_src: image_src_list.length > 1
            ? image_src_list[index + i]
            : image_src_list.first + "_${index + i + 1}.$image_extension",
        background_image_alignment: Alignment.center,
        image_fit: BoxFit.cover,
        on_pressed: () => on_pressed(),
        elevation: elevation,
        border_radius: border_radius,
        is_focused: current_page == i,
      ),
    );
  }
  if (reverse) {
    card_holders = card_holders.reversed.toList();
  }
  return card_holders;
}
