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
  bool fisrt_time_on_abeinstitute = true;

  loaded_callback(String url) async {
    if (!UniversalPlatform.isWeb) {
      if (url.contains("abeinstitute.com")) {
        if (fisrt_time_on_abeinstitute) {
          fisrt_time_on_abeinstitute = false;
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
