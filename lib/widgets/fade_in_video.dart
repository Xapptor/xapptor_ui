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

  @override
  void initState() {
    super.initState();

    _fade_controller = AnimationController(
      vsync: this,
      duration: widget.fade_in_duration,
    );

    widget.controller.initialize().then((_) async {
      if (mounted) {
        // Always ensure video is muted before playing - background music handles audio
        await widget.controller.setVolume(0);
        _fade_controller.forward();
        widget.controller.play();
        setState(() {});
      }
    });
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
