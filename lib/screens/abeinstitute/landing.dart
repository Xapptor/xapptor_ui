import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xapptor_logic/check_metadata_app.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/widgets/abeinstitute/download_apps_container.dart';
import 'package:xapptor_ui/widgets/abeinstitute/princing_container.dart';
import 'package:xapptor_ui/widgets/contact_us_container.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/values/urls.dart';
import 'package:xapptor_ui/widgets/introduction_container.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/widgets/why_us_container.dart';
import 'package:xapptor_logic/is_portrait.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  ScrollController scroll_controller = ScrollController();

  List<String> text_list_menu = [
    "About Us",
    "Download",
    "Pricing",
    "Contact",
    "Login",
    "Register",
  ];

  List<String> text_list_introduction = [
    "Building the future for professionals",
    "Follow the life you dream of, add professional experience to your career",
  ];

  List<String> text_list_why_us = [
    "Why us?",
    "Ever-evolving for our students and at an affordable price",
    "American",
    "Our passion for teaching business leaders how to reach “excellence” began in the great state of Texas through in-person lectures. With the latest advances in technology communications, and with the resources in the sunny state of Florida we’ve now adapted our model and made it our goal to reach an international audience with our uniquely “American” approach to Business excellence.",
    "Business",
    "A “business activity” is commonly defined as that which includes a monetary transaction, however, even the simplest exchange of materials, knowledge, services or time constitutes a business activity. Because so many of these variables often go unrecognized, many businesses miss out on opportunities for improving their processes and ultimately their profits. \n\n Our goal is to educate and supply individuals with the knowledge and tools they’ll need to fully understand the various components of their business activities and how they play into the bigger picture.",
    "Excellence",
    "According to the Lean Six Sigma methodology, a business operating at the level of “excellence” is characterized by having zero defects - in real terms, that’s 3.4 defects per one million opportunities. \n\n Through easy-to-follow applications, we show you how the broader concepts of Lean Six Sigma can be applied to any business, large or small, and in any situation. We put a large focus on the customer, who is the driver of any business, and help you to adapt according to their ever-changing needs and demands.",
  ];

  List<String> text_list_download = [
    "Learn anytime, anywhere.",
    "If you have to travel",
    "or if you have to stay at home",
    "Download our app and enjoy all the courses wherever you are.",
  ];

  List<String> text_list_buy = [
    "Our courses",
    "Learn and get certified.",
    "Buy now",
    "Upcoming",
    "Coupon ID",
    "Enter",
    "Coupon applied",
    "Coupon is not valid",
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

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    if (list_index == 0) {
      text_list_menu[index] = new_text;
    } else if (list_index == 1) {
      text_list_introduction[index] = new_text;
    } else if (list_index == 2) {
      text_list_why_us[index] = new_text;
    } else if (list_index == 3) {
      text_list_download[index] = new_text;
    } else if (list_index == 4) {
      text_list_buy[index] = new_text;
    } else if (list_index == 5) {
      text_list_contact_us[index] = new_text;
    }
    setState(() {});
  }

  late TranslationStream translation_stream_menu;
  late TranslationStream translation_stream_introduction;
  late TranslationStream translation_stream_why_us;
  late TranslationStream translation_stream_download;
  late TranslationStream translation_stream_buy;
  late TranslationStream translation_stream_contact_us;
  List<TranslationStream> translation_stream_list = [];

  animate_scroll_position({required int index, required bool pop}) {
    double current_scroll_position = 0;
    current_scroll_position = MediaQuery.of(context).size.height;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      if (index == 1) {
        current_scroll_position *= 5;
      } else if (index == 2) {
        current_scroll_position *= 7;
      } else if (index == 3) {
        current_scroll_position *= 10;
      }
    } else {
      current_scroll_position *= (index + 1);
    }

    if (pop) Navigator.pop(context);

    scroll_controller.animateTo(
      current_scroll_position,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void dispose() {
    scroll_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    check_metadata_app();

    translation_stream_menu = TranslationStream(
      text_list: text_list_menu,
      update_text_list_function: update_text_list,
      list_index: 0,
      active_translation: true,
    );

    translation_stream_introduction = TranslationStream(
      text_list: text_list_introduction,
      update_text_list_function: update_text_list,
      list_index: 1,
      active_translation: true,
    );

    translation_stream_why_us = TranslationStream(
      text_list: text_list_why_us,
      update_text_list_function: update_text_list,
      list_index: 2,
      active_translation: true,
    );

    translation_stream_download = TranslationStream(
      text_list: text_list_download,
      update_text_list_function: update_text_list,
      list_index: 3,
      active_translation: true,
    );

    translation_stream_buy = TranslationStream(
      text_list: text_list_buy,
      update_text_list_function: update_text_list,
      list_index: 4,
      active_translation: true,
    );

    translation_stream_contact_us = TranslationStream(
      text_list: text_list_contact_us,
      update_text_list_function: update_text_list,
      list_index: 5,
      active_translation: true,
    );

    translation_stream_list = [
      translation_stream_menu,
      translation_stream_introduction,
      translation_stream_why_us,
      translation_stream_download,
      translation_stream_buy,
      translation_stream_contact_us,
    ];
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

  List<Widget> widgets_action(bool portrait) {
    return [
      Container(
        width: 150,
        child: LanguagePicker(
          translation_stream_list: translation_stream_list,
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
    bool portrait = is_portrait(context);

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
        child: SingleChildScrollView(
          controller: scroll_controller,
          child: Column(
            children: [
              IntroductionContainer(
                texts: text_list_introduction,
                text_color: Colors.white,
                background_image: "assets/images/introduction_container.jpg",
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
                    "https://firebasestorage.googleapis.com/v0/b/abei-21f7c.appspot.com/o/apps%2Fabeinstitute.apk?alt=media&token=91d2c4f4-6c69-49c3-95e4-2b888796c2e1",
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
                facebook_url_fallback: url_facebook_fallback_abeinstitute,
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
                border_radius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
