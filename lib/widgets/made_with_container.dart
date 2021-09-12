import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/version.dart';
import 'package:xapptor_logic/is_portrait.dart';

class MadeWithContainer extends StatelessWidget {
  MadeWithContainer({
    required this.text_color,
    required this.background_color,
  });

  final Color text_color;
  final Color background_color;

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double view_padding_bottom = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      onTap: () async {
        // String url = "https://xapptor.com";
        // await launch(
        //   url,
        // );
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: view_padding_bottom + (view_padding_bottom > 0 ? 10 : 30),
          width: MediaQuery.of(context).size.width,
          color: background_color,
          padding: EdgeInsets.only(top: 10),
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
      ),
    );
  }
}
