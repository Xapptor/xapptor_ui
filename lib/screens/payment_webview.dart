import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';
import 'package:universal_platform/universal_platform.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    required this.url,
  });

  final String url;

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  bool fisrt_time_on_host = true;

  loaded_callback(String url) async {
    if (!UniversalPlatform.isWeb) {
      if (url.contains(Uri.base.host)) {
        if (fisrt_time_on_host) {
          fisrt_time_on_host = false;
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Webview(
          src: widget.url,
          id: Uuid().v4(),
          loaded_callback: loaded_callback,
        ),
      ),
    );
  }
}

class StripePayment {
  final String publishable_key;
  final String session_view_url;
  final String checkout_session_url;
  final String price_id;
  final String user_id;
  final String product_id;
  final String customer_email;
  final String success_url;
  final String cancel_url;
  final String stripe_key;

  StripePayment({
    required this.publishable_key,
    required this.session_view_url,
    required this.checkout_session_url,
    required this.price_id,
    required this.user_id,
    required this.product_id,
    required this.customer_email,
    required this.success_url,
    required this.cancel_url,
    required this.stripe_key,
  });
}
