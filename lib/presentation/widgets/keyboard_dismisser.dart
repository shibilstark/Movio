import 'package:flutter/material.dart';

class KeyBoardDismisser extends StatelessWidget {
  const KeyBoardDismisser(
      {Key? key, required this.focusNode, required this.child})
      : super(key: key);
  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (value) {
        if (focusNode.hasFocus || focusNode.hasPrimaryFocus) {
          focusNode.unfocus();
        }
      },
      child: child,
    );
  }
}
