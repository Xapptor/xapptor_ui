import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';

class InsuranceCatalogItem extends StatefulWidget {
  final List<String> texts;
  final Color icon_color;
  final Color card_background_color;
  final String insurance_image_path;
  final Function more_information_function;

  const InsuranceCatalogItem({
    super.key,
    required this.texts,
    required this.icon_color,
    required this.card_background_color,
    required this.insurance_image_path,
    required this.more_information_function,
  });

  @override
  State<InsuranceCatalogItem> createState() => _InsuranceCatalogItemState();
}

class _InsuranceCatalogItemState extends State<InsuranceCatalogItem> {
  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    return Card(
      elevation: 10,
      semanticContainer: true,
      color: widget.card_background_color,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.insurance_image_path),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Spacer(flex: portrait ? 5 : 8),
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: AutoSizeText(
                  widget.texts[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  minFontSize: 18,
                  maxFontSize: 22,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: FractionallySizedBox(
                widthFactor: 0.72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        widget.texts[1],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        minFontSize: 10,
                        maxFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        widget.texts[2],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        minFontSize: 10,
                        maxFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        widget.texts[3],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        minFontSize: 10,
                        maxFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: TextButton(
                  onPressed: () {
                    widget.more_information_function();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.visibility,
                          color: widget.icon_color,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Quiero más información",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            color: widget.icon_color,
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
