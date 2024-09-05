import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/contact_us_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xapptor_ui/widgets/contact_us_container/custom_icon_button.dart';

extension StateExtension on ContactUsContainerState {
  custom_icon_buttons() => Row(
        children: [
          const Spacer(flex: 1),
          if (widget.facebook_url != null)
            Expanded(
              flex: 5,
              child: custom_icon_button(
                urls: [
                  widget.facebook_url!,
                  widget.facebook_url_fallback!,
                ],
                icon: FontAwesomeIcons.squareFacebook,
                icon_color: widget.icon_color,
              ),
            ),
          if (widget.youtube_url != null)
            Expanded(
              flex: 5,
              child: custom_icon_button(
                urls: [
                  widget.youtube_url!,
                  widget.youtube_url!,
                ],
                icon: FontAwesomeIcons.youtube,
                icon_color: widget.icon_color,
              ),
            ),
          if (widget.instagram_url != null)
            Expanded(
              flex: 5,
              child: custom_icon_button(
                urls: [
                  widget.instagram_url!,
                  widget.instagram_url!,
                ],
                icon: FontAwesomeIcons.instagram,
                icon_color: widget.icon_color,
              ),
            ),
          if (widget.twitter_url != null)
            Expanded(
              flex: 5,
              child: custom_icon_button(
                urls: [
                  widget.twitter_url!,
                  widget.twitter_url!,
                ],
                icon: FontAwesomeIcons.twitter,
                icon_color: widget.icon_color,
              ),
            ),
          const Spacer(flex: 1),
        ],
      );
}
