import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xapptor_auth/generic_user.dart';
import 'package:xapptor_auth/user_info_form_type.dart';
import 'package:xapptor_auth/user_info_view.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/screens/lum/admin_analytics.dart';
import 'package:xapptor_ui/screens/qr_scanner.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/home_container_bottom_bar.dart';
import 'package:xapptor_ui/widgets/lum/products_list.dart';
import 'package:xapptor_ui/widgets/lum/vending_machines_list_container.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({
    required this.user,
  });

  final GenericUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  //bool qr_scanned = false;
  //String qr_value = "";
  bool qr_scanned = true;
  String qr_value = "B2YfHwHebSLoM8uwpNxs";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    add_screens();
  }

  update_qr_value(String new_qr_value) {
    qr_scanned = true;
    qr_value = new_qr_value;
    setState(() {});
  }

  List<Widget> get_pages() {
    List<Widget> pages = [
      VendingMachinesListContainer(),
      AdminAnalytics(),
    ];
    return pages;
  }

  List<String> text_list = [
    "Cuenta",
    "Configuración",
    "Cerrar sesión",
  ];

  add_screens() {
    add_new_app_screen(
      AppScreen(
        name: "home/account",
        child: UserInfoView(
          uid: widget.user.uid,
          text_list: [
            "Email",
            "Confirmar email",
            "Contraseña",
            "Confirmar contraseña",
            "Nombres",
            "Apellidos",
            "Ingresa la fecha de tu nacimiento",
            "Guardar",
          ],
          gender_values: [
            'Hombre',
            'Mujer',
            'No-binario',
            'Prefiero no decir',
          ],
          country_values: null,
          text_color: color_lum_text,
          first_button_color: color_lum_main_button,
          second_button_color: color_lum_light_pink,
          third_button_color: color_lum_green,
          logo_image_path: logo_image_path_lum,
          has_language_picker: has_language_picker_lum,
          topbar_color: color_lum_topbar,
          custom_background: null,
          user_info_form_type: UserInfoFormType.edit_account,
          outline_border: false,
          first_button_action: null,
          second_button_action: null,
          third_button_action: null,
          secret_answer_values: [],
          secret_question_values: [],
          logo_height: logo_height_lum,
          logo_width: logo_width_lum,
          has_back_button: true,
          text_field_background_color: Colors.grey,
          edit_icon_use_text_field_background_color: true,
        ),
      ),
    );
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      portrait
          ? Container()
          : Row(
              children: [
                Tooltip(
                  message: text_list[0],
                  child: TextButton(
                    onPressed: () {
                      open_screen("home/account");
                    },
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tooltip(
                  message: text_list[1],
                  child: TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
      IconButton(
        icon: new Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          scaffold_key.currentState!.openEndDrawer();
        },
      ),
    ];
  }

  Widget drawer() {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: new Icon(
                  Icons.close,
                  color: color_abeinstitute_dark_aqua,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text(text_list[0]),
              onTap: () {
                open_screen("home/account");
              },
            ),
            ListTile(
              title: Text(text_list[1]),
              onTap: () {},
            ),
            ListTile(
              title: Text(text_list[2]),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var scan_area = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    double app_bar_height = 65;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffold_key,
        endDrawer: drawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(app_bar_height),
          child: Topbar(
            background_color: color_lum_grey,
            size: app_bar_height * 0.9,
            has_back_button: false,
            actions: widgets_action(portrait),
            custom_leading: null,
            logo_path: "assets/images/logo.png",
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(0.0),
          child: widget.user.admin
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
              : qr_scanned
                  ? ProductsList(
                      vending_machine_id: qr_value,
                      allow_edit_enabled: false,
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
      ),
    );
  }
}
