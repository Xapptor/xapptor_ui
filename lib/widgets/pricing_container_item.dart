import 'package:universal_platform/universal_platform.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:xapptor_ui/widgets/coming_soon_container.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/webview/webview.dart';

class PricingContainerItem extends StatefulWidget {
  const PricingContainerItem({
    required this.title,
    required this.price,
    required this.buy_text,
    required this.icon,
    required this.text_color,
    required this.button_color,
    required this.image_url,
    required this.gradient_1,
    required this.gradient_2,
    required this.coming_soon,
    required this.stripe_payment,
    required this.coming_soon_text,
  });

  final String title;
  final String price;
  final String buy_text;
  final IconData icon;
  final Color text_color;
  final Color button_color;
  final String image_url;
  final Color gradient_1;
  final Color gradient_2;
  final bool coming_soon;
  final StripePayment stripe_payment;
  final String coming_soon_text;

  @override
  _PricingContainerItemState createState() => _PricingContainerItemState();
}

class _PricingContainerItemState extends State<PricingContainerItem> {
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
        "https://us-central1-abei-21f7c.cloudfunctions.net/stripeSessionView?priceID=${widget.stripe_payment.price_id}&userID=${widget.stripe_payment.user_id}&courseID=${widget.stripe_payment.course_id}&customerEmail=${widget.stripe_payment.customer_email}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
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
            linear_gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  widget.gradient_1,
                  widget.gradient_2,
                ],
                stops: [
                  0.8,
                  1.0
                ]),
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
