import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/dispenser.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_logic/get_temporary_svg_file.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/switch_button.dart';
import 'package:xapptor_ui/widgets/topbar_back_button_navigator_1.dart';
import 'package:xapptor_ui/webview/webview.dart';

class DispenserDetails extends StatefulWidget {
  const DispenserDetails({
    required this.product,
    required this.dispenser,
    required this.dispenser_id,
    required this.allow_edit_enabled,
  });

  final Product product;
  final Dispenser dispenser;
  final String dispenser_id;
  final bool allow_edit_enabled;

  @override
  State<StatefulWidget> createState() => _DispenserDetailsState();
}

class _DispenserDetailsState extends State<DispenserDetails> {
  bool dispenser_enabled = false;
  bool enable_dispenser_edit = true;
  Color main_color = Colors.black;
  String base64_png = "";
  Uint8List? image_svg_bytes = null;

  switch_button_callback(bool dispenser_enabled_new_value) {
    setState(() {
      dispenser_enabled = dispenser_enabled_new_value;
    });
  }

  update_base64_png(String new_base64_png) {
    base64_png = new_base64_png;
    log("base64_png: " + base64_png);
  }

  check_mainColor() async {
    image_svg_bytes = await get_temporary_svg_file(widget.product.url);
    // main_color = await get_main_color();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      check_mainColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            topbar_back_button_navigator_1(
              context: context,
              background_color: color_lum_light_pink,
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 3,
                      child: Webview(
                        id: "20",
                        src: widget.product.url,
                        function: () {},
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                "DISPENSADOR ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: color_lum_grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                widget.dispenser_id,
                                style: TextStyle(
                                  color: main_color,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        heightFactor: 0.5,
                        widthFactor: 0.7,
                        child: switch_button(
                          value: dispenser_enabled,
                          enabled: enable_dispenser_edit,
                          active_track_color: main_color,
                          active_color: Colors.white,
                          background_color: main_color,
                          callback: switch_button_callback,
                          border_radius: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "CANTIDAD DISPONIBLE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: main_color,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      widget.dispenser.quantity_remaining
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: main_color,
                                        fontSize: 70,
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      " LITROS",
                                      style: TextStyle(
                                        color: color_lum_grey,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
