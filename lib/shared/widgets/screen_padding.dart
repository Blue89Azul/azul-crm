import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final double horizontal;
  final double vertical;
  final bool safeArea;

  const ScreenPadding({
    super.key,
    required this.child,
    this.enabled = true,
    this.horizontal = 16.0,
    this.vertical = 0,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = enabled
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
            child: child,
          )
        : child;

    return safeArea ? SafeArea(child: content) : content;
  }
}
