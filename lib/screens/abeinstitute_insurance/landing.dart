import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xapptor_logic/check_metadata_app.dart';
import 'package:xapptor_logic/url_launcher.dart';
import 'package:xapptor_ui/widgets/abeinstitute_insurance/insurance_catalog.dart';
import 'package:xapptor_ui/widgets/contact_us_container_lead_form.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_ui/widgets/expandable_fab.dart';
import 'package:xapptor_ui/widgets/introduction_container.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/values/urls.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();

  int current_offset = 0;
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);
  int total_pages = 7;
  bool active_auto_scroll = false;

  late SharedPreferences prefs;

  ScrollController scroll_controller = ScrollController();

  List<String> text_list_menu = [
    "Inicio",
    "Seguros",
    "Contacto",
  ];

  List<String> text_list_introduction = [
    "Vive sin preocupaciones, tu familia y tu hogar están protegidos.",
  ];

  List<String> text_list_benefits = [
    "Protección a la medida",
    "Respaldo los 365 días del año",
    "Compromiso y calidad en el servicio",
  ];

  List<String> text_list_insurance_catalog = [
    "Descubre el seguro a tu medida",
    "Seguro de Vida",
    "Protege el futuro económico de los que más quieres",
    "Puedes elegir la cantidad que deseas para tu familia",
    "Tú decides a quienes quieres proteger",
    "Protección de Hipoteca",
    "Para contingencias de desempleo e incapacidad laboral temporaria (ILT)",
    "Protección contra daños a terceros causados por ti o algún familiar",
    "Puedes actualizar el valor de tu hogar en cualquier momento",
    "Gastos Finales",
    "Planes Funerarios totalmente vitalicios",
    "Adaptado a tus necesidades",
    "Cobertura en todas las ciudades donde tenemos presencia",
  ];

  List<String> text_list_contact_us = [
    "Contacto",
    "Mandanos tus preguntas, recomendaciones y comentarios..",
    "Nombre",
    "Correo",
    "Asunto",
    "Mensaje",
    "Enviar",
    "Miami, FL, U.S.A.",
    "+1 (954) 995-9592",
    "community-mgmt@abeinstitute.com",
  ];

  List<String> full_text_list = [];

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language_target") == null) {
      prefs.setString("language_target", "en");
    }
  }

  auto_scroll() {
    Timer(Duration(seconds: 13), () {
      if (current_page < total_pages - 1) {
        page_controller.nextPage(
            duration: Duration(milliseconds: 900), curve: Curves.linear);
      } else {
        page_controller.animateToPage(0,
            duration: Duration(milliseconds: 900), curve: Curves.linear);
      }

      if (active_auto_scroll) {
        auto_scroll();
      }
    });
  }

  animate_to_scroll_position({required int index, required bool pop}) {
    double current_scroll_position = 0;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      switch (index) {
        case 0:
          {
            current_scroll_position = 0;
          }
          break;

        case 1:
          {
            current_scroll_position = MediaQuery.of(context).size.height / 2.2;
          }
          break;

        case 2:
          {
            current_scroll_position = MediaQuery.of(context).size.height * 3.5 +
                (MediaQuery.of(context).size.height / 2.2);
          }
          break;
      }
    } else {
      switch (index) {
        case 0:
          {
            current_scroll_position = 0;
          }
          break;

        case 1:
          {
            current_scroll_position = MediaQuery.of(context).size.height / 2.2;
          }
          break;

        case 2:
          {
            current_scroll_position = MediaQuery.of(context).size.height +
                (MediaQuery.of(context).size.height / 2.2);
          }
          break;
      }
    }

    if (pop) Navigator.pop(context);

    scroll_controller.animateTo(
      current_scroll_position,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  update_text_list_menu(int index, String new_text) {
    text_list_menu[index] = new_text;
    setState(() {});
  }

  update_text_list_introduction(int index, String new_text) {
    text_list_introduction[index] = new_text;
    setState(() {});
  }

  update_text_list_benefits(int index, String new_text) {
    text_list_benefits[index] = new_text;
    setState(() {});
  }

  update_text_list_insurance_catalog(int index, String new_text) {
    text_list_insurance_catalog[index] = new_text;
    setState(() {});
  }

  update_text_list_contact_us(int index, String new_text) {
    text_list_contact_us[index] = new_text;
    setState(() {});
  }

  void dispose() {
    scroll_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    check_metadata_app();
  }

  Widget drawer() {
    return Drawer(
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
            title: Text(text_list_menu[0]),
            onTap: () {
              animate_to_scroll_position(index: 0, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[1]),
            onTap: () {
              animate_to_scroll_position(index: 1, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[2]),
            onTap: () {
              animate_to_scroll_position(index: 2, pop: true);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      portrait
          ? Container()
          : Row(
              children: [
                TextButton(
                  onPressed: () {
                    animate_to_scroll_position(index: 0, pop: false);
                  },
                  child: custom_text(text_list_menu[0]),
                ),
                TextButton(
                  onPressed: () {
                    animate_to_scroll_position(index: 1, pop: false);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[1]),
                ),
                TextButton(
                  onPressed: () {
                    animate_to_scroll_position(index: 2, pop: false);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[2]),
                ),
              ],
            ),
      IconButton(
        icon: new Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          scaffold_key.currentState!.openEndDrawer();
        },
      ),
    ];
  }

  Widget custom_text(String data) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: scaffold_key,
      endDrawer: drawer(),
      extendBodyBehindAppBar: true,
      appBar: TopBar(
        background_color: color_abeinstitute_dark_aqua.withOpacity(0.5),
        has_back_button: false,
        actions: widgets_action(portrait),
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewport_constraints) {
          return SingleChildScrollView(
            controller: scroll_controller,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewport_constraints.minHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    IntroductionContainer(
                      texts: text_list_introduction,
                      text_color: Colors.white,
                      background_image: "assets/images/latin_family.jpg",
                      logo_image: "assets/images/logo.png",
                      scroll_icon: Icons.keyboard_arrow_down,
                      scroll_icon_color: Colors.orangeAccent,
                      height: MediaQuery.of(context).size.height / 2.2,
                    ),
                    InsuranceCatalog(
                      texts: text_list_insurance_catalog,
                      icon_color: color_abeinstitute_ocean_blue,
                      container_background_color: Colors.white,
                      container_background_image: "",
                      card_background_color: Colors.white,
                      linear_gradient_colors: [
                        Colors.black.withOpacity(0.005),
                        Colors.black.withOpacity(0.005),
                      ],
                      insurance_image_path_1:
                          "assets/images/life_insurance.jpg",
                      insurance_image_path_2:
                          "assets/images/mortgage_insurance.jpg",
                      insurance_image_path_3:
                          "assets/images/final_expenses.jpg",
                      more_information_function: () {
                        animate_to_scroll_position(index: 2, pop: false);
                      },
                    ),
                    ContactUsContainerLeadForm(
                      landing_class: this,
                      icon_color: color_abeinstitute_ocean_blue,
                      container_background_image:
                          "assets/images/beach_family.jpg",
                      facebook_url: url_facebook_abeinstitute_insurance,
                      facebook_url_fallback:
                          url_facebook_fallback_abeinstitute_insurance,
                      youtube_url: url_youtube_abeinstitute_insurance,
                      instagram_url: url_instagram_abeinstitute_insurance,
                      twitter_url: url_twitter_abeinstitute_insurance,
                      email: "community-mgmt@abeinstitute.com",
                      feedback_message: "Message sent! 👍",
                      card_background_image: "",
                      container_background_color: Colors.white,
                      card_background_color: Colors.white.withOpacity(0.6),
                      linear_gradient_colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            on_pressed: () {
              launch_url(
                url_twitter_abeinstitute_insurance,
                url_twitter_abeinstitute_insurance,
              );
            },
            icon: Icon(
              FontAwesome.twitter,
              color: Colors.white,
              size: 16,
            ),
          ),
          ActionButton(
            on_pressed: () {
              launch_url(
                url_youtube_abeinstitute_insurance,
                url_youtube_abeinstitute_insurance,
              );
            },
            icon: Icon(
              FontAwesome.youtube,
              color: Colors.white,
              size: 16,
            ),
          ),
          ActionButton(
            on_pressed: () {
              launch_url(
                url_instagram_abeinstitute_insurance,
                url_instagram_abeinstitute_insurance,
              );
            },
            icon: Icon(
              FontAwesome.instagram,
              color: Colors.white,
              size: 16,
            ),
          ),
          ActionButton(
            on_pressed: () {
              launch_url(
                url_facebook_abeinstitute_insurance,
                url_facebook_fallback_abeinstitute_insurance,
              );
            },
            icon: Icon(
              FontAwesome.facebook,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
