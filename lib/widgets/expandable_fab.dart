import 'package:flutter/material.dart';
import 'dart:math' as math;

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initial_open,
    required this.distance,
    required this.children,
    required this.background_color,
    required this.main_fab_icon,
    required this.main_fab_background_color,
  });

  final bool? initial_open;
  final double distance;
  final List<Widget> children;
  final Color background_color;
  final IconData main_fab_icon;
  final Color main_fab_background_color;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expand_animation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initial_open ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expand_animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _build_tap_to_close_fab(),
          ..._build_expanding_action_buttons(),
          _build_tap_to_open_fab(),
        ],
      ),
    );
  }

  Widget _build_tap_to_close_fab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _build_expanding_action_buttons() {
    var children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angle_in_degrees = 0.0;
        i < count;
        i++, angle_in_degrees += step) {
      children.add(
        _ExpandingActionButton(
          direction_in_degrees: angle_in_degrees,
          max_distance: widget.distance,
          progress: _expand_animation,
          child: widget.children[i],
        ),
      );
    }
    children = children.reversed.toList();
    return children;
  }

  Widget _build_tap_to_open_fab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: widget.background_color,
            onPressed: _toggle,
            child: Icon(
              widget.main_fab_icon,
              color: widget.main_fab_background_color,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.direction_in_degrees,
    required this.max_distance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double direction_in_degrees;
  final double max_distance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          direction_in_degrees * (math.pi / 180.0),
          progress.value * max_distance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.on_pressed,
    required this.icon_color,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? on_pressed;
  final Widget icon;
  final Color icon_color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: icon_color,
      elevation: 4.0,
      child: IconButton(
        onPressed: on_pressed,
        icon: icon,
      ),
    );
  }
}
