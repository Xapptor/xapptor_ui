import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:flutter/material.dart';
import 'insurance_catalog_item.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class InsuranceCatalog extends StatefulWidget {
  const InsuranceCatalog({
    super.key,
    required this.texts,
    required this.icon_color,
    required this.container_background_color,
    required this.container_background_image,
    required this.card_background_color,
    required this.linear_gradient_colors,
    required this.insurance_image_path_1,
    required this.insurance_image_path_2,
    required this.insurance_image_path_3,
    required this.more_information_function,
  });

  final List<String> texts;
  final Color icon_color;
  final Color container_background_color;
  final String container_background_image;
  final Color card_background_color;
  final List<Color> linear_gradient_colors;
  final String insurance_image_path_1;
  final String insurance_image_path_2;
  final String insurance_image_path_3;
  final Function more_information_function;

  @override
  State<InsuranceCatalog> createState() => _InsuranceCatalogState();
}

class _InsuranceCatalogState extends State<InsuranceCatalog> {
  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    double height = portrait ? (MediaQuery.of(context).size.height * 3.5) : (MediaQuery.of(context).size.height);

    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: BackgroundImageWithGradientColor(
        height: height,
        box_fit: BoxFit.cover,
        image_path: null,
        linear_gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          colors: widget.linear_gradient_colors,
          stops: const [0.0, 1.0],
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                alignment: Alignment.center,
                widthFactor: 0.8,
                child: Text(
                  widget.texts[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 12 : 6,
              child: FractionallySizedBox(
                widthFactor: portrait ? 0.8 : 0.8,
                child: Flex(
                  direction: portrait ? Axis.vertical : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 6,
                      child: InsuranceCatalogItem(
                        texts: widget.texts.sublist(1, 5),
                        icon_color: widget.icon_color,
                        card_background_color: widget.card_background_color,
                        insurance_image_path: widget.insurance_image_path_1,
                        more_information_function: widget.more_information_function,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 6,
                      child: InsuranceCatalogItem(
                        texts: widget.texts.sublist(5, 9),
                        icon_color: widget.icon_color,
                        card_background_color: widget.card_background_color,
                        insurance_image_path: widget.insurance_image_path_2,
                        more_information_function: widget.more_information_function,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 6,
                      child: InsuranceCatalogItem(
                        texts: widget.texts.sublist(9, 13),
                        icon_color: widget.icon_color,
                        card_background_color: widget.card_background_color,
                        insurance_image_path: widget.insurance_image_path_3,
                        more_information_function: widget.more_information_function,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
