import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/widgets_carousel.dart';
import 'package:xapptor_logic/get_assets_names.dart';
import 'card_holder.dart';

class CardGallery extends StatefulWidget {
  const CardGallery({
    required this.screen_height,
    required this.text_list,
    required this.dot_colors_active,
    required this.dot_color_inactive,
    required this.auto_scroll,
    required this.update_current_page,
    required this.on_pressed,
    required this.current_page,
    required this.how_many_carousels,
    required this.carousel_length,
    required this.title_mod,
    required this.image_src_list,
    this.add_initial_space = false,
    this.shuffle_cards = false,
    this.reverse = false,
  });

  final double screen_height;
  final List<String> text_list;
  final List<Color> dot_colors_active;
  final Color dot_color_inactive;
  final bool auto_scroll;
  final Function({required int new_current_page}) update_current_page;
  final Function on_pressed;
  final int current_page;
  final int how_many_carousels;
  final int carousel_length;
  final int title_mod;
  final List<String> image_src_list;
  final bool add_initial_space;
  final bool shuffle_cards;
  final bool reverse;

  @override
  State<CardGallery> createState() => _CardGalleryState();
}

class _CardGalleryState extends State<CardGallery> {
  Widget card_gallery = Container();

  generate_card_gallery() async {
    int index = 0;
    bool reverse = true;

    List<Widget> card_holders = [];

    if (widget.add_initial_space) {
      card_holders.add(
        SizedBox(
          height: 30,
        ),
      );
    }

    for (var i = 0; i < widget.how_many_carousels; i++) {
      card_holders.add(
        SelectableText(
          widget.text_list[i],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      );
      final new_gallery = await generate_card_holders(
        index: index,
      );

      card_holders.add(
        Container(
          height: widget.screen_height / 2,
          padding: EdgeInsets.only(bottom: widget.screen_height / 12),
          child: WidgetsCarousel(
            update_current_page: (int new_current_page) {
              widget.update_current_page(new_current_page: new_current_page);
            },
            auto_scroll: widget.auto_scroll,
            dot_colors_active: widget.dot_colors_active,
            dot_color_inactive: widget.dot_color_inactive,
            children: new_gallery,
          ),
        ),
      );
      reverse = !reverse;
      index += widget.carousel_length;
    }

    card_gallery = Column(children: card_holders);
    setState(() {});
  }

  Future<List<Widget>> generate_card_holders({
    required int index,
  }) async {
    double elevation = 3;
    double border_radius = 20;

    List<String> image_names = await get_assets_names(
      filter_keys: widget.image_src_list,
    );

    if (widget.shuffle_cards) {
      image_names.shuffle();
    }

    List<Widget> card_holders = [];
    image_names.forEach((images_name) {
      int image_names_index = image_names.indexOf(images_name);

      if (image_names_index < widget.carousel_length) {
        card_holders.add(
          CardHolder(
            title: image_names_index % widget.title_mod == 0 &&
                    widget.title_mod != -1
                ? widget.text_list.last
                : null,
            image_src: images_name,
            background_image_alignment: Alignment.center,
            image_fit: BoxFit.cover,
            on_pressed: () => widget.on_pressed(),
            elevation: elevation,
            border_radius: border_radius,
            is_focused: widget.current_page == image_names_index,
          ),
        );
      }
    });

    if (widget.reverse) {
      card_holders = card_holders.reversed.toList();
    }
    return card_holders;
  }

  @override
  void initState() {
    super.initState();
    generate_card_gallery();
  }

  @override
  Widget build(BuildContext context) {
    return card_gallery;
  }
}
