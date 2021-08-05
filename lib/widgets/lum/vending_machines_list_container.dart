import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/widgets/lum/vending_machine_card.dart';

class VendingMachinesListContainer extends StatefulWidget {
  @override
  _VendingMachinesListContainerState createState() =>
      _VendingMachinesListContainerState();
}

class _VendingMachinesListContainerState
    extends State<VendingMachinesListContainer> {
  List<VendingMachine> vending_machines = [];
  List<Widget> vending_machines_widgets = [];

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
        vending_machines.add(
          VendingMachine.from_snapshot(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
        );
        VendingMachine last_vending_machine =
            vending_machines[vending_machines.length - 1];

        vending_machines_widgets.add(
          VendingMachineCard(
            vending_machine: last_vending_machine,
          ),
        );
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
