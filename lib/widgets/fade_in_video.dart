import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FadeInVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final ImageProvider placeholder;
  final Duration fade_in_duration;
  final BoxFit fit;

  const FadeInVideo({
    super.key,
    required this.controller,
    required this.placeholder,
    this.fade_in_duration = const Duration(milliseconds: 700),
    this.fit = BoxFit.cover,
  });

  @override
  State<FadeInVideo> createState() => _FadeInVideoState();
}

class _FadeInVideoState extends State<FadeInVideo> with SingleTickerProviderStateMixin {
  late AnimationController _fade_controller;
  bool _has_started_fade = false;

  @override
  void initState() {
    super.initState();

    _fade_controller = AnimationController(
      vsync: this,
      duration: widget.fade_in_duration,
    );

    // Check if controller is already initialized (common when reusing controllers)
    if (widget.controller.value.isInitialized) {
      // Controller already initialized - just ensure muted and start fade
      _start_playback();
    } else {
      // Controller not initialized yet - wait for initialization
      widget.controller.initialize().then((_) {
        if (mounted) {
          _start_playback();
        }
      }).catchError((error) {
        // Handle initialization errors gracefully
        debugPrint('FadeInVideo: Error initializing video: $error');
      });
    }
  }

  void _start_playback() {
    if (_has_started_fade || !mounted) return;
    _has_started_fade = true;

    // Always ensure video is muted - background music handles audio
    widget.controller.setVolume(0);
    _fade_controller.forward();
    // Don't call play() here - the slideshow already manages playback
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final is_ready = widget.controller.value.isInitialized;

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: widget.placeholder,
            fit: widget.fit,
          ),
          if (is_ready)
            FadeTransition(
              opacity: _fade_controller,
              child: FittedBox(
                fit: widget.fit,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: widget.controller.value.size.width,
                  height: widget.controller.value.size.height,
                  child: VideoPlayer(widget.controller),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fade_controller.dispose();
    super.dispose();
  }
}
