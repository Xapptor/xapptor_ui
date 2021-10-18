import 'package:flutter/widgets.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:xapptor_logic/generate_certificate.dart';
import 'package:xapptor_logic/get_user_info.dart';
import 'package:xapptor_logic/timestamp_to_date.dart';
import 'package:xapptor_translation/translate.dart';
import 'package:xapptor_ui/models/course_certificate.dart';
import 'package:xapptor_ui/models/bottom_bar_button.dart';
import 'package:xapptor_ui/widgets/bottom_bar_container.dart';
import 'package:xapptor_ui/widgets/coming_soon_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_translation/language_picker.dart';
import 'certificate_visualizer.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xapptor_logic/is_portrait.dart';

class CertificatesAndRewards extends StatefulWidget {
  const CertificatesAndRewards({
    required this.topbar_color,
    required this.text_color,
    required this.button_color_1,
    required this.button_color_2,
  });

  final Color topbar_color;
  final Color text_color;
  final Color button_color_1;
  final Color button_color_2;

  @override
  _CertificatesAndRewardsState createState() => _CertificatesAndRewardsState();
}

class _CertificatesAndRewardsState extends State<CertificatesAndRewards> {
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);

  List certificates_id = [];
  List courses_id = [];
  List<CourseCertificate> certificates = [];
  Map<String, dynamic> user_info = {};
  String user_id = "";

  late TranslationStream translation_stream;
  List<TranslationStream> translation_stream_list = [];
  List<String> text_list = [
    "Certificates",
    "Rewards",
    "You have no rewards",
  ];

  update_text_list({
    required int index,
    required String new_text,
    required int list_index,
  }) {
    text_list[index] = new_text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    translation_stream = TranslationStream(
      text_list: text_list,
      update_text_list_function: update_text_list,
      list_index: 0,
      active_translation: true,
    );
    translation_stream_list = [translation_stream];

    set_user_info();
  }

  set_user_info() async {
    user_id = FirebaseAuth.instance.currentUser!.uid;
    user_info = await get_user_info(user_id);
    setState(() {});
    check_user_courses();
    get_certificates();
  }

  check_user_courses() {
    if (user_info["products_acquired"] != null) {
      if (user_info["products_acquired"].length > 0) {
        courses_id = List.from(user_info["products_acquired"]);
        for (var course_id in courses_id) {
          check_if_course_was_completed(
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
                CourseCertificate(
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
    bool portrait = is_portrait(context);
    double screen_height = MediaQuery.of(context).size.height;
    EdgeInsets margin = EdgeInsets.all(20);
    EdgeInsets padding = EdgeInsets.all(10);

    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            width: 150,
            child: LanguagePicker(
              translation_stream_list: translation_stream_list,
              language_picker_items_text_color: widget.text_color,
            ),
          ),
        ],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: BottomBarContainer(
        current_page_callback: (int i) {},
        initial_page: 0,
        bottom_bar_buttons: [
          BottomBarButton(
            icon: ModernPictograms.article_alt,
            text: text_list[0],
            foreground_color: Colors.white,
            background_color: widget.button_color_1,
            page: certificates_id.isEmpty
                ? Container(
                    child: Center(
                      child: Text(
                        "You don't have any certificate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: ListView.builder(
                      itemCount: certificates.length,
                      itemBuilder: (context, i) {
                        return FractionallySizedBox(
                          widthFactor: portrait ? 1 : 0.4,
                          child: Container(
                            height: screen_height / (portrait ? 6 : 8),
                            margin: margin,
                            child: CustomCard(
                              splash_color:
                                  widget.button_color_2.withOpacity(0.2),
                              elevation: 3,
                              border_radius: 20,
                              on_pressed: () {
                                String certificate_id = certificates[i].id;
                                add_new_app_screen(
                                  AppScreen(
                                    name:
                                        "home/certificates_and_rewards/certificate_$certificate_id",
                                    child: CertificatesVisualizer(
                                      certificate: certificates[i],
                                      topbar_color: widget.topbar_color,
                                    ),
                                  ),
                                );
                                open_screen(
                                    "home/certificates_and_rewards/certificate_$certificate_id");
                              },
                              child: Center(
                                child: Container(
                                  padding: padding,
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                      color: widget.topbar_color,
                                    ),
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
            text: text_list[1],
            foreground_color: Colors.white,
            background_color: widget.button_color_2,
            page: ComingSoonContainer(
              text: text_list[2],
              enable_cover: true,
            ),
          ),
        ],
      ),
    );
  }
}
