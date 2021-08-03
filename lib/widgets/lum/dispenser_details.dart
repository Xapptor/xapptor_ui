import 'package:flutter/material.dart';
import 'package:xapptor_logic/get_main_color_from_remote_svg.dart';
import 'package:xapptor_ui/models/lum/dispenser.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/switch_button.dart';
import 'package:xapptor_ui/widgets/topbar_back_button_navigator_1.dart';
import 'package:xapptor_ui/webview/webview.dart';

class DispenserDetails extends StatefulWidget {
  const DispenserDetails({
    required this.product,
    required this.dispenser,
    required this.dispenser_id,
    required this.allow_edit,
  });

  final Product product;
  final Dispenser dispenser;
  final String dispenser_id;
  final bool allow_edit;

  @override
  State<StatefulWidget> createState() => _DispenserDetailsState();
}

class _DispenserDetailsState extends State<DispenserDetails> {
  bool dispenser_enabled = false;
  bool enable_dispenser_edit = true;
  Color main_color = Colors.grey;

  switch_button_callback(bool dispenser_enabled_new_value) {
    setState(() {
      dispenser_enabled = dispenser_enabled_new_value;
    });
  }

  check_mainColor() async {
    main_color = await get_main_color_from_remote_svg(widget.product.url);
    print("main_color: " + main_color.toString());
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
              background_color: main_color,
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
                    widget.allow_edit
                        ? Container()
                        : Expanded(
                            flex: 1,
                            child: Text(
                              widget.product.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: color_lum_grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                    widget.allow_edit
                        ? Expanded(
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
                                border_radius:
                                    MediaQuery.of(context).size.width,
                              ),
                            ),
                          )
                        : Container(),
                    widget.allow_edit
                        ? Expanded(
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
                                          alignment:
                                              PlaceholderAlignment.middle,
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
                                          alignment:
                                              PlaceholderAlignment.middle,
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
                          )
                        : Container(),
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
