import 'package:flutter/material.dart';

class VendingMachinesList extends StatefulWidget {
  const VendingMachinesList({
    required this.vending_machines_widgets,
  });

  final List<Widget> vending_machines_widgets;

  @override
  _VendingMachinesListState createState() => _VendingMachinesListState();
}

class _VendingMachinesListState extends State<VendingMachinesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.vending_machines_widgets.length == 0
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
              children: widget.vending_machines_widgets,
            ),
          );
  }
}
