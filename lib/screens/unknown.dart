import 'package:flutter/material.dart';
import 'package:xapptor_logic/is_portrait.dart';

// Page not found screen.

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({
    required this.logo_path,
  });

  final String logo_path;

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    bool portrait = is_portrait(context);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: screen_height,
        width: screen_width,
        color: Colors.white,
        child: FractionallySizedBox(
          heightFactor: portrait ? 1 : 0.6,
          widthFactor: portrait ? 1 : 0.6,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  "packages/xapptor_ui/assets/images/page_not_found.jpg",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
