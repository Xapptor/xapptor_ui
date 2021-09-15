import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String id;
  final int amount;
  final DateTime date;
  final int dispenser;
  final String product_id;
  final String user_id;
  final String vending_machine_id;

  const Payment({
    required this.id,
    required this.amount,
    required this.date,
    required this.dispenser,
    required this.product_id,
    required this.user_id,
    required this.vending_machine_id,
  });

  Payment.from_snapshot(String id, Map<String, dynamic> snapshot)
      : id = id,
        amount = snapshot['amount'],
        date = (snapshot['date'] as Timestamp).toDate(),
        dispenser = snapshot['dispenser'],
        product_id = snapshot['product_id'],
        user_id = snapshot['user_id'],
        vending_machine_id = snapshot['vending_machine_id'];

  Map<String, dynamic> to_json() {
    return {
      'amount': amount,
      'date': date,
      'dispenser': dispenser,
      'product_id': product_id,
      'user_id': user_id,
      'vending_machine_id': vending_machine_id,
    };
  }
}

List<Map<String, dynamic>> payment_list_to_json_list(List<Payment> payments) {
  List<Map<String, dynamic>> json_list = [];

  payments.forEach((payment) {
    json_list.add(payment.to_json());
  });

  return json_list;
}
