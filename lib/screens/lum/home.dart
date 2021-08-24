import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:xapptor_auth/xapptor_user.dart';
import 'package:xapptor_auth/user_info_form_type.dart';
import 'package:xapptor_auth/user_info_view.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/screens/lum/admin_analytics.dart';
import 'package:xapptor_ui/screens/qr_scanner.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/bottom_bar_container.dart';
import 'package:xapptor_ui/screens/lum/product_list.dart';
import 'package:xapptor_ui/widgets/lum/vending_machines_list.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../privacy_policy.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({
    required this.user,
  });

  final XapptorUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  bool qr_scanned = false;
  String qr_value = "";

  @override
  void initState() {
    super.initState();
    add_screens();
  }

  update_qr_value(String new_qr_value) async {
    DocumentSnapshot vending_machine_snapshot = await FirebaseFirestore.instance
        .collection("vending_machines")
        .doc(new_qr_value)
        .get();

    bool exist_vending_machine = vending_machine_snapshot.data() != null;

    if (exist_vending_machine) {
      qr_scanned = true;
      qr_value = new_qr_value;
      setState(() {});
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("Debes ingresar un código válido"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  List<String> text_list = [
    "Cuenta",
    "Productos",
    "Políticas de Privacidad",
    "Cerrar sesión",
  ];

  add_screens() async {
    add_new_app_screen(
      AppScreen(
        name: "home/account",
        child: UserInfoView(
          uid: widget.user.id,
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
          has_back_button: true,
          text_field_background_color: Colors.grey,
          edit_icon_use_text_field_background_color: true,
        ),
      ),
    );

    add_new_app_screen(
      AppScreen(
        name: "home/products",
        child: ProductList(
          vending_machine_id: null,
          allow_edit: true,
          has_topbar: true,
          for_dispensers: false,
        ),
      ),
    );

    add_new_app_screen(
      AppScreen(
        name: "home/privacy_policy",
        child: PrivacyPolicy(
          src: UniversalPlatform.isWeb
              ? await rootBundle.loadString("assets/privacy_policy.html")
              : "https://app.franquiciaslum.com/#/privacy_policy",
          use_topbar: true,
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
                widget.user.owner
                    ? Tooltip(
                        message: text_list[1],
                        child: TextButton(
                          onPressed: () {
                            open_screen("home/products");
                          },
                          child: Icon(
                            Typicons.box,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
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
            widget.user.owner
                ? ListTile(
                    title: Text(text_list[1]),
                    onTap: () {
                      open_screen("home/products");
                    },
                  )
                : Container(),
            ListTile(
              title: Text(text_list[2]),
              onTap: () {
                open_screen("home/privacy_policy");
              },
            ),
            ListTile(
              title: Text(text_list[3]),
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffold_key,
        endDrawer: drawer(),
        appBar: TopBar(
          background_color: color_lum_topbar,
          has_back_button: false,
          actions: widgets_action(portrait),
          custom_leading: null,
          logo_path: "assets/images/logo.png",
          logo_color: Colors.white,
        ),
        body: widget.user.admin
            ? BottomBarContainer(
                initial_page: 0,
                bottom_bar_buttons: [
                  BottomBarButton(
                    icon: Icons.microwave_outlined,
                    text: "Máquinas",
                    foreground_color: Colors.white,
                    background_color: color_lum_green,
                    page: VendingMachinesList(),
                  ),
                  BottomBarButton(
                    icon: Icons.insights,
                    text: "Analíticas",
                    foreground_color: Colors.white,
                    background_color: color_lum_blue,
                    page: AdminAnalytics(),
                  ),
                ],
              )
            : qr_scanned
                ? ProductList(
                    vending_machine_id: qr_value,
                    allow_edit: false,
                    has_topbar: false,
                    for_dispensers: true,
                  )
                : QRScanner(
                    descriptive_text: "Escanea el código QR\nde la Máquina",
                    update_qr_value: update_qr_value,
                    border_color: color_lum_light_pink,
                    border_radius: 4,
                    border_length: 40,
                    border_width: 8,
                    cut_out_size: MediaQuery.of(context).size.width * 0.65,
                    button_linear_gradient: LinearGradient(
                      colors: [
                        color_lum_blue.withOpacity(0.4),
                        color_lum_green.withOpacity(0.4),
                      ],
                    ),
                  ),
      ),
    );
  }
}
