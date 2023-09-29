import 'package:flutter/material.dart';

// Color filters.

ColorFilter color_filter_invert = const ColorFilter.matrix(
  [
    //R  G   B    A  Const
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ],
);

// Social Media.

Color color_facebook = const Color(0xff1877f2);
Color color_instagram = const Color(0xffc32aa3);
Color color_whatsapp = const Color(0xff25d366);
Color color_twitter = const Color(0xff08a0e9);
Color color_youtube = const Color(0xffff0000);
Color color_github = const Color(0xff2488FF);
