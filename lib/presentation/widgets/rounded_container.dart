import 'package:flutter/material.dart';

class RoundedContainerWidget extends StatelessWidget {
  const RoundedContainerWidget({
    super.key,
    required this.borderRadius,
    this.decoration,
    this.height,
    this.width,
    this.child,
    this.padding,
  });

  final BorderRadius borderRadius;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        padding: padding,
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
