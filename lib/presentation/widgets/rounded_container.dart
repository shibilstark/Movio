import 'package:flutter/material.dart';

class RoundedContainerWidget extends StatelessWidget {
  const RoundedContainerWidget({
    super.key,
    required this.borderRadius,
    this.decoration,
    this.height,
    this.width,
    this.child,
  });

  final BorderRadius borderRadius;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: width,
        decoration: decoration?.copyWith(
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
