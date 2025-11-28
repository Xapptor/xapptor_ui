// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

/// A model class containing the color configuration for ExternalLinkButton.
class ExternalLinkButtonColors {
  /// The start color of the gradient (top-left).
  final Color gradient_start;

  /// The end color of the gradient (bottom-right).
  final Color gradient_end;

  /// The border color.
  final Color border;

  /// The shadow/glow color.
  final Color shadow;

  /// The icon and text color.
  final Color content;

  /// The icon and text color when hovered.
  final Color content_hovered;

  const ExternalLinkButtonColors({
    this.gradient_start = const Color(0xFFFFE4B5),
    this.gradient_end = const Color(0xFFFFD494),
    this.border = const Color(0xFFE8C87A),
    this.shadow = const Color(0xFFFFD494),
    this.content = const Color(0xFF616161),
    this.content_hovered = const Color(0xFF6B5B3D),
  });

  /// Preset for Amazon-style warm amber colors.
  static const ExternalLinkButtonColors amazon = ExternalLinkButtonColors();

  /// Preset for soft pink colors.
  static const ExternalLinkButtonColors pink = ExternalLinkButtonColors(
    gradient_start: Color(0xFFFFC2E0),
    gradient_end: Color(0xFFFFB3D4),
    border: Color(0xFFE8A0C0),
    shadow: Color(0xFFFFC2E0),
    content: Color(0xFF616161),
    content_hovered: Color(0xFF8B5A6B),
  );

  /// Preset for soft blue colors.
  static const ExternalLinkButtonColors blue = ExternalLinkButtonColors(
    gradient_start: Color(0xFFA7D8FF),
    gradient_end: Color(0xFF8ECAFF),
    border: Color(0xFF7AB8E8),
    shadow: Color(0xFFA7D8FF),
    content: Color(0xFF616161),
    content_hovered: Color(0xFF3D5B6B),
  );

  /// Preset for soft lavender colors.
  static const ExternalLinkButtonColors lavender = ExternalLinkButtonColors(
    gradient_start: Color(0xFFE6D8FF),
    gradient_end: Color(0xFFD4C2FF),
    border: Color(0xFFC8B0E8),
    shadow: Color(0xFFE6D8FF),
    content: Color(0xFF616161),
    content_hovered: Color(0xFF5B4B6B),
  );
}

/// A button widget that opens an external URL with elegant hover animations.
///
/// Features:
/// - Scale animation on hover
/// - Elevation lift effect
/// - Glow/shadow intensification
/// - Icon rotation and movement
/// - Color transitions
/// - Press feedback
class ExternalLinkButton extends StatefulWidget {
  /// The URL to open when the button is tapped.
  final String url;

  /// The label text displayed on the button.
  final String label;

  /// The icon displayed before the label.
  final IconData icon;

  /// The color configuration for the button.
  final ExternalLinkButtonColors colors;

  /// The border radius of the button.
  final double border_radius;

  /// The duration of the hover animation.
  final Duration animation_duration;

  /// Whether to show the external link icon.
  final bool show_external_icon;

  /// Callback when the URL is launched successfully.
  final VoidCallback? on_launched;

  /// Callback when the URL fails to launch.
  final VoidCallback? on_launch_failed;

  const ExternalLinkButton({
    super.key,
    required this.url,
    required this.label,
    this.icon = Icons.card_giftcard_rounded,
    this.colors = const ExternalLinkButtonColors(),
    this.border_radius = 30,
    this.animation_duration = const Duration(milliseconds: 200),
    this.show_external_icon = true,
    this.on_launched,
    this.on_launch_failed,
  });

  @override
  State<ExternalLinkButton> createState() => _ExternalLinkButtonState();
}

class _ExternalLinkButtonState extends State<ExternalLinkButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale_animation;
  late Animation<double> _elevation_animation;
  late Animation<double> _glow_animation;
  late Animation<double> _icon_rotation_animation;

  bool _is_pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animation_duration,
      vsync: this,
    );

    _scale_animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _elevation_animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _glow_animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _icon_rotation_animation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _on_hover(bool hovering) {
    if (hovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _on_tap_down(TapDownDetails details) {
    setState(() => _is_pressed = true);
  }

  void _on_tap_up(TapUpDetails details) {
    setState(() => _is_pressed = false);
  }

  void _on_tap_cancel() {
    setState(() => _is_pressed = false);
  }

  Future<void> _on_tap() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      widget.on_launched?.call();
    } else {
      widget.on_launch_failed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;

    return MouseRegion(
      onEnter: (_) => _on_hover(true),
      onExit: (_) => _on_hover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _on_tap_down,
        onTapUp: _on_tap_up,
        onTapCancel: _on_tap_cancel,
        onTap: _on_tap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final press_scale = _is_pressed ? 0.97 : 1.0;

            return Transform.scale(
              scale: _scale_animation.value * press_scale,
              child: Transform.translate(
                offset: Offset(0, -2 * _elevation_animation.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.border_radius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.lerp(
                          colors.gradient_start.withAlpha((255 * 0.6).round()),
                          colors.gradient_start,
                          _glow_animation.value * 0.5,
                        )!,
                        Color.lerp(
                          colors.gradient_end.withAlpha((255 * 0.6).round()),
                          colors.gradient_end,
                          _glow_animation.value * 0.5,
                        )!,
                      ],
                    ),
                    border: Border.all(
                      color: Color.lerp(
                        colors.border.withAlpha((255 * 0.5).round()),
                        colors.border,
                        _glow_animation.value,
                      )!,
                      width: 1 + (_glow_animation.value * 0.5),
                    ),
                    boxShadow: [
                      // Base shadow
                      BoxShadow(
                        color: Color.lerp(
                          colors.shadow.withAlpha((255 * 0.2).round()),
                          colors.shadow.withAlpha((255 * 0.4).round()),
                          _glow_animation.value,
                        )!,
                        blurRadius: 8 + (12 * _elevation_animation.value),
                        offset: Offset(0, 2 + (4 * _elevation_animation.value)),
                      ),
                      // Glow effect on hover
                      if (_glow_animation.value > 0)
                        BoxShadow(
                          color: colors.gradient_start
                              .withAlpha((255 * 0.3 * _glow_animation.value).round()),
                          blurRadius: 20 * _glow_animation.value,
                          spreadRadius: 2 * _glow_animation.value,
                        ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main icon with subtle rotation on hover
                      Transform.rotate(
                        angle: _icon_rotation_animation.value * math.pi,
                        child: Icon(
                          widget.icon,
                          size: 20,
                          color: Color.lerp(
                            colors.content,
                            colors.content_hovered,
                            _glow_animation.value,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5 + (_glow_animation.value * 0.3),
                          color: Color.lerp(
                            colors.content,
                            colors.content_hovered,
                            _glow_animation.value,
                          ),
                        ),
                      ),
                      if (widget.show_external_icon) ...[
                        const SizedBox(width: 6),
                        // External link icon with slight movement on hover
                        Transform.translate(
                          offset: Offset(
                            2 * _glow_animation.value,
                            -2 * _glow_animation.value,
                          ),
                          child: Icon(
                            Icons.open_in_new_rounded,
                            size: 14,
                            color: Color.lerp(
                              colors.content.withAlpha((255 * 0.7).round()),
                              colors.content_hovered,
                              _glow_animation.value,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
