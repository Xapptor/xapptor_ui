import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/lum/vending_machines_list_card.dart';

class VendingMachinesListContainer extends StatefulWidget {
  @override
  _VendingMachinesListContainerState createState() =>
      _VendingMachinesListContainerState();
}

class _VendingMachinesListContainerState
    extends State<VendingMachinesListContainer> {
  List<VendingMachine> vending_machines = [];
  List<Widget> vending_machines_widgets = [];

  // Testing multiply vending machines
  int vending_machine_cards_multiplier = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    get_vending_machines();
  }

  get_vending_machines() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('vending_machines')
        .where(
          'admin',
          isEqualTo: uid,
        )
        .get()
        .then((QuerySnapshot query_snapshot) {
      query_snapshot.docs.forEach((DocumentSnapshot doc) {
        for (var i = 0; i < vending_machine_cards_multiplier; i++) {
          vending_machines.add(
            VendingMachine.from_snapshot(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          );

          VendingMachine last_vending_machine =
              vending_machines[vending_machines.length - 1];

          print("vending machine id: " + last_vending_machine.id);
          print("vending machine name: " + last_vending_machine.name);

          bool number_is_even = vending_machines.length % 2 == 0;

          double current_opacity = 0.8;

          Color current_card_color = number_is_even
              ? color_lum_green.withOpacity(current_opacity)
              : color_lum_light_pink.withOpacity(current_opacity);

          vending_machines_widgets.add(
            VendingMachinesListCard(
              vending_machine: last_vending_machine,
              color: current_card_color,
            ),
          );
        }
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return vending_machines_widgets.length == 0
        ? Container(
            child: Center(
              child: Text(
                "No tienes ninguna máquina expendedora",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: vending_machines_widgets,
            ),
          );
  }
}
