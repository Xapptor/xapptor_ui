import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/vending_machine.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/screens/vending_machine_details.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_logic/is_portrait.dart';

class VendingMachineCard extends StatefulWidget {
  const VendingMachineCard({
    required this.vending_machine,
    required this.remove_vending_machine_callback,
    required this.owner_name,
  });

  final VendingMachine vending_machine;
  final Function remove_vending_machine_callback;
  final String owner_name;

  @override
  _VendingMachineCardState createState() => _VendingMachineCardState();
}

class _VendingMachineCardState extends State<VendingMachineCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double current_card_height = MediaQuery.of(context).size.height / 4;
    double name_size = 22;
    double title_size = 16;
    EdgeInsets margin = EdgeInsets.all(10);

    return FractionallySizedBox(
      widthFactor: portrait ? 0.85 : 0.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: current_card_height,
            margin: margin,
            child: CustomCard(
              splash_color: color_lum_blue.withOpacity(0.2),
              elevation: 3,
              border_radius: 10,
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
              child: Container(
                margin: margin * 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 12,
                      child: Center(
                        child: Text(
                          widget.vending_machine.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color_lum_green,
                            fontSize: name_size,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "ID: " + widget.vending_machine.id,
                        style: TextStyle(
                          color: color_lum_grey,
                          fontSize: title_size,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "CAMBIO \$" +
                                  widget.vending_machine.money_change
                                      .toString(),
                              style: TextStyle(
                                color: color_lum_blue,
                                fontSize: title_size,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.owner_name,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: color_lum_blue,
                                fontSize: title_size,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: current_card_height,
            margin: margin,
            child: Stack(
              alignment: Alignment.center,
              children: [
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
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      show_delete_vending_machine_dialog(
                        context,
                        widget.vending_machine.id,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  show_delete_vending_machine_dialog(
      BuildContext context, String vending_machine_id) async {
    double sized_box_height = 10;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: sized_box_height),
                  Text(
                    "¿Eliminar esta máquina?",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: sized_box_height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("vending_machines")
                              .doc(vending_machine_id)
                              .delete()
                              .then((value) async {
                            widget.remove_vending_machine_callback();
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Aceptar"),
                      ),
                    ],
                  ),
                  SizedBox(height: sized_box_height),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
