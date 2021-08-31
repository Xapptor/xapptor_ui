import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/widgets/lum/vending_machine_card.dart';

class VendingMachinesList extends StatefulWidget {
  @override
  _VendingMachinesListState createState() => _VendingMachinesListState();
}

class _VendingMachinesListState extends State<VendingMachinesList> {
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

    vending_machines_widgets.clear();
    vending_machines.clear();

    await FirebaseFirestore.instance
        .collection('vending_machines')
        .where(
          'user_id',
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

        vending_machines_widgets.add(
          VendingMachineCard(
            vending_machine: vending_machines.last,
            remove_vending_machine_callback: get_vending_machines,
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
