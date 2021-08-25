import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/screens/lum/product_list.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_ui/widgets/switch_button.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class VendingMachineDetails extends StatefulWidget {
  const VendingMachineDetails({
    required this.vending_machine,
  });

  final VendingMachine vending_machine;

  @override
  _VendingMachineDetailsState createState() => _VendingMachineDetailsState();
}

class _VendingMachineDetailsState extends State<VendingMachineDetails> {
  TextEditingController _controller_name = TextEditingController();
  bool is_editing = false;
  bool enabled = true;

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

  switch_button_callback(bool new_value) {
    setState(() {
      enabled = new_value;
    });
  }

  set_values() {
    _controller_name.text = widget.vending_machine.name;
    enabled = widget.vending_machine.enabled;
  }

  show_save_data_alert_dialog({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Deseas guardar los cambios?"),
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
                  "enabled": enabled,
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
    double textfield_size = 24;
    double title_size = 20;
    double subtitle_size = 18;
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: TopBar(
        background_color: color_lum_topbar,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
        logo_color: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: portrait ? 0.7 : 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 4),
              Expanded(
                flex: 2,
                child: TextField(
                  onTap: () {
                    //
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color_lum_green,
                    fontSize: textfield_size,
                  ),
                  controller: _controller_name,
                  decoration: InputDecoration(
                    hintText: "Nombre",
                    hintStyle: TextStyle(
                      color: color_lum_green,
                      fontSize: textfield_size,
                    ),
                  ),
                  enabled: is_editing,
                ),
              ),
              Expanded(
                flex: 1,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "ID: ",
                        style: TextStyle(
                          color: color_lum_grey,
                          fontSize: subtitle_size,
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
                flex: 1,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "CAMBIO \$",
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: color_lum_light_pink,
                          fontSize: title_size,
                        ),
                      ),
                      TextSpan(
                        text: widget.vending_machine.money_change.toString(),
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: color_lum_light_pink,
                          fontSize: title_size,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 0.8,
                  widthFactor: 0.7,
                  child: switch_button(
                    text: "HABILITADO",
                    value: enabled,
                    enabled: is_editing,
                    active_track_color: color_lum_blue,
                    active_color: Colors.white,
                    background_color: color_lum_blue,
                    callback: switch_button_callback,
                    border_radius: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 0.8,
                  widthFactor: 0.7,
                  child: Container(
                    child: CustomCard(
                      child: Text(
                        "DISPENSADORES",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      border_radius: MediaQuery.of(context).size.width,
                      on_pressed: () {
                        add_new_app_screen(
                          AppScreen(
                            name:
                                "home/vending_machine_details/dispensers_list",
                            child: ProductList(
                              vending_machine_id: widget.vending_machine.id,
                              allow_edit: true,
                              has_topbar: true,
                              for_dispensers: true,
                            ),
                          ),
                        );
                        open_screen(
                            "home/vending_machine_details/dispensers_list");
                      },
                      linear_gradient: LinearGradient(
                        colors: [
                          color_lum_blue.withOpacity(0.4),
                          color_lum_green.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
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
    );
  }
}
