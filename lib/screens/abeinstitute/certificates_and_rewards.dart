import 'dart:async';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:xapptor_logic/generate_certificate.dart';
import 'package:xapptor_logic/get_user_info.dart';
import 'package:xapptor_logic/timestamp_to_date.dart';
import 'package:xapptor_ui/models/abeinstitute/certificate.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';
import 'package:xapptor_ui/widgets/bottom_bar_container.dart';
import 'package:xapptor_ui/widgets/covered_container_coming_soon.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'certificate_visualizer.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CertificatesAndRewards extends StatefulWidget {
  @override
  _CertificatesAndRewardsState createState() => _CertificatesAndRewardsState();
}

class _CertificatesAndRewardsState extends State<CertificatesAndRewards> {
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);
  late SharedPreferences prefs;

  List certificates_id = [];
  List courses_id = [];
  List<Certificate> certificates = [];
  Map<String, dynamic> user_info = {};
  String user_id = "";

  @override
  void initState() {
    super.initState();
    set_user_info();
  }

  set_user_info() async {
    user_id = FirebaseAuth.instance.currentUser!.uid;
    user_info = await get_user_info(user_id);
    setState(() {});
    check_user_courses();
    get_certificates();

    Timer(Duration(seconds: 2), () async {
      user_id = FirebaseAuth.instance.currentUser!.uid;
      user_info = await get_user_info(user_id);
      get_certificates();
    });
  }

  check_user_courses() {
    if (user_info["courses_buyed"] != null) {
      if (user_info["courses_buyed"].length > 0) {
        courses_id = List.from(user_info["courses_buyed"]);
        for (var course_id in courses_id) {
          check_if_course_is_completed(
            course_id: course_id,
            user_info: user_info,
            context: context,
          );
        }
      }
    }
  }

  get_certificates() async {
    certificates.clear();
    if (user_info["certificates"] != null) {
      if (user_info["certificates"].length > 0) {
        certificates_id = List.from(user_info["certificates"]);

        for (var certificate_id in certificates_id) {
          await FirebaseFirestore.instance
              .collection("certificates")
              .doc(certificate_id)
              .get()
              .then((snapshot_certificate) async {
            Map<String, dynamic> data_certificate =
                snapshot_certificate.data()!;

            await FirebaseFirestore.instance
                .collection("courses")
                .doc(data_certificate["course_id"])
                .get()
                .then((snapshot_course) {
              Map<String, dynamic> data_course = snapshot_course.data()!;

              certificates.add(
                Certificate(
                  id: certificate_id,
                  date: timestamp_to_date(data_certificate["date"]),
                  course_name: data_course["name"],
                  user_name:
                      user_info["firstname"] + " " + user_info["lastname"],
                  user_id: user_id,
                ),
              );
              setState(() {});
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: TopBar(
        background_color: color_abeinstitute_topbar,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: BottomBarContainer(
        initial_page: 0,
        bottom_bar_buttons: [
          BottomBarButton(
            icon: ModernPictograms.article_alt,
            text: "Certificates",
            foreground_color: Colors.white,
            background_color: color_abeinstitute_green,
            page: certificates_id.isEmpty
                ? Container(
                    child: Center(
                      child: Text("Certificates list is empty"),
                    ),
                  )
                : Container(
                    child: ListView.builder(
                      itemCount: certificates.length,
                      itemBuilder: (context, i) {
                        EdgeInsets margin = EdgeInsets.all(20);
                        EdgeInsets padding = EdgeInsets.all(10);

                        return FractionallySizedBox(
                          widthFactor: portrait ? 1 : 0.4,
                          child: Container(
                            margin: margin,
                            child: CustomCard(
                              elevation: 3,
                              border_radius: 20,
                              linear_gradient: null,
                              on_pressed: () {
                                String certificate_id = certificates[i].id;
                                add_new_app_screen(
                                  AppScreen(
                                    name:
                                        "home/certificates_and_rewards/certificate_$certificate_id",
                                    child: CertificatesVisualizer(
                                      certificate: certificates[i],
                                    ),
                                  ),
                                );
                                open_screen(
                                    "home/certificates_and_rewards/certificate_$certificate_id");
                              },
                              child: Container(
                                padding: padding,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        certificates[i].course_name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                              text: 'Date: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: certificates[i].date,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ID: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(certificates[i].id),
                                        ],
                                      ),
                                    ],
                                  ),
                                  leading: Icon(
                                    ModernPictograms.article_alt,
                                    color: color_abeinstitute_topbar,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          BottomBarButton(
            icon: FontAwesome5.gift,
            text: "Rewards",
            foreground_color: Colors.white,
            background_color: color_abeinstitute_light_aqua,
            page: CoveredContainerComingSoon(
              enable_cover: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CertificateListItem {
  CertificateListItem(
    this.id,
    this.date,
    this.icon,
  );

  final String id;
  final String date;
  final IconData icon;
}
