import 'package:flutter/material.dart';
import 'package:xapptor_ui/utils/copy_to_clipboard.dart';
import 'package:xapptor_ui/values/version.dart';
import 'package:url_launcher/url_launcher.dart';

class AppVersionContainer extends StatefulWidget {
  final Color text_color;
  final Color? background_color;
  final String? url;

  const AppVersionContainer({
    super.key,
    required this.text_color,
    required this.background_color,
    this.url,
  });

  @override
  State<AppVersionContainer> createState() => _AppVersionContainerState();
}

class _AppVersionContainerState extends State<AppVersionContainer> {
  String software_version = "";

  get_software_version() async {
    software_version = await current_app_version();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    get_software_version();
  }

  @override
  Widget build(BuildContext context) {
    double view_padding_bottom = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      onTap: widget.url != null
          ? () async {
              await launchUrl(Uri.parse(widget.url!));
            }
          : null,
      onLongPress: () {
        Navigator.of(context).pop();
        copy_to_clipboard(
          data: software_version,
          message: "Version copied to clipboard",
          context: context,
        );
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: view_padding_bottom + (view_padding_bottom > 0 ? 10 : 30),
          width: MediaQuery.of(context).size.width,
          color: widget.background_color,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            software_version,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.text_color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
