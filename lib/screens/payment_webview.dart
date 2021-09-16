import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    required this.url,
  });

  final String url;

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Webview(
        src: widget.url,
        id: Uuid().v4(),
        function: () {},
      ),
    );
  }
}

class StripePayment {
  final String price_id;
  final String user_id;
  final String customer_email;
  final String course_id;

  StripePayment({
    required this.price_id,
    required this.user_id,
    required this.customer_email,
    required this.course_id,
  });
}
