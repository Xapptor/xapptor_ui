import 'package:xapptor_logic/timestamp_to_date.dart';
import 'package:xapptor_ui/widgets/covered_container_coming_soon.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_auth/get_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xapptor_router/app_screen.dart';
import 'package:xapptor_router/app_screens.dart';
import 'certificate_visualizer.dart';
import 'package:xapptor_ui/widgets/topbar.dart';

class CertificatesAndRewards extends StatefulWidget {
  const CertificatesAndRewards({
    required this.topbar_color,
  });

  final Color topbar_color;

  @override
  _CertificatesAndRewardsState createState() => _CertificatesAndRewardsState();
}

class _CertificatesAndRewardsState extends State<CertificatesAndRewards> {
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);
  late SharedPreferences prefs;

  List certificates_id = [];
  List<Map<String, dynamic>> certificates = <Map<String, dynamic>>[];

  Map<String, dynamic> user_info = {};

  late String uid;

  init_prefs() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid")!;
    get_certificates();
  }

  get_certificates() async {
    user_info = await get_user_info(uid);
    certificates.clear();

    print(user_info);

    if (user_info["certificates"] != null) {
      if (user_info["certificates"].length > 0) {
        certificates_id = List.from(user_info["certificates"]);

        print(certificates_id);

        for (int i = 0; i < certificates_id.length; i++) {
          DocumentSnapshot firestore_certificate = await FirebaseFirestore
              .instance
              .collection("certificates")
              .doc(certificates_id[i])
              .get();

          DocumentSnapshot firestore_course = await FirebaseFirestore.instance
              .collection("courses")
              .doc(firestore_certificate.get("course_id"))
              .get();

          DocumentSnapshot firestore_user = await FirebaseFirestore.instance
              .collection("users")
              .doc(firestore_certificate.get("user_id"))
              .get();

          print(firestore_certificate.data);
          print(firestore_course.data);
          print(firestore_user.data);

          certificates.add({
            "date": firestore_certificate.get("date"),
            "course_name": firestore_course.get("name"),
            "user_name": firestore_user.get("firstname") +
                " " +
                firestore_user.get("lastname"),
            "id": certificates_id[i],
          });
        }
      }
    }

    print("certificates: " + certificates.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init_prefs();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: TopBar(
        background_color: widget.topbar_color,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
      ),
      body: Column(
        children: [
          Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  Spacer(flex: 3),
                  Expanded(
                    flex: portrait ? 5 : 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          current_page == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        page_controller.animateToPage(0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'Certificates',
                        style: TextStyle(
                          color: current_page == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: portrait ? 5 : 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          current_page == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        page_controller.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'Rewards',
                        style: TextStyle(
                          color: current_page == 1
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 7,
            child: Stack(
              children: <Widget>[
                PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      current_page = page.toDouble();
                    });
                  },
                  controller: page_controller,
                  children: [
                    Container(
                      child: certificates_id.length > 0
                          ? FractionallySizedBox(
                              widthFactor: portrait ? 0.8 : 0.5,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: ListView.builder(
                                  itemCount: certificates.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        String certificate_id =
                                            certificates[i]["id"];

                                        add_new_app_screen(
                                          AppScreen(
                                            name:
                                                "home/certificates_and_rewards/certificate_$certificate_id",
                                            child: CertificatesVisualizer(
                                              id: certificate_id,
                                              uid: uid,
                                              user_name: certificates[i]
                                                  ["user_name"],
                                              course_name: certificates[i]
                                                  ["course_name"],
                                              date: TimestampToDate().convert(
                                                  certificates[i]["date"]),
                                              topbar_color:
                                                  color_abeinstitute_dark_aqua
                                                      .withOpacity(0.7),
                                            ),
                                          ),
                                        );
                                        open_screen(
                                            "home/certificates_and_rewards/certificate_$certificate_id");
                                      },
                                      child: ListTile(
                                        title: Text(
                                          "Date: ${TimestampToDate().convert(certificates[i]["date"])} \nCourse Name: ${certificates[i]["course_name"]} \nCertificate ID: ${certificates[i]["id"]}",
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        leading: Icon(
                                          Icons.account_circle,
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                    ),
                    CoveredContainerComingSoon(
                      enable_cover: true,
                      child: Container(
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class Certificate {
  Certificate(
    this.id,
    this.date,
    this.icon,
  );

  final String id;
  final String date;
  final IconData icon;
}
