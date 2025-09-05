import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/widgets/background.dart';

class UniversalBackground extends StatefulWidget {
  final Widget child;
  final bool safeArea; // Optional parameter
  final Widget? floatingWidget;

  const UniversalBackground({
    super.key,
    required this.child,
    this.safeArea = true, // Default to true
    this.floatingWidget,
  });

  @override
  State<UniversalBackground> createState() => _UniversalBackgroundState();
}

class _UniversalBackgroundState extends State<UniversalBackground>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(6, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations = List.generate(6, (index) {
      final beginOffset = index < 3 ? const Offset(-1, 0) : const Offset(1, 0);
      return Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
        CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
      );
    });

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        // ✅ Check if the widget is still mounted before calling forward()
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildAnimatedTriangle({
    required Animation<Offset> animation,
    required double angle,
    required double height,
    required double width,
    double? left,
    double? top,
    double? right,
    required Color color,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      child: SlideTransition(
        position: animation,
        child: Transform.rotate(
          angle: angle,
          child: SvgPicture.asset(
            'assets/triangle.svg',
            height: height,
            width: width,
            // ignore: deprecated_member_use
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: widget.floatingWidget ?? SizedBox.shrink(),
      body: Stack(
        children: [
          // Gradient + triangle animation layer
          Background(
            child: Stack(
              children: [
                // Left triangles
                buildAnimatedTriangle(
                  animation: _animations[0],
                  angle: 90 * math.pi / 180,
                  height: 80,
                  width: 80,
                  left: -10,
                  top: null,
                  right: null,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                buildAnimatedTriangle(
                  animation: _animations[1],
                  angle: 90 * math.pi / 180,
                  height: 100,
                  width: 100,
                  left: -20,
                  top: 5,
                  right: null,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
                buildAnimatedTriangle(
                  animation: _animations[2],
                  angle: 90 * math.pi / 180,
                  height: 120,
                  width: 120,
                  left: -30,
                  top: 10,
                  right: null,
                  color: Colors.white.withValues(alpha: 0.03),
                ),

                // Right triangles
                buildAnimatedTriangle(
                  animation: _animations[3],
                  angle: -math.pi / 2,
                  height: 150,
                  width: 150,
                  left: null,
                  top: 15,
                  right: -20,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                buildAnimatedTriangle(
                  animation: _animations[4],
                  angle: -math.pi / 2,
                  height: 170,
                  width: 170,
                  left: null,
                  top: 5,
                  right: -20,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
                buildAnimatedTriangle(
                  animation: _animations[5],
                  angle: -math.pi / 2,
                  height: 190,
                  width: 190,
                  left: null,
                  top: -5,
                  right: -20,
                  color: Colors.white.withValues(alpha: 0.03),
                ),
              ],
            ),
          ),

          // Foreground content (page)
          widget.safeArea
              ? SafeArea(bottom: false, child: widget.child)
              : widget.child,
        ],
      ),
    );
  }
}
