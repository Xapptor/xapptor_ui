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
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/language_picker.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/values/urls.dart';
import 'package:xapptor_ui/screens/abeinstitute/buy_courses.dart';
import 'package:xapptor_ui/widgets/generic_card_holder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/widgets_carousel.dart';

class Home extends StatefulWidget {
  Home({
    required this.user,
  });

  XapptorUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();
  bool auto_scroll = false;

  List<String> text_list = [
    "Account",
    "Notifications",
    "My courses",
    "Buy courses",
    "Certificates and Rewards",
    "Settings",
    "Logout",
  ];

  String current_language = "en";

  TranslationStream translation_stream = TranslationStream();

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
                setState(() {
                  auto_scroll = false;
                  open_screen("home/account");
                });
              },
            ),
            ListTile(
              title: Text(text_list[1]),
              onTap: () {},
            ),
            ListTile(
              title: Text(text_list[2]),
              onTap: () {
                open_screen("home/courses");
              },
            ),
            ListTile(
              title: Text(text_list[3]),
              onTap: () {
                open_screen("home/buy_courses");
              },
            ),
            ListTile(
              title: Text(text_list[4]),
              onTap: () {
                open_screen("home/certificates_and_rewards");
              },
            ),
            ListTile(
              title: Text(text_list[5]),
              onTap: () {},
            ),
            ListTile(
              title: Text(text_list[6]),
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

  language_picker_callback(String new_current_language) async {
    current_language = new_current_language;
    translation_stream.translate();
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
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tooltip(
                  message: text_list[2],
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
                  message: text_list[3],
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
                  message: text_list[4],
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
                Tooltip(
                  message: text_list[5],
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

  update_text_list(int index, String new_text) {
    text_list[index] = new_text;
    setState(() {});
  }

  check_permissions() async {
    if (await Permission.storage.isDenied) Permission.storage.request();
  }

  add_screens() {
    add_new_app_screen(
      AppScreen(
        name: "home/account",
        child: UserInfoView(
          uid: widget.user.id,
          text_list: [
            "Email",
            "Confirm Email",
            "Password",
            "Confirm password",
            "First name",
            "Last name",
            "Enter your date of birth",
            "Save",
          ],
          gender_values: [
            'Male',
            'Female',
            'Non-binary',
            'Rather not say',
          ],
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
          secret_answer_values: [],
          secret_question_values: [],
          logo_height: logo_height_abeinstitute,
          logo_width: logo_width_abeinstitute,
          has_back_button: true,
          text_field_background_color: null,
        ),
      ),
    );

    add_new_app_screen(
      AppScreen(
        name: "home/buy_courses",
        child: BuyCourses(
          language_picker_items_text_color: color_abeinstitute_ocean_blue,
          language_picker: true,
          buyer_info: BuyerInfo(
            user_id: widget.user.id,
            email: widget.user.email,
          ),
          topbar_color: color_abeinstitute_green.withOpacity(0.7),
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
    translation_stream.init(text_list, update_text_list);
    translation_stream.translate();

    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
      check_permissions();

    check_payment_result(context);
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double card_holder_elevation = 3;
    double card_holder_border_radius = 16;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffold_key,
        endDrawer: drawer(),
        appBar: TopBar(
          background_color: color_abeinstitute_dark_aqua.withOpacity(0.7),
          has_back_button: false,
          actions: widgets_action(portrait),
          custom_leading: null,
          logo_path: "assets/images/logo.png",
        ),
        body: Column(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: WidgetsCarousel(
                  auto_scroll: auto_scroll,
                  dot_colors_active: [
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                    color_abeinstitute_green,
                  ],
                  dot_color_inactive: color_abeinstitute_ocean_blue,
                  children: <Widget>[
                    generic_card_holder(
                      image_path: "assets/images/traveler_2.jpg",
                      title: "Account",
                      subtitle: "Edit your Info",
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/account");
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/courses.jpg",
                      title: "Courses",
                      subtitle: "Complete the Units",
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/courses");
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/course_student_1.jpg",
                      title: "New Courses",
                      subtitle: "to extend your Knowledge",
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/buy_courses");
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/course_student_2.jpg",
                      title: "Certificates",
                      subtitle: "and Rewards",
                      background_image_alignment: Alignment.center,
                      icon: null,
                      icon_background_color: null,
                      on_pressed: () {
                        open_screen("home/certificates_and_rewards");
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: WidgetsCarousel(
                  auto_scroll: auto_scroll,
                  dot_colors_active: [
                    color_facebook,
                    color_instagram,
                    color_twitter,
                    color_youtube,
                  ],
                  dot_color_inactive: color_abeinstitute_ocean_blue,
                  children: <Widget>[
                    generic_card_holder(
                      image_path: "assets/images/family.jpg",
                      title: "Facebook",
                      subtitle: "Official Page",
                      background_image_alignment: Alignment.center,
                      icon: FontAwesome.facebook,
                      icon_background_color: color_facebook,
                      on_pressed: () {
                        launch_url(url_facebook_abeinstitute,
                            url_facebook_fallback_abeinstitute);
                        print("Something");
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/traveler_1.jpg",
                      title: "Instagram",
                      subtitle: "Official Account",
                      background_image_alignment: Alignment.topCenter,
                      icon: FontAwesome.instagram,
                      icon_background_color: color_instagram,
                      on_pressed: () {
                        launch_url(url_instagram_abeinstitute,
                            url_instagram_abeinstitute);
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/traveler_2.jpg",
                      title: "Twitter",
                      subtitle: "Official Account",
                      background_image_alignment: Alignment.topCenter,
                      icon: FontAwesome.twitter,
                      icon_background_color: color_twitter,
                      on_pressed: () {
                        launch_url(
                            url_twitter_abeinstitute, url_twitter_abeinstitute);
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
                    ),
                    generic_card_holder(
                      image_path: "assets/images/project_demo_1.jpg",
                      title: "Youtube",
                      subtitle: "Official Channel",
                      background_image_alignment: Alignment.center,
                      icon: FontAwesome.youtube,
                      icon_background_color: color_youtube,
                      on_pressed: () {
                        launch_url(
                            url_youtube_abeinstitute, url_youtube_abeinstitute);
                      },
                      card_holder_elevation: card_holder_elevation,
                      card_holder_border_radius: card_holder_border_radius,
                      context: context,
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
