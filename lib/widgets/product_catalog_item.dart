import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xapptor_logic/is_portrait.dart';
import 'package:xapptor_router/initial_values_routing.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/screens/product_catalog.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:xapptor_ui/widgets/coming_soon_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_purchase_ios/store_kit_wrappers.dart';

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
    required this.use_iap,
  });

  final String title;
  final String price;
  final String buy_text;
  final IconData icon;
  final Color text_color;
  final Color button_color;
  final String image_url;
  final LinearGradient linear_gradient;
  final Payment stripe_payment;
  final bool coming_soon;
  final String coming_soon_text;
  final bool use_iap;

  @override
  _ProductCatalogItemState createState() => _ProductCatalogItemState();
}

class _ProductCatalogItemState extends State<ProductCatalogItem> {
  double border_radius = 10;

  @override
  void initState() {
    super.initState();
  }

  buy_now() async {
    bool product_was_acquired = await check_if_product_was_acquired(
      user_id: widget.stripe_payment.user_id,
      product_id: widget.stripe_payment.product_id,
    );
    if (product_was_acquired) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You already bought this item"),
        ),
      );
    } else {
      if (widget.use_iap) {
        call_iap();
      } else {
        call_stripe();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

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
                  Spacer(flex: 8),
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
                    flex: portrait ? 3 : 2,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        child: TextButton(
                          onPressed: () {
                            buy_now();
                          },
                          child: Center(
                            child: Text(
                              widget.buy_text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: widget.text_color,
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: widget.button_color,
                          borderRadius: BorderRadius.circular(border_radius),
                        ),
                      ),
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

  // In App Purchase.

  call_iap() async {
    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails({widget.stripe_payment.product_id});

    if (response.notFoundIDs.isNotEmpty) {
      print("Not Found IDs");
    } else {
      var transactions = await SKPaymentQueueWrapper().transactions();
      transactions.forEach((skPaymentTransactionWrapper) {
        SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      });

      List<ProductDetails> productDetails = response.productDetails;

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails[0]);
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  // Stripe Payment.

  call_stripe() async {
    if (!widget.coming_soon) {
      if (widget.stripe_payment.user_id.isEmpty) {
        open_screen("login");
      } else {
        var payments_doc = await FirebaseFirestore.instance
            .collection("metadata")
            .doc("payments")
            .get();

        Map payments_doc_data = payments_doc.data()!;

        String stripe_key = payments_doc_data["stripe"][
            current_build_mode == BuildMode.release ? "secret" : "secret_test"];

        await http
            .post(
          Uri.parse("https://api.stripe.com/v1/checkout/sessions"),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer $stripe_key",
          },
          encoding: Encoding.getByName('utf-8'),
          body: {
            "customer_email": widget.stripe_payment.customer_email,
            "metadata[user_id]": widget.stripe_payment.user_id,
            "metadata[product_id]": widget.stripe_payment.product_id,
            "payment_method_types[0]": "card",
            "mode": "payment",
            "allow_promotion_codes": "true",
            "line_items[0][price]": widget.stripe_payment.price_id,
            "line_items[0][quantity]": "1",
            "success_url": widget.stripe_payment.success_url,
            "cancel_url": widget.stripe_payment.cancel_url,
          },
        )
            .then((response) async {
          Map body = jsonDecode(response.body);
          String url = body["url"];

          if (UniversalPlatform.isWeb) {
            await launch(
              url,
              webOnlyWindowName: "_self",
            );
          } else {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentWebview(
                  url_base: url,
                ),
              ),
            );
            Navigator.of(context).pop();
          }
        });
      }
    }
  }
}
