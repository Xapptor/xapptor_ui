import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xapptor_auth/user_info_view.dart';
import 'package:xapptor_logic/check_current_app_path.dart';
import 'package:xapptor_logic/url_launcher.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_auth/xapptor_user.dart';
import 'package:xapptor_auth/user_info_form_type.dart';
import 'package:xapptor_ui/screens/privacy_policy.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/card_holder.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/values/urls.dart';
import 'package:xapptor_ui/screens/abeinstitute/buy_courses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/widgets_carousel.dart';
import 'package:xapptor_logic/is_portrait.dart';

class Home extends StatefulWidget {
  Home({
    this.user,
  });

  XapptorUser? user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  bool auto_scroll = true;

  late TranslationStream translation_stream_menu;
  late TranslationStream translation_stream_cards_1;
  late TranslationStream translation_stream_cards_2;
  List<TranslationStream> translation_stream_list = [];

  List<String> text_list_menu = [
    "Account",
    "My courses",
    "Buy courses",
    "Certificates and Rewards",
    "Privacy Policy",
    "Logout",
  ];

  List<String> text_list_cards_1 = [
    "Account",
    "Edit your Info",
    "Courses",
    "Complete the Units",
    "New Courses",
    "Extend your Knowledge",
    "Certificates",
    "and Rewards",
  ];

  List<String> text_list_cards_2 = [
    "Official Page",
    "Official Account",
    "Official Channel",
  ];

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    if (list_index == 0) {
      text_list_menu[index] = new_text;
    } else if (list_index == 1) {
      text_list_cards_1[index] = new_text;
    } else if (list_index == 2) {
      text_list_cards_2[index] = new_text;
    }
    setState(() {});
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
              title: Text(text_list_menu[0]),
              onTap: () {
                setState(() {
                  auto_scroll = false;
                  open_screen("home/account");
                });
              },
            ),
            ListTile(
              title: Text(text_list_menu[1]),
              onTap: () {
                open_screen("home/courses");
              },
            ),
            ListTile(
              title: Text(text_list_menu[2]),
              onTap: () {
                open_screen("home/buy_courses");
              },
            ),
            ListTile(
              title: Text(text_list_menu[3]),
              onTap: () {
                open_screen("home/certificates_and_rewards");
              },
            ),
            ListTile(
              title: Text(text_list_menu[4]),
              onTap: () {
                open_screen("home/privacy_policy");
              },
            ),
            ListTile(
              title: Text(text_list_menu[5]),
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
                Tooltip(
                  message: text_list_menu[0],
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
                  message: text_list_menu[1],
                  child: TextButton(
                    onPressed: () {
                      open_screen("home/courses");
                    },
                    child: Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tooltip(
                  message: text_list_menu[2],
                  child: TextButton(
                    onPressed: () {
                      open_screen("home/buy_courses");
                    },
                    child: Icon(
                      Icons.apps,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tooltip(
                  message: text_list_menu[3],
                  child: TextButton(
                    onPressed: () {
                      open_screen("home/certificates_and_rewards");
                    },
                    child: Icon(
                      Icons.streetview,
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

  check_permissions() async {
    if (await Permission.storage.isDenied) Permission.storage.request();
  }

  add_screens() {
    add_new_app_screen(
      AppScreen(
        name: "home/account",
        child: UserInfoView(
          uid: widget.user!.id,
          text_list: account_values_english,
          tc_and_pp_text: RichText(text: TextSpan()),
          gender_values: gender_values_english,
          country_values: [
            'United States',
            'Mexico',
            'Canada',
            'Brazil',
          ],
          text_color: color_abeinstitute_text,
          first_button_color: color_abeinstitute_main_button,
          second_button_color: color_abeinstitute_text,
          third_button_color: color_abeinstitute_text,
          logo_image_path: logo_image_path_abeinstitute,
          has_language_picker: has_language_picker_abeinstitute,
          topbar_color: color_abeinstitute_topbar,
          custom_background: null,
          user_info_form_type: UserInfoFormType.edit_account,
          outline_border: true,
          first_button_action: null,
          second_button_action: null,
          third_button_action: null,
          has_back_button: true,
          text_field_background_color: null,
        ),
      ),
    );

    add_new_app_screen(
      AppScreen(
        name: "home/buy_courses",
        child: BuyCourses(
          language_picker_items_text_color: color_abeinstitute_text,
          language_picker: true,
        ),
      ),
    );

    add_new_app_screen(
      AppScreen(
        name: "home/privacy_policy",
        child: PrivacyPolicy(
          url_base: "https://www.abeinstitute.com",
          use_topbar: true,
        ),
      ),
    );
  }

  check_login() async {
    if (FirebaseAuth.instance.currentUser != null) {
      User auth_user = FirebaseAuth.instance.currentUser!;
      print("User is sign");

      String uid = auth_user.uid;
      DocumentSnapshot snapshot_user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      widget.user = XapptorUser.from_snapshot(
        uid,
        snapshot_user.data() as Map<String, dynamic>,
      );

      setState(() {});
      add_screens();
    } else {
      print("User is not sign");

      Timer(Duration(milliseconds: 100), () {
        open_screen("login");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    check_login();

    translation_stream_menu = TranslationStream(
      text_list: text_list_menu,
      update_text_list_function: update_text_list,
      list_index: 0,
      active_translation: true,
    );

    translation_stream_cards_1 = TranslationStream(
      text_list: text_list_cards_1,
      update_text_list_function: update_text_list,
      list_index: 1,
      active_translation: true,
    );

    translation_stream_cards_2 = TranslationStream(
      text_list: text_list_cards_2,
      update_text_list_function: update_text_list,
      list_index: 2,
      active_translation: true,
    );

    translation_stream_list = [
      translation_stream_menu,
      translation_stream_cards_1,
      translation_stream_cards_2,
    ];

    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
      check_permissions();

    check_payment_result(context);
  }

  int first_current_page = 1;
  int second_current_page = 1;

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double elevation = 3;
    double border_radius = 20;

    bool is_focused_1 = false;
    bool is_focused_2 = false;
    bool is_focused_3 = false;
    bool is_focused_4 = false;
    bool is_focused_5 = false;
    bool is_focused_6 = false;
    bool is_focused_7 = false;
    bool is_focused_8 = false;

    if (!UniversalPlatform.isWeb || portrait) {
      is_focused_1 = first_current_page == 0;
      is_focused_2 = first_current_page == 1;
      is_focused_3 = first_current_page == 2;
      is_focused_4 = first_current_page == 3;
      is_focused_5 = second_current_page == 0;
      is_focused_6 = second_current_page == 1;
      is_focused_7 = second_current_page == 2;
      is_focused_8 = second_current_page == 3;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffold_key,
        endDrawer: drawer(),
        appBar: TopBar(
          background_color: color_abeinstitute_topbar,
          has_back_button: false,
          actions: widgets_action(portrait),
          custom_leading: null,
          logo_path: "assets/images/logo.png",
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: WidgetsCarousel(
                  update_current_page: (current_page) {
                    first_current_page = current_page;
                    setState(() {});
                  },
                  auto_scroll: auto_scroll,
                  dot_colors_active: [
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                  ],
                  dot_color_inactive: color_abeinstitute_ocean_blue,
                  children: <Widget>[
                    CardHolder(
                      image_path: "assets/images/traveler_2.jpg",
                      title: text_list_cards_1[0],
                      subtitle: text_list_cards_1[1],
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/account");
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_1,
                    ),
                    CardHolder(
                      image_path: "assets/images/courses.jpg",
                      title: text_list_cards_1[2],
                      subtitle: text_list_cards_1[3],
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/courses");
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_2,
                    ),
                    CardHolder(
                      image_path: "assets/images/course_student_1.jpg",
                      title: text_list_cards_1[4],
                      subtitle: text_list_cards_1[5],
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/buy_courses");
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_3,
                    ),
                    CardHolder(
                      image_path: "assets/images/course_student_2.jpg",
                      title: text_list_cards_1[6],
                      subtitle: text_list_cards_1[7],
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/certificates_and_rewards");
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_4,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: WidgetsCarousel(
                  update_current_page: (current_page) {
                    second_current_page = current_page;
                    setState(() {});
                  },
                  auto_scroll: auto_scroll,
                  dot_colors_active: [
                    color_facebook,
                    color_instagram,
                    color_twitter,
                    color_youtube,
                  ],
                  dot_color_inactive: color_abeinstitute_ocean_blue,
                  children: <Widget>[
                    CardHolder(
                      image_path: "",
                      title: "Facebook",
                      subtitle: text_list_cards_2[0],
                      background_image_alignment: Alignment.center,
                      icon: FontAwesome.facebook,
                      icon_background_color: color_facebook,
                      on_pressed: () {
                        launch_url(url_facebook_abeinstitute,
                            url_facebook_fallback_abeinstitute);
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_5,
                    ),
                    CardHolder(
                      image_path: "",
                      title: "Instagram",
                      subtitle: text_list_cards_2[1],
                      background_image_alignment: Alignment.topCenter,
                      icon: FontAwesome.instagram,
                      icon_background_color: color_instagram,
                      on_pressed: () {
                        launch_url(url_instagram_abeinstitute,
                            url_instagram_abeinstitute);
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_6,
                    ),
                    CardHolder(
                      image_path: "",
                      title: "Twitter",
                      subtitle: text_list_cards_2[1],
                      background_image_alignment: Alignment.topCenter,
                      icon: FontAwesome.twitter,
                      icon_background_color: color_twitter,
                      on_pressed: () {
                        launch_url(
                            url_twitter_abeinstitute, url_twitter_abeinstitute);
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_7,
                    ),
                    CardHolder(
                      image_path: "",
                      title: "Youtube",
                      subtitle: text_list_cards_2[2],
                      background_image_alignment: Alignment.center,
                      icon: FontAwesome.youtube,
                      icon_background_color: color_youtube,
                      on_pressed: () {
                        launch_url(
                            url_youtube_abeinstitute, url_youtube_abeinstitute);
                      },
                      elevation: elevation,
                      border_radius: border_radius,
                      is_focused: is_focused_8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
