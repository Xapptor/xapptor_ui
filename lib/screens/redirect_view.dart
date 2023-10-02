import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectView extends StatefulWidget {
  const RedirectView({
    super.key,
    required this.redirect_url,
    required this.screen_name,
  });

  final String redirect_url;
  final String screen_name;

  @override
  State<StatefulWidget> createState() => _RedirectViewState();
}

class _RedirectViewState extends State<RedirectView> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  redirect() async {
    // Uri current_uri = Uri.base;
    // String current_url = current_uri.toString();
    // int screen_name_index = current_url.indexOf(widget.screen_name);
    // String new_url = "${widget.redirect_url}/${current_url.substring(screen_name_index)}";
    await launchUrl(Uri.parse("https://flutter.io"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
