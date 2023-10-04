import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/xapptor_colors.dart';

// Example at https://github.com/flutter/flutter/pull/98033

@immutable
class AdditionalColors extends ThemeExtension<AdditionalColors> {
  final Color green;
  final Color on_green;
  final Color red;
  final Color on_red;
  final Color orange;
  final Color orange_background;
  final Color link;

  const AdditionalColors({
    required this.green,
    required this.on_green,
    required this.red,
    required this.on_red,
    required this.orange,
    required this.orange_background,
    required this.link,
  });

  const AdditionalColors.light({
    this.green = XapptorColors.dark_lemon_lime,
    this.on_green = XapptorColors.white,
    this.red = XapptorColors.medium_candy_apple_red,
    this.on_red = XapptorColors.white,
    this.orange = XapptorColors.tangerine,
    this.orange_background = XapptorColors.old_lace,
    this.link = XapptorColors.dark_powder_blue,
  });

  @override
  AdditionalColors copyWith({
    Color? green,
    Color? on_green,
    Color? red,
    Color? on_red,
    Color? orange,
    Color? orange_background,
    Color? link,
  }) {
    return AdditionalColors(
      green: green ?? this.green,
      on_green: on_green ?? this.on_green,
      red: red ?? this.red,
      on_red: on_red ?? this.on_red,
      orange: orange ?? this.orange,
      orange_background: orange_background ?? this.orange_background,
      link: link ?? this.link,
    );
  }

  @override
  AdditionalColors lerp(
    AdditionalColors? other,
    double t,
  ) {
    if (other is! AdditionalColors) {
      return this;
    }
    return const AdditionalColors.light().copyWith(
      green: Color.lerp(
        green,
        other.green,
        t,
      ),
      on_green: Color.lerp(
        on_green,
        other.on_green,
        t,
      ),
      red: Color.lerp(
        red,
        other.red,
        t,
      ),
      on_red: Color.lerp(
        on_red,
        other.on_red,
        t,
      ),
      orange: Color.lerp(
        orange,
        other.orange,
        t,
      ),
      orange_background: Color.lerp(
        orange_background,
        other.orange_background,
        t,
      ),
      link: Color.lerp(
        link,
        other.link,
        t,
      ),
    );
  }

  @override
  String toString() =>
      'AdditionalColors(green: $green, on_green: $on_green, red: $red, on_red: $on_red, orange: $orange, orange_background: $orange_background, link: $link)';
}
