import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideOnScroll extends StatefulWidget {
  const HideOnScroll(
      {super.key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.easeIn,
      this.visibleHeight = kBottomNavigationBarHeight});

  final Widget child;
  final Duration duration;
  final ScrollController controller;
  final Curve curve;
  final double visibleHeight;

  @override
  State<HideOnScroll> createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll> {
  bool _isVisible = true;

  @override
  void initState() {
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final direction = widget.controller.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      _hide();
    } else if (direction == ScrollDirection.forward) {
      _show();
    }
  }

  void _show() {
    if (!_isVisible) setState(() => _isVisible = true);
  }

  void _hide() {
    if (_isVisible) setState(() => _isVisible = false);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: widget.curve,
      height: _isVisible ? widget.visibleHeight : 0,
      duration: widget.duration,
      child: Wrap(children: [widget.child]),
    );
  }
}
