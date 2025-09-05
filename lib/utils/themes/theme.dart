import 'package:flutter/material.dart';
import 'package:todo_app/utils/themes/color.dart';

final theme = ThemeData(
  splashColor: AppColor.primary.withValues(alpha: 0.1),
  highlightColor: AppColor.primary.withValues(alpha: 0.1),
  primaryColor: Colors.blue,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColor.primary,
    selectionColor: AppColor.primary.withValues(alpha: 0.2),
    selectionHandleColor: AppColor.primary,
  ),
);
