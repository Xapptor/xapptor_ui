import 'package:flutter/material.dart';

// Page not found screen.

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({
    required this.logo_path,
  });

  final String logo_path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
              "assets/images/page_not_found.jpg",
            ),
          ),
        ),
      ),
    );
  }
}
