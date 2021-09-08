import 'package:flutter/material.dart';
import 'package:xapptor_ui/screens/payment_webview.dart';
import 'pricing_container_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void initState() {
    super.initState();
    set_user_info();
  }

  set_user_info() async {
    if (FirebaseAuth.instance.currentUser != null) {
      user_id = FirebaseAuth.instance.currentUser!.uid;
      user_email = FirebaseAuth.instance.currentUser!.email!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      color: widget.background_color,
      height: portrait
          ? (MediaQuery.of(context).size.height * 3.2)
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
            flex: portrait ? 42 : 12,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Flex(
                direction: portrait ? Axis.vertical : Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "White Belt",
                      description: widget.texts[3],
                      characteristics: ' ',
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
                    ),
                  ),
                  portrait ? Container() : Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "Yellow Belt",
                      description: widget.texts[5],
                      characteristics: ' ',
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
                    ),
                  ),
                  portrait ? Container() : Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: PricingContainerItem(
                      title: "Black Belt",
                      description: widget.texts[7],
                      characteristics: ' ',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
