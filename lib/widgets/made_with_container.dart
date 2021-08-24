import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_ui/values/version.dart';

class MadeWithContainer extends StatelessWidget {
  MadeWithContainer({
    required this.text_color,
    required this.background_color,
  });

  final Color text_color;
  final Color background_color;

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () async {
        // String url = "https://xapptor.com";
        // await launch(
        //   url,
        // );
      },
      child: Container(
        alignment: Alignment.center,
        height: 22,
        color: background_color,
        child: Text(
          current_software_version(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text_color,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
