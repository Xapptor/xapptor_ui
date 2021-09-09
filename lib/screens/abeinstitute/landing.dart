import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xapptor_auth/check_login.dart';
import 'package:xapptor_logic/check_metadata_app.dart';
import 'package:xapptor_logic/firebase_tasks.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/widgets/abeinstitute/download_apps_container.dart';
import 'package:xapptor_ui/widgets/abeinstitute/princing_container.dart';
import 'package:xapptor_ui/widgets/contact_us_container.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/values/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_ui/widgets/introduction_container.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/widgets/why_us_container.dart';

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

  String current_language = "en";

  late SharedPreferences prefs;

  ScrollController scroll_controller = ScrollController();

  TranslationStream translation_stream_menu = TranslationStream();
  TranslationStream translation_stream_introduction = TranslationStream();
  TranslationStream translation_stream_why_us = TranslationStream();
  TranslationStream translation_stream_download = TranslationStream();
  TranslationStream translation_stream_buy = TranslationStream();
  TranslationStream translation_stream_contact_us = TranslationStream();

  List<String> text_list_menu = [
    "About",
    "Download",
    "Pricing",
    "Contact",
    "Login",
    "Register",
  ];

  List<String> text_list_introduction = [
    "Building the future for professionals",
    "Be able to follow the life you dream of, adding professional experience to your career.",
  ];

  /*List<String> textListCharacteristics = [
    "Framework",
    "We design an ideal structure for your online education.",
    "Dynamic",
    "Learn through videos and interactive reinforcements.",
    "Mobile education",
    "Login no matter where in the world you are.",
    "Expertise",
    "Build your Cross-Functional Expertise with our online tools.",
  ];*/

  List<String> text_list_why_us = [
    "Why us?",
    "Ever-evolving for our students, at an affordable price.",
    "American",
    "Our passion for teaching business leaders how to reach “excellence” began in the great state of Texas through in-person lectures. With the latest advances in technology communications, and with the resources in the sunny state of Florida we’ve now adapted our model and made it our goal to reach an international audience with our uniquely “American” approach to Business excellence.",
    "Business",
    "A “business activity” is commonly defined as that which includes a monetary transaction, however, even the simplest exchange of materials, knowledge, services or time constitutes a business activity. Because so many of these variables often go unrecognized, many businesses miss out on opportunities for improving their processes and ultimately their profits. \n\n Our goal is to educate and supply individuals with the knowledge and tools they’ll need to fully understand the various components of their business activities and how they play into the bigger picture.",
    "Excellence",
    "According to the Lean Six Sigma methodology, a business operating at the level of “excellence” is characterized by having zero defects - in real terms, that’s 3.4 defects per one million opportunities. \n\n Through easy-to-follow applications, we show you how the broader concepts of Lean Six Sigma can be applied to any business, large or small, and in any situation. We put a large focus on the customer, who is the driver of any business, and help you to adapt according to their ever-changing needs and demands.",
  ];

  /*List<String> textListBestProjects = [
    "Our best projects",
    "Experiences that changed the way we work.",
    "Speed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Feedback",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Execution",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Speed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Feedback",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Execution",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  ];*/

  List<String> text_list_download = [
    "Learn anytime, anywhere.",
    "If you have to go on a trip..",
    "or stay at home and watch your favourite course.",
    "Download our app and enjoy all the courses wherever you are.",
  ];

  List<String> text_list_buy = [
    "Our courses",
    "Learn and get certified in any of them.",
    "White Belt",
    "\$100",
    "Yellow Belt",
    "\$249",
    "Black Belt",
    "\$300",
    "Buy Now",
  ];

  List<String> text_list_contact_us = [
    "Contact us",
    "Send us your questions, recommendations and comments.",
    "Name",
    "Email",
    "Subject",
    "Message",
    "Send",
    "Miami, FL, U.S.A.",
    "+1 (954) 995-9592",
    "community-mgmt@abeinstitute.com",
  ];

  List<String> full_text_list = [];

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language_target") == null)
      prefs.setString("language_target", "en");
  }

  auto_scroll() {
    Timer(Duration(seconds: 13), () {
      if (current_page < total_pages - 1) {
        page_controller.nextPage(
          duration: Duration(milliseconds: 900),
          curve: Curves.linear,
        );
      } else {
        page_controller.animateToPage(
          0,
          duration: Duration(milliseconds: 900),
          curve: Curves.linear,
        );
      }

      if (active_auto_scroll) auto_scroll();
    });
  }

  /*checkCheckoutSessionID() async {
    if (widget.checkoutSessionID.length > 26) {
      waitingForPaymentResponse = true;

      setState(() {});

      DocumentSnapshot firestoreUser;

      PaymentRedirectType currentPaymentRedirectType;

      if (widget.checkoutSessionID.length > 28) {
        currentPaymentRedirectType = PaymentRedirectType.successful;

        CollectionReference reference =
            FirebaseFirestore.instance.collection('payments');
        reference.snapshots().listen((querySnapshot) {
          querySnapshot.docChanges.forEach((change) async {
            if (change.type == DocumentChangeType.added) {
              print("change.document.data: " + change.doc.data.toString());

              if (change.doc.data()['checkout_session_id'] ==
                  widget.checkoutSessionID) {
                String userID = change.doc.data()["user_id"];
                firestoreUser = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(userID)
                    .get();

                pushToHome(firestoreUser, currentPaymentRedirectType);
              }
            }
          });
        });
      } else {
        currentPaymentRedirectType = PaymentRedirectType.failed;

        firestoreUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.checkoutSessionID)
            .get();

        pushToHome(firestoreUser, currentPaymentRedirectType);
      }
    }
  }*/

  animate_scroll_position({required int index, required bool pop}) {
    double current_scroll_position = 0;
    current_scroll_position = MediaQuery.of(context).size.height;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      switch (index) {
        case 0:
          {
            //
          }
          break;

        case 1:
          {
            current_scroll_position *= 4.2;
          }
          break;

        case 2:
          {
            current_scroll_position *= 6.2;
          }
          break;

        case 3:
          {
            current_scroll_position *= 9.4;
          }
          break;
      }
    } else {
      switch (index) {
        case 0:
          {
            //
          }
          break;

        case 1:
          {
            current_scroll_position *= 2;
          }
          break;

        case 2:
          {
            current_scroll_position *= 3;
          }
          break;

        case 3:
          {
            current_scroll_position *= 4;
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

  update_text_list_why_us(int index, String new_text) {
    text_list_why_us[index] = new_text;
    setState(() {});
  }

  update_text_list_download(int index, String new_text) {
    text_list_download[index] = new_text;
    setState(() {});
  }

  update_text_list_buy(int index, String new_text) {
    text_list_buy[index] = new_text;
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

  delete_corrupted_certificates() async {
    int certificates_counter = 0;
    int certificates_corrupted_counter = 0;

    await FirebaseFirestore.instance
        .collection("certificates")
        .get()
        .then((collection) {
      collection.docs.forEach((certificate) async {
        certificates_counter++;

        var certificate_data = certificate.data();
        DocumentSnapshot user = await FirebaseFirestore.instance
            .collection("users")
            .doc(certificate_data["user_id"])
            .get();
        if (!user.exists) {
          certificates_corrupted_counter++;
          print(
              "id: ${certificate.id} user_id: ${certificate_data["user_id"]}");
          certificate.reference.delete();
        }
      });

      Timer(Duration(milliseconds: 800), () {
        print("certificates_counter $certificates_counter");
        print("certificates_corrupted_counter $certificates_corrupted_counter");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    check_metadata_app();
    check_login();

    translation_stream_menu.init(text_list_menu, update_text_list_menu);
    translation_stream_menu.translate();

    translation_stream_introduction.init(
        text_list_introduction, update_text_list_introduction);
    translation_stream_introduction.translate();

    translation_stream_why_us.init(text_list_why_us, update_text_list_why_us);
    translation_stream_why_us.translate();

    translation_stream_download.init(
        text_list_download, update_text_list_download);
    translation_stream_download.translate();

    translation_stream_buy.init(text_list_buy, update_text_list_buy);
    translation_stream_buy.translate();

    translation_stream_contact_us.init(
        text_list_contact_us, update_text_list_contact_us);
    translation_stream_contact_us.translate();

    init_prefs();
    //checkCheckoutSessionID();
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
              animate_scroll_position(index: 0, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[1]),
            onTap: () {
              animate_scroll_position(index: 1, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[2]),
            onTap: () {
              animate_scroll_position(index: 2, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[3]),
            onTap: () {
              animate_scroll_position(index: 3, pop: true);
            },
          ),
          ListTile(
            title: Text(text_list_menu[4]),
            onTap: () {
              open_screen("login");
            },
          ),
          ListTile(
            title: Text(text_list_menu[5]),
            onTap: () {
              open_screen("register");
            },
          ),
        ],
      ),
    );
  }

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;

    translation_stream_menu.translate();
    translation_stream_introduction.translate();
    translation_stream_why_us.translate();
    translation_stream_download.translate();
    translation_stream_buy.translate();
    translation_stream_contact_us.translate();
    setState(() {});
  }

  List<Widget> widgets_action(bool portrait) {
    return [
      Container(
        width: portrait ? 100 : 150,
        child: LanguagePicker(
          current_language: current_language,
          language_picker_callback: language_picker_callback,
          language_picker_items_text_color: color_abeinstitute_ocean_blue,
        ),
      ),
      portrait
          ? Container()
          : Row(
              children: [
                TextButton(
                  onPressed: () {
                    animate_scroll_position(index: 0, pop: false);
                  },
                  child: custom_text(text_list_menu[0]),
                ),
                TextButton(
                  onPressed: () {
                    animate_scroll_position(index: 1, pop: false);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[1]),
                ),
                TextButton(
                  onPressed: () {
                    animate_scroll_position(index: 2, pop: false);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[2]),
                ),
                TextButton(
                  onPressed: () {
                    animate_scroll_position(index: 3, pop: false);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[3]),
                ),
                TextButton(
                  onPressed: () {
                    open_screen("login");
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: custom_text(text_list_menu[4]),
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
      appBar: TopBar(
        background_color: color_abeinstitute_topbar,
        has_back_button: false,
        actions: widgets_action(portrait),
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: Container(
        color: Colors.white,
        child: LayoutBuilder(
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
                        background_image:
                            "assets/images/introduction_container.jpg",
                        logo_image: "assets/images/logo.png",
                        scroll_icon: Icons.keyboard_arrow_down,
                        scroll_icon_color: Colors.orangeAccent,
                        height: MediaQuery.of(context).size.height,
                      ),
                      WhyUsContainer(
                        texts: text_list_why_us,
                        background_color: Colors.white,
                        characteristic_icon_1: Icons.shutter_speed,
                        characteristic_icon_2: Icons.message,
                        characteristic_icon_3: Icons.compare,
                        characteristic_icon_color_1: Colors.orangeAccent,
                        characteristic_icon_color_2: Colors.lightBlueAccent,
                        characteristic_icon_color_3: Colors.redAccent,
                        title_color: Colors.black,
                        subtitle_color: Colors.grey,
                        background_image: '',
                      ),
                      DownloadAppsContainer(
                        texts: text_list_download,
                        title_color: Colors.black,
                        subtitle_color: Colors.grey,
                        image_1: 'assets/images/traveler_2.jpg',
                        image_2: 'assets/images/traveler_1.jpg',
                        android_url:
                            "https://firebasestorage.googleapis.com/v0/b/abei-21f7c.appspot.com/o/apps%2Fabeinstitute.apk?alt=media&token=a83fe9a6-8b09-4dea-b280-6217ce1ffbcb",
                        ios_url:
                            "itms-services://?action=download-manifest&url=https://www.abeinstitute.com/manifest.plist",
                        background_image: "",
                        button_background_color: [
                          color_abeinstitute_background_grey,
                          color_abeinstitute_ocean_blue,
                        ],
                      ),
                      PricingContainer(
                        texts: text_list_buy,
                        background_color: Colors.blue.shade800,
                        title_color: Colors.white,
                        subtitle_color: Colors.white,
                        image_1: 'assets/images/student_1.jpg',
                        image_2: 'assets/images/student_2.jpg',
                        image_3: 'assets/images/family.jpg',
                      ),
                      ContactUsContainer(
                        texts: text_list_contact_us,
                        landing_class: this,
                        icon_color: color_abeinstitute_ocean_blue,
                        container_background_image:
                            "assets/images/background_building.jpg",
                        facebook_url: url_facebook_abeinstitute,
                        facebook_url_fallback:
                            url_facebook_fallback_abeinstitute,
                        youtube_url: url_youtube_abeinstitute,
                        instagram_url: url_instagram_abeinstitute,
                        twitter_url: url_twitter_abeinstitute,
                        email: "community-mgmt@abeinstitute.com",
                        feedback_message: "✉️ Message sent! 👍",
                        card_background_image: "",
                        container_background_color: Colors.white,
                        card_background_color: Colors.white,
                        linear_gradient_colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
