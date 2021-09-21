import 'package:flutter/material.dart';

// Color FIlters

ColorFilter color_filter_invert = ColorFilter.matrix(
  [
    //R  G   B    A  Const
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ],
);

// Social Media

Color color_facebook = Color(0xff1877f2);
Color color_instagram = Color(0xffc32aa3);
Color color_whatsapp = Color(0xff25d366);
Color color_twitter = Color(0xff08a0e9);
Color color_youtube = Color(0xffff0000);
