import 'package:flutter/material.dart';
import 'topbar.dart';
import 'language_picker.dart';

class UserInfoViewContainer extends StatefulWidget {
  const UserInfoViewContainer({
    required this.current_language,
    required this.language_picker_callback,
    required this.child,
    required this.text_color,
    required this.topbar_color,
    required this.has_language_picker,
    required this.custom_background,
    required this.has_back_button,
  });

  final String? current_language;
  final Function? language_picker_callback;
  final Widget child;
  final Color text_color;
  final Color topbar_color;
  final bool has_language_picker;
  final Widget? custom_background;
  final bool has_back_button;

  @override
  _UserInfoViewContainerState createState() => _UserInfoViewContainerState();
}

class _UserInfoViewContainerState extends State<UserInfoViewContainer> {
  final GlobalKey<FormState> login_form_key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffold_key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return WillPopScope(
      onWillPop: () async => widget.has_back_button,
      child: Scaffold(
        key: scaffold_key,
        appBar: TopBar(
          background_color: widget.topbar_color,
          has_back_button: widget.has_back_button,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 20),
              width: portrait ? 100 : 200,
              child: widget.has_language_picker
                  ? LanguagePicker(
                      current_language: widget.current_language!,
                      language_picker_callback:
                          widget.language_picker_callback!,
                      language_picker_items_text_color: widget.text_color,
                    )
                  : Container(),
            ),
          ],
          custom_leading: null,
          logo_path: null,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewport_constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewport_constraints.minHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        widget.custom_background ??
                            Container(
                              color: Colors.white,
                            ),
                        Container(
                          color: widget.custom_background != null
                              ? Colors.transparent
                              : Colors.white,
                          child: widget.child,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
