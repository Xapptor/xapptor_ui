import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xapptor_ui/widgets/contact_us_container/custom_icon_button.dart';

custom_icon_buttons({
  required String? facebook_url,
  required String? facebook_url_fallback,
  required String? youtube_url,
  required String? instagram_url,
  required String? twitter_url,
  required Color icon_color,
}) =>
    Row(
      children: [
        const Spacer(flex: 1),
        if (facebook_url != null)
          Expanded(
            flex: 5,
            child: custom_icon_button(
              urls: [
                facebook_url,
                facebook_url_fallback!,
              ],
              icon: FontAwesomeIcons.squareFacebook,
              icon_color: icon_color,
            ),
          ),
        if (youtube_url != null)
          Expanded(
            flex: 5,
            child: custom_icon_button(
              urls: [
                youtube_url,
                youtube_url,
              ],
              icon: FontAwesomeIcons.youtube,
              icon_color: icon_color,
            ),
          ),
        if (instagram_url != null)
          Expanded(
            flex: 5,
            child: custom_icon_button(
              urls: [
                instagram_url,
                instagram_url,
              ],
              icon: FontAwesomeIcons.instagram,
              icon_color: icon_color,
            ),
          ),
        if (twitter_url != null)
          Expanded(
            flex: 5,
            child: custom_icon_button(
              urls: [
                twitter_url,
                twitter_url,
              ],
              icon: FontAwesomeIcons.twitter,
              icon_color: icon_color,
            ),
          ),
        const Spacer(flex: 1),
      ],
    );
