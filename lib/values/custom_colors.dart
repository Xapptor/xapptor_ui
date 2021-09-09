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

// Abeinstitute
Color color_abeinstitute_green = Color(0xff1A4237);
Color color_abeinstitute_dark_aqua = Color(0xff33688A);
Color color_abeinstitute_light_aqua = Color(0xff53AAC5);
Color color_abeinstitute_ocean_blue = Color(0xff52A0D2);
Color color_abeinstitute_background_grey = Color(0xffEEEEEE);

Color color_abeinstitute_topbar = color_abeinstitute_ocean_blue;
Color color_abeinstitute_text = color_abeinstitute_ocean_blue;
Color color_abeinstitute_card = Colors.transparent;

LinearGradient color_abeinstitute_main_button = LinearGradient(
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  colors: [
    color_abeinstitute_dark_aqua,
    color_abeinstitute_ocean_blue,
  ],
);

material_color_abeinstitute() {
  Color ocean_blue = color_abeinstitute_ocean_blue;

  return MaterialColor(
    0xff52A0D2,
    <int, Color>{
      50: ocean_blue.withOpacity(0.1),
      100: ocean_blue.withOpacity(0.2),
      200: ocean_blue.withOpacity(0.3),
      300: ocean_blue.withOpacity(0.4),
      400: ocean_blue.withOpacity(0.5),
      500: ocean_blue.withOpacity(0.6),
      600: ocean_blue.withOpacity(0.7),
      700: ocean_blue.withOpacity(0.8),
      800: ocean_blue.withOpacity(0.9),
      900: ocean_blue.withOpacity(1.0),
    },
  );
}

// Emissor
Color color_emissor_dark_blue = Color(0xff1b4061);
Color color_emissor_aqua = Color(0xff00a4c7);
Color color_emissor_dark_aqua_gradient = Color(0xff22adbe);
Color color_emissor_light_aqua_gradient = Color(0xff48bcc9);
Color color_emissor_fuchsia = Color(0xffcc5ac9);
Color color_emissor_radical_red = Color(0xfffe4d57);
Color color_emissor_light_pink = Color(0xffc8689c);
Color color_emissor_dark_pink = Color(0xffc81f79);

Color color_emissor_topbar = color_emissor_dark_blue;
Color color_emissor_text = color_emissor_dark_blue;
Color color_emissor_card = Colors.transparent;

LinearGradient color_emissor_main_button = LinearGradient(
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  colors: [
    color_emissor_radical_red,
    color_emissor_fuchsia,
  ],
);

LinearGradient color_emissor_circular_pink = LinearGradient(
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  colors: [
    color_emissor_light_pink.withOpacity(0.8),
    color_emissor_dark_pink.withOpacity(0.6),
  ],
  stops: [
    0.0,
    1.0,
  ],
);

material_color_emissor() {
  Color dark_blue = color_emissor_dark_blue;
  return MaterialColor(
    0xff1b4061,
    <int, Color>{
      50: dark_blue.withOpacity(0.1),
      100: dark_blue.withOpacity(0.2),
      200: dark_blue.withOpacity(0.3),
      300: dark_blue.withOpacity(0.4),
      400: dark_blue.withOpacity(0.5),
      500: dark_blue.withOpacity(0.6),
      600: dark_blue.withOpacity(0.7),
      700: dark_blue.withOpacity(0.8),
      800: dark_blue.withOpacity(0.9),
      900: dark_blue.withOpacity(1.0),
    },
  );
}

// Lum
Color color_lum_green = Color(0xff41AB34);
Color color_lum_dark_pink = Color(0xffAD358D);
Color color_lum_light_pink = Color(0xffF465C3);
Color color_lum_grey = Color(0xffAFAEAE);
Color color_lum_blue = Color(0xff2C8FBE);

Color color_lum_topbar = color_lum_blue;
Color color_lum_text = Colors.white;
Color color_lum_card = Colors.transparent;

LinearGradient color_lum_main_button = LinearGradient(
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  colors: [
    Colors.transparent,
    Colors.transparent,
  ],
);

material_color_lum() {
  Color green = color_lum_green;

  return MaterialColor(
    0xff52A0D2,
    <int, Color>{
      50: green.withOpacity(0.1),
      100: green.withOpacity(0.2),
      200: green.withOpacity(0.3),
      300: green.withOpacity(0.4),
      400: green.withOpacity(0.5),
      500: green.withOpacity(0.6),
      600: green.withOpacity(0.7),
      700: green.withOpacity(0.8),
      800: green.withOpacity(0.9),
      900: green.withOpacity(1.0),
    },
  );
}
