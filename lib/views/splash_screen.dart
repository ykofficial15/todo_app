import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/utils/themes/color.dart';
import 'package:todo_app/utils/widgets/animated_background.dart';
import 'package:todo_app/views/todo_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return UniversalBackground(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department,
              size: 50,
              color: AppColor.whiteColor,
            ),
            Text(
              'Todo App',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColor.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
