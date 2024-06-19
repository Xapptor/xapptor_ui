import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xapptor_router/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkLightSwitch extends StatefulWidget {
  const DarkLightSwitch({
    super.key,
  });

  @override
  State<DarkLightSwitch> createState() => _DarkLightSwitchState();
}

class _DarkLightSwitchState extends State<DarkLightSwitch> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _check_theme_mode();
  }

  _check_theme_mode() async {
    prefs = await SharedPreferences.getInstance();
    theme_mode = (prefs!.getString("theme_mode") ?? "light") == "light" ? ThemeMode.light : ThemeMode.dark;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WidgetStatePropertyAll<Icon> thumb_icon = WidgetStatePropertyAll(
      Icon(
        theme_mode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode,
      ),
    );

    WidgetStatePropertyAll<Color> thumb_color = WidgetStatePropertyAll(
      theme_mode == ThemeMode.light ? Colors.amber : Colors.blueGrey,
    );

    return Switch(
      value: theme_mode == ThemeMode.dark,
      thumbIcon: thumb_icon,
      thumbColor: thumb_color,
      onChanged: (bool new_value) {
        if (prefs != null) {
          theme_mode = new_value ? ThemeMode.dark : ThemeMode.light;
          setState(() {});

          prefs!.setString("theme_mode", theme_mode == ThemeMode.light ? "light" : "dark");
          Timer(const Duration(milliseconds: 500), () {
            toggle_app_theme(new_theme_mode: theme_mode);
          });
        }
      },
    );
  }
}
