import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

// Launch URL with fallback.

launch_url(String url, String fallback_url) async {
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        Uri.parse(fallback_url),
        mode: LaunchMode.externalApplication,
      );
    }
  } catch (e) {
    debugPrint(e.toString());
    await launchUrl(
      Uri.parse(fallback_url),
    );
  }
}
