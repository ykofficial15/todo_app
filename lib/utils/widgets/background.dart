import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color? color1;
  final Color? color2;

  const Background({super.key, required this.child, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1 ?? Colors.blue, color2 ?? Colors.blue],
        ),
      ),
      child: child,
    );
  }
}
