import 'package:flutter/material.dart';

class Topbar extends StatefulWidget {
  const Topbar({
    required this.background_color,
    required this.size,
    required this.actions,
    required this.has_back_button,
    required this.custom_leading,
    this.logo_path,
  });

  final Color background_color;
  final double size;
  final List<Widget> actions;
  final bool has_back_button;
  final Widget? custom_leading;
  final String? logo_path;

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  Color current_color = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double logo_size = 70;

    return widget.logo_path != null
        ? AppBar(
            leading:
                !widget.has_back_button ? Container() : widget.custom_leading,
            title: Image.asset(
              widget.logo_path!,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              height: logo_size,
            ),
            backgroundColor: widget.background_color,
            elevation: 0,
            actions: widget.actions,
          )
        : AppBar(
            leading:
                !widget.has_back_button ? Container() : widget.custom_leading,
            title: Container(
              height: widget.size,
              width: widget.size,
            ),
            backgroundColor: widget.background_color,
            elevation: 0,
            actions: widget.actions,
          );
  }
}
