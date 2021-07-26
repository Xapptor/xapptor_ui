import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xapptor_auth/generic_user.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/screens/lum/admin_analytics.dart';
import 'package:xapptor_ui/screens/qr_scanner.dart';
import 'package:xapptor_ui/widgets/home_container_bottom_bar.dart';
import 'package:xapptor_ui/widgets/lum/products_list.dart';
import 'package:xapptor_ui/widgets/lum/vending_machines_list_container.dart';

class Home extends StatefulWidget {
  const Home({
    required this.user,
  });

  final GenericUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool qr_scanned = false;
  // String qr_value = "";

  bool qr_scanned = true;
  String qr_value = "B2YfHwHebSLoM8uwpNxs";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  update_qr_value(String new_qr_value) {
    qr_scanned = true;
    qr_value = new_qr_value;
    setState(() {});
  }

  List<Widget> get_pages() {
    List<Widget> pages = [];
    if (widget.user.admin) {
      pages.add(
        VendingMachinesListContainer(),
      );
      pages.add(
        AdminAnalytics(),
      );
    } else {
      pages.add(
        ProductsList(
          vending_machine_id: qr_value,
        ),
      );
      pages.add(
        Container(
          child: Center(
            child: Text(
              "Welcome to Home user ${widget.user.firstname} / Screen 2",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      );
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    var scan_area = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(0.0),
        child: widget.user.admin || qr_scanned
            ? HomeContainerWithPagesAndBottomBar(
                bottom_bar_color: color_lum_dark_pink,
                icon_color: Colors.white,
                pages: get_pages(),
                icons: widget.user.admin
                    ? [
                        Icons.microwave,
                        Icons.insights,
                      ]
                    : [
                        FontAwesome.product_hunt,
                        FontAwesome.adn,
                      ],
                texts: [
                  "Máquinas",
                  "Analíticas",
                ],
              )
            : QRScanner(
                descriptive_text: "Escanea el código QR\nde la Máquina",
                update_qr_value: update_qr_value,
                border_color: color_lum_light_pink,
                border_radius: 4,
                border_length: 40,
                border_width: 8,
                cut_out_size: scan_area,
              ),
      ),
    );
  }
}
