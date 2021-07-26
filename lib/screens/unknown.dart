import 'package:flutter/material.dart';

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
        //height: 100,
        //width: 300,
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
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    logoPath,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text('404 - Sorry, Baby not found!'),
          ],
        ),
      ),*/
    );
  }
}
