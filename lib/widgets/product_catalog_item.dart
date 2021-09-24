import 'package:universal_platform/universal_platform.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:xapptor_ui/widgets/coming_soon_container.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

class ProductCatalogItem extends StatefulWidget {
  const ProductCatalogItem({
    required this.title,
    required this.price,
    required this.buy_text,
    required this.icon,
    required this.text_color,
    required this.button_color,
    required this.image_url,
    required this.linear_gradient,
    required this.stripe_payment,
    required this.coming_soon,
    required this.coming_soon_text,
  });

  final String title;
  final String price;
  final String buy_text;
  final IconData icon;
  final Color text_color;
  final Color button_color;
  final String image_url;
  final LinearGradient linear_gradient;
  final StripePayment stripe_payment;
  final bool coming_soon;

  final String coming_soon_text;

  @override
  _ProductCatalogItemState createState() => _ProductCatalogItemState();
}

class _ProductCatalogItemState extends State<ProductCatalogItem> {
  double border_radius = 10;
  bool fisrt_time_on_checkout = true;

  loaded_callback(String url) async {
    if (!UniversalPlatform.isWeb) {
      if (url.contains("checkout.stripe.com")) {
        if (fisrt_time_on_checkout) {
          fisrt_time_on_checkout = false;

          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentWebview(url: url),
            ),
          );
          Navigator.of(context).pop();
        }
      }
    }
  }

  late var webview_controller;

  controller_callback(var current_webview_controller) {
    webview_controller = current_webview_controller;
  }

  Widget buy_now_button() {
    List<Widget> children = [];

    if (!widget.coming_soon) {
      if (widget.stripe_payment.user_id.isEmpty) {
        children.add(
          TextButton(
            onPressed: () {
              open_screen("login");
            },
            child: Center(
              child: Container(),
            ),
          ),
        );
      } else {
        children.add(
          FractionallySizedBox(
            heightFactor: 0.98,
            widthFactor: 0.98,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                border_radius,
              ),
              child: Webview(
                src: url,
                //src: "https://www.google.com",
                id: Uuid().v4(),
                controller_callback: controller_callback,
                loaded_callback: loaded_callback,
              ),
            ),
          ),
        );
      }
    }

    children.add(
      IgnorePointer(
        child: Container(
          child: Center(
            child: Text(
              widget.buy_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.text_color,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: widget.button_color,
            borderRadius: BorderRadius.circular(border_radius),
          ),
        ),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: children,
    );
  }

  late String url;

  @override
  void initState() {
    url =
        "${widget.stripe_payment.session_view_url}?checkout_session_url=${widget.stripe_payment.checkout_session_url}&publishable_key=${widget.stripe_payment.publishable_key}&price_id=${widget.stripe_payment.price_id}&user_id=${widget.stripe_payment.user_id}&course_id=${widget.stripe_payment.product_id}&customer_email=${widget.stripe_payment.customer_email}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      widthFactor: 0.9,
      child: ComingSoonContainer(
        text: widget.coming_soon_text,
        border_radius: border_radius,
        enable_cover: widget.coming_soon,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border_radius),
          ),
          margin: EdgeInsets.all(0),
          elevation: 5,
          child: BackgroundImageWithGradientColor(
            height: double.maxFinite,
            border_radius: border_radius,
            box_fit: BoxFit.cover,
            image_path: widget.image_url,
            linear_gradient: widget.linear_gradient,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 18),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.text_color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Spacer(flex: 1),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.text_color,
                            fontSize: 36,
                          ),
                        ),
                        TextSpan(
                          text: widget.price,
                          style: TextStyle(
                            color: widget.text_color,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: buy_now_button(),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
