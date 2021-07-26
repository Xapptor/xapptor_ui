import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_routing/app_screen.dart';
import 'package:xapptor_routing/app_screens.dart';

class VendingMachineDetails extends StatefulWidget {
  const VendingMachineDetails({
    required this.vending_machine,
    required this.color,
  });

  final VendingMachine vending_machine;
  final Color color;

  @override
  _VendingMachineDetailsState createState() => _VendingMachineDetailsState();
}

class _VendingMachineDetailsState extends State<VendingMachineDetails> {
  TextEditingController _controller_name = TextEditingController();
  bool is_editing = false;
  bool vending_machine_is_enabled = true;

  @override
  void dispose() {
    _controller_name.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    set_values();
  }

  set_values() {
    _controller_name.text = widget.vending_machine.name;
    vending_machine_is_enabled = widget.vending_machine.enabled;
  }

  show_save_data_alert_dialog({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Deseas guardar los cambios?"),
          //content: Text(""),
          actions: <Widget>[
            TextButton(
              child: Text("Descartar cambios"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Aceptar"),
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("vending_machines")
                    .doc(widget.vending_machine.id)
                    .update({
                  "name": _controller_name.text,
                  "enabled": vending_machine_is_enabled,
                }).then((result) {
                  is_editing = false;
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double current_card_height = MediaQuery.of(context).size.height / 4;
    double current_card_width = MediaQuery.of(context).size.width * 0.8;
    double current_card_margin = MediaQuery.of(context).size.height * 0.015;
    double current_card_padding = MediaQuery.of(context).size.width * 0.07;
    double title_size = 16;
    double subtitle_size = 14;
    double current_opacity = 0.8;
    double sized_box_height = MediaQuery.of(context).size.height / 16;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: sized_box_height,
            ),
            Center(
              child: Container(
                height: current_card_height,
                width: current_card_width,
                margin: EdgeInsets.all(current_card_margin),
                padding: EdgeInsets.all(current_card_padding),
                decoration: BoxDecoration(
                  color: vending_machine_is_enabled
                      ? widget.color
                      : Colors.grey.withOpacity(current_opacity),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        onTap: () {
                          //
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _controller_name,
                        decoration: InputDecoration(
                          hintText: "Nombre",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: subtitle_size,
                          ),
                        ),
                        enabled: is_editing,
                      ),
                    ),
                    Expanded(
                      flex: 3,
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
                      flex: 3,
                      child: Row(
                        children: [
                          RichText(
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
                                  text: vending_machine_is_enabled.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: subtitle_size,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: vending_machine_is_enabled,
                            onChanged: is_editing
                                ? (value) {
                                    setState(() {
                                      vending_machine_is_enabled = value;
                                    });
                                  }
                                : null,
                            activeTrackColor: color_lum_green,
                            activeColor: color_lum_light_pink,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
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
                              text: widget.vending_machine.money_change
                                  .toString(),
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
            ),
            Center(
              child: Container(
                height: current_card_height * 1.8,
                width: current_card_width,
                margin: EdgeInsets.all(current_card_margin),
                padding: EdgeInsets.all(current_card_padding),
                decoration: BoxDecoration(
                  color: vending_machine_is_enabled
                      ? widget.color
                      : Colors.grey.withOpacity(current_opacity),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    trailing: Icon(
                      Icons.coffee_maker_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Lista de Dispensadores",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    children: [
                      for (var dispenser in widget.vending_machine.dispensers)
                        InkWell(
                          onTap: () {
                            add_new_app_screen(
                              AppScreen(
                                name:
                                    "home/vending_machine_details/dispenser_details",
                                // child: DispenserDetails(
                                //   vending_machine: widget.vending_machine,
                                //   dispenser_index: widget
                                //       .vending_machine.dispensers
                                //       .indexOf(dispenser),
                                //   color: widget.color,
                                // ),
                                child: Container(),
                              ),
                            );
                            open_screen(
                                "home/vending_machine_details/dispenser_details");
                          },
                          child: Container(
                            margin: EdgeInsets.all(current_card_margin),
                            child: Text(
                              "Dispensador " +
                                  widget.vending_machine.dispensers
                                      .indexOf(dispenser)
                                      .toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (is_editing) {
                show_save_data_alert_dialog(
                  context: context,
                );
              } else {
                is_editing = true;
              }
            });
          },
          backgroundColor: color_lum_green,
          child: Icon(
            is_editing ? Icons.done : Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
