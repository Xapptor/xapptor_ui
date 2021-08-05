import 'package:flutter/material.dart';
import 'package:xapptor_logic/get_main_color_from_remote_svg.dart';
import 'package:xapptor_ui/models/lum/dispenser.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/switch_button.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class DispenserDetails extends StatefulWidget {
  const DispenserDetails({
    required this.product,
    required this.dispenser,
    required this.dispenser_id,
    required this.allow_edit,
    required this.update_enabled_in_dispenser,
  });

  final Product product;
  final Dispenser dispenser;
  final int dispenser_id;
  final bool allow_edit;
  final Function(int index, bool enabled) update_enabled_in_dispenser;

  @override
  State<StatefulWidget> createState() => _DispenserDetailsState();
}

class _DispenserDetailsState extends State<DispenserDetails> {
  bool dispenser_enabled = false;
  bool enable_dispenser_edit = true;
  Color main_color = Colors.grey;

  switch_button_callback(bool new_value) {
    setState(() {
      dispenser_enabled = new_value;
      widget.update_enabled_in_dispenser(
        widget.dispenser_id,
        dispenser_enabled,
      );
    });
  }

  check_main_color() async {
    main_color = await get_main_color_from_remote_svg(widget.product.url);
    setState(() {});
  }

  check_enabled() {
    dispenser_enabled = widget.dispenser.enabled;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    check_main_color();
    check_enabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        background_color: main_color,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
        logo_color: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
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
                          (widget.dispenser_id + 1).toString(),
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
                        heightFactor: 0.6,
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
                    )
                  : Container(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
