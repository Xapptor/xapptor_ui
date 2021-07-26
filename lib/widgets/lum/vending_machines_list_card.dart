import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_routing/app_screen.dart';
import 'package:xapptor_routing/app_screens.dart';
import 'package:xapptor_ui/screens/lum/vending_machine_details.dart';

class VendingMachinesListCard extends StatefulWidget {
  const VendingMachinesListCard({
    required this.vending_machine,
    required this.color,
  });

  final VendingMachine vending_machine;
  final Color color;

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
    double current_card_width = MediaQuery.of(context).size.width * 0.8;
    double current_card_margin = MediaQuery.of(context).size.height * 0.015;
    double current_card_padding = MediaQuery.of(context).size.width * 0.07;
    double name_size = 20;
    double title_size = 16;
    double subtitle_size = 14;
    double current_opacity = 0.8;

    Color final_card_color = widget.vending_machine.enabled
        ? widget.color
        : Colors.grey.withOpacity(current_opacity);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        add_new_app_screen(
          AppScreen(
            name: "home/vending_machine_details",
            child: VendingMachineDetails(
              vending_machine: widget.vending_machine,
              color: widget.color,
            ),
          ),
        );
        open_screen("home/vending_machine_details");
      },
      child: Container(
        height: current_card_height,
        width: current_card_width,
        margin: EdgeInsets.all(current_card_margin),
        padding: EdgeInsets.all(current_card_padding),
        decoration: BoxDecoration(
          color: final_card_color,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
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
                          color: Colors.white,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: title_size,
                      ),
                    ),
                    TextSpan(
                      text: widget.vending_machine.id,
                      style: TextStyle(
                        color: Colors.white,
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
                      text: "Habilitada: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: title_size,
                      ),
                    ),
                    TextSpan(
                      text: widget.vending_machine.enabled.toString(),
                      style: TextStyle(
                        color: Colors.white,
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
                      text: "Cambio: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: title_size,
                      ),
                    ),
                    TextSpan(
                      text: widget.vending_machine.money_change.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: subtitle_size,
                      ),
                    ),
                    TextSpan(
                      text: "\$",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
    );
  }
}
