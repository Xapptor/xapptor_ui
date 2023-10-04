import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/additional_colors.dart';
import 'package:xapptor_ui/values/dimensions.dart';
import 'package:xapptor_ui/values/text_theme.dart';
import 'package:xapptor_ui/values/xapptor_color_scheme.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';
import 'package:xapptor_ui/values/xapptor_input_decoration_theme.dart';

final xapptor_theme = ThemeData.light().copyWith(
  colorScheme: xapptor_color_scheme_light,
  textTheme: xapptor_text_theme,
  scaffoldBackgroundColor: const Color(0xFFfafafb),
  cardTheme: const CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.d16)),
    ),
    elevation: Dimensions.d4,
    shadowColor: XapptorColors.cultured,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: XapptorColors.white,
    selectedItemColor: XapptorColors.dark_powder_blue,
    unselectedItemColor: XapptorColors.steel_teal,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: XapptorColors.dark_powder_blue),
      shape: const StadiumBorder(),
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    const AdditionalColors.light(),
  ],
  inputDecorationTheme: xapptor_input_decoration_theme,
);
