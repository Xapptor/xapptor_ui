import 'package:xapptor_ui/models/lum/dispenser.dart';

class VendingMachine {
  final String id;
  final String admin;
  final List<Dispenser> dispensers;
  final bool enabled;
  final int money_change;
  final String name;

  const VendingMachine({
    required this.id,
    required this.admin,
    required this.dispensers,
    required this.enabled,
    required this.money_change,
    required this.name,
  });

  VendingMachine.from_snapshot(String id, Map<String, dynamic> snapshot)
      : id = id,
        admin = snapshot['admin'],
        dispensers = List<Dispenser>.from(
          snapshot['dispensers'].map((dispenser) {
            return Dispenser.from_snapshot(dispenser);
          }).toList(),
        ),
        enabled = snapshot['enabled'],
        money_change = snapshot['money_change'],
        name = snapshot['name'];

  Map<String, dynamic> to_json() {
    List<Map<String, dynamic>> map_dispenser_list = [];

    dispensers.forEach((Dispenser dispenser) {
      map_dispenser_list.add(dispenser.to_json());
    });

    return {
      'admin': admin,
      'dispensers': map_dispenser_list,
      'enabled': enabled,
      'money_change': money_change,
      'name': name,
    };
  }
}
