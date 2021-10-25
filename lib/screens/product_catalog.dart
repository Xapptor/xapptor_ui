import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xapptor_logic/firebase_tasks.dart';
import 'package:xapptor_translation/language_picker.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/models/product.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xapptor_logic/is_portrait.dart';
import 'package:xapptor_ui/widgets/product_catalog_item.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({
    this.topbar_color,
    this.language_picker_items_text_color,
    required this.products,
    required this.linear_gradients,
    required this.texts,
    required this.background_color,
    required this.title_color,
    required this.subtitle_color,
    required this.text_color,
    required this.button_color,
    required this.success_url,
    required this.cancel_url,
  });

  final Color? topbar_color;
  final Color? language_picker_items_text_color;
  final List<Product> products;
  final List<LinearGradient> linear_gradients;
  final List<String> texts;
  final Color background_color;
  final Color title_color;
  final Color subtitle_color;
  final Color text_color;
  final Color button_color;
  final String success_url;
  final String cancel_url;

  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  TextEditingController coupon_controller = TextEditingController();

  late TranslationStream translation_stream;
  List<TranslationStream> translation_stream_list = [];

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    widget.texts[index] = new_text;
    setState(() {});
  }

  String user_id = "";
  String user_email = "";

  @override
  void initState() {
    // Checking if user is logged.

    if (FirebaseAuth.instance.currentUser != null) {
      User current_user = FirebaseAuth.instance.currentUser!;
      user_id = current_user.uid;
      user_email = current_user.email!;
    }

    if (widget.topbar_color != null &&
        widget.language_picker_items_text_color != null) {
      translation_stream = TranslationStream(
        text_list: widget.texts,
        update_text_list_function: update_text_list,
        list_index: 0,
        active_translation: true,
      );
      translation_stream_list = [translation_stream];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    Widget body = Container(
      color: widget.background_color,
      height: screen_height,
      width: screen_width,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Center(
                child: Text(
                  widget.texts[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.title_color,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                widget.texts[1],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.subtitle_color,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FractionallySizedBox(
              widthFactor: portrait ? 0.8 : 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: widget.texts[4],
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    controller: coupon_controller,
                  ),
                  SizedBox(
                    height: sized_box_space,
                  ),
                  Container(
                    height: 50,
                    child: CustomCard(
                      on_pressed: () async {
                        // Checking if coupon is valid.

                        String coupon_id = coupon_controller.text;
                        coupon_controller.clear();

                        await check_if_coupon_is_valid(
                          coupon_id.isEmpty ? " " : coupon_id,
                          context,
                          widget.texts[6],
                          widget.texts[7],
                        );
                      },
                      border_radius: 1000,
                      splash_color: widget.text_color.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          widget.texts[5],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.background_color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: portrait ? 8 : 14,
            child: ListView.builder(
              itemCount: widget.products.length,
              shrinkWrap: true,
              scrollDirection: portrait ? Axis.horizontal : Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: double.maxFinite,
                  width:
                      portrait ? (screen_width * 0.85) : (screen_width / 3.75),
                  child: ProductCatalogItem(
                    title: widget.products[index].name,
                    price: widget.products[index].price.toString(),
                    buy_text: widget.texts[2],
                    icon: Icons.shutter_speed,
                    text_color: widget.text_color,
                    image_url: widget.products[index].image_src,
                    linear_gradient: widget.linear_gradients[index],
                    coming_soon: !widget.products[index].enabled,
                    stripe_payment: StripePayment(
                      price_id: widget.products[index].stripe_id,
                      user_id: user_id,
                      product_id: widget.products[index].id,
                      customer_email: user_email,
                      success_url: widget.success_url,
                      cancel_url: widget.cancel_url,
                    ),
                    coming_soon_text: widget.texts[3],
                    button_color: widget.button_color,
                  ),
                );
              },
            ),
          ),
          portrait ? Container() : Spacer(flex: 2),
        ],
      ),
    );

    return widget.topbar_color != null
        ? Scaffold(
            appBar: TopBar(
              background_color: widget.topbar_color!,
              has_back_button: true,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 150,
                  child: widget.language_picker_items_text_color != null
                      ? LanguagePicker(
                          translation_stream_list: translation_stream_list,
                          language_picker_items_text_color:
                              widget.language_picker_items_text_color!,
                        )
                      : Container(),
                ),
              ],
              custom_leading: null,
              logo_path: "assets/images/logo.png",
            ),
            body: body,
          )
        : body;
  }
}
