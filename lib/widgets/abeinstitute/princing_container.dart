import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'pricing_container_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xapptor_logic/is_portrait.dart';

class PricingContainer extends StatefulWidget {
  const PricingContainer({
    required this.texts,
    required this.background_color,
    required this.title_color,
    required this.subtitle_color,
    required this.image_1,
    required this.image_2,
    required this.image_3,
  });

  final List<String> texts;
  final Color background_color;
  final Color title_color;
  final Color subtitle_color;
  final String image_1;
  final String image_2;
  final String image_3;

  @override
  _PricingContainerState createState() => _PricingContainerState();
}

class _PricingContainerState extends State<PricingContainer> {
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);
  String user_id = "";
  String user_email = "";

  List<Map<String, dynamic>> price_id_list = [
    {
      "name": "White Belt",
      //"id": "sku_HIvmKnNdqFdcKs", // TEST
      "id": "sku_HMZSl1wuFpKPRh", // PROD
      "course_id": "njrXMgGFkJklI3ZZONSP",
    },
    {
      "name": "Yellow Belt",
      //"id": "sku_HIvjT9AY7rsBga", // TEST
      "id": "sku_HMZQ1Av6Wbbfbs", // PROD
      "course_id": "njrXMgGFkJklI3ZZONSP",
    },
    {
      "name": "Black Belt",
      //"id": "sku_HIvi1IGIJ2JupX", // TEST
      "id": "sku_HMZQ1Av6Wbbfbs", // PROD
      "course_id": "njrXMgGFkJklI3ZZONSP",
    },
    {
      "name": "Leadership & Development",
      //"id": "sku_HIvi1IGIJ2JupX", // TEST
      "id": "sku_HMZRBPi2Jma91v", // PROD
      "course_id": "njrXMgGFkJklI3ZZONSP",
    },
    {
      "name": "Fundamentos del Plan de Continuidad del Negocio",
      //"id": "sku_HIvnpHLrRPowP0", // TEST
      "id": "sku_HMZRVoUcSccaqE", // PROD
      "course_id": "njrXMgGFkJklI3ZZONSP",
    },
  ];

  set_user_info() async {
    if (FirebaseAuth.instance.currentUser != null) {
      user_id = FirebaseAuth.instance.currentUser!.uid;
      user_email = FirebaseAuth.instance.currentUser!.email!;
      setState(() {});
    }
  }

  TextEditingController text_editing_controller = TextEditingController();

  check_if_coupon_is_valid(String coupon_id) {
    bool coupon_valid = false;
    if (coupon_valid) {
      //
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.texts[6]),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    set_user_info();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    return Container(
      color: widget.background_color,
      height: portrait
          ? (MediaQuery.of(context).size.height * 3)
          : (MediaQuery.of(context).size.height),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Spacer(flex: 1),
          Expanded(
            flex: portrait ? 3 : 1,
            child: FractionallySizedBox(
              widthFactor: 0.7,
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
          Expanded(
            flex: portrait ? 2 : 1,
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
              widthFactor: portrait ? 0.8 : 0.15,
              child: Column(
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
                    controller: text_editing_controller,
                  ),
                  SizedBox(
                    height: sized_box_space,
                  ),
                  Container(
                    height: 50,
                    child: CustomCard(
                      on_pressed: () {
                        check_if_coupon_is_valid(text_editing_controller.text);
                      },
                      border_radius: 1000,
                      splash_color: color_abeinstitute_text.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          widget.texts[5],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color_abeinstitute_text,
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
            flex: portrait ? 42 : 10,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Flex(
                direction: portrait ? Axis.vertical : Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "White Belt",
                      price: "100",
                      buy_text: widget.texts[2],
                      icon: Icons.shutter_speed,
                      text_color: Colors.white,
                      image_url: widget.image_1,
                      gradient_1: Colors.blueGrey.shade200.withOpacity(0.25),
                      gradient_2: Colors.blueGrey.shade700.withOpacity(0.75),
                      coming_soon: true,
                      stripe_payment: StripePayment(
                        price_id: price_id_list[0]["id"],
                        user_id: user_id,
                        customer_email: user_email,
                        course_id: price_id_list[0]["course_id"],
                      ),
                      coming_soon_text: widget.texts[3],
                    ),
                  ),
                  portrait ? Container() : Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "Yellow Belt",
                      price: "249",
                      buy_text: widget.texts[2],
                      icon: Icons.message,
                      text_color: Colors.white,
                      image_url: widget.image_2,
                      gradient_1:
                          Colors.orangeAccent.shade200.withOpacity(0.25),
                      gradient_2:
                          Colors.orangeAccent.shade700.withOpacity(0.75),
                      coming_soon: false,
                      stripe_payment: StripePayment(
                        price_id: price_id_list[1]["id"],
                        user_id: user_id,
                        customer_email: user_email,
                        course_id: price_id_list[1]["course_id"],
                      ),
                      coming_soon_text: widget.texts[3],
                    ),
                  ),
                  portrait ? Container() : Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "Black Belt",
                      price: "300",
                      buy_text: widget.texts[2],
                      icon: Icons.compare,
                      text_color: Colors.white,
                      image_url: widget.image_3,
                      gradient_1: Colors.grey.shade700.withOpacity(0.25),
                      gradient_2: Colors.grey.shade900.withOpacity(0.75),
                      coming_soon: true,
                      stripe_payment: StripePayment(
                        price_id: price_id_list[2]["id"],
                        user_id: user_id,
                        customer_email: user_email,
                        course_id: price_id_list[2]["course_id"],
                      ),
                      coming_soon_text: widget.texts[3],
                    ),
                  ),
                ],
              ),
            ),
          ),
          portrait ? Container() : Spacer(flex: 2),
        ],
      ),
    );
  }
}
