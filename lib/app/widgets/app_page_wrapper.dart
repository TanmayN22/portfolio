import 'package:flutter/material.dart';

class AppPageWrapper extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;

  const AppPageWrapper({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.backgroundColor = Colors.white,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow:
              boxShadow ??
              [
                const BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}
