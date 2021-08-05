import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/screens/lum/vending_machine_details.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class VendingMachinesListCard extends StatefulWidget {
  const VendingMachinesListCard({
    required this.vending_machine,
  });

  final VendingMachine vending_machine;

  @override
  _VendingMachinesListCardState createState() =>
      _VendingMachinesListCardState();
}

class _VendingMachinesListCardState extends State<VendingMachinesListCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double current_card_height = MediaQuery.of(context).size.height / 5;
    double current_card_width = MediaQuery.of(context).size.width * 0.9;
    double name_size = 20;
    double title_size = 16;
    double subtitle_size = 14;
    EdgeInsets margin = EdgeInsets.all(14);

    return Container(
      height: current_card_height,
      width: current_card_width,
      margin: margin,
      child: CustomCard(
        elevation: 3,
        border_radius: 5,
        on_pressed: () {
          add_new_app_screen(
            AppScreen(
              name: "home/vending_machine_details",
              child: VendingMachineDetails(
                vending_machine: widget.vending_machine,
              ),
            ),
          );
          open_screen("home/vending_machine_details");
        },
        linear_gradient: null,
        child: Stack(
          children: [
            Container(
              margin: margin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.vending_machine.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color_lum_green,
                                fontSize: name_size,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "ID: ",
                            style: TextStyle(
                              color: color_lum_grey,
                              fontSize: title_size,
                            ),
                          ),
                          TextSpan(
                            text: widget.vending_machine.id,
                            style: TextStyle(
                              color: color_lum_grey,
                              fontSize: subtitle_size,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "CAMBIO \$",
                            style: TextStyle(
                              color: color_lum_light_pink,
                              fontSize: title_size,
                            ),
                          ),
                          TextSpan(
                            text:
                                widget.vending_machine.money_change.toString(),
                            style: TextStyle(
                              color: color_lum_light_pink,
                              fontSize: subtitle_size,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 20,
                width: 20,
                margin: margin,
                decoration: BoxDecoration(
                  color: widget.vending_machine.enabled
                      ? Colors.green
                      : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
