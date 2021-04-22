import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: AppDefaultColors.colorPrimaryBlue,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        // onSurface: AppDefaultColors.colorPrimaryBlue,
        // backgroundColor: AppDefaultColors.colorPrimaryGrey[50],
        backgroundColor: AppDefaultColors.colorPrimaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        minimumSize: Size(80, 40),
      ),
    ),
  );
}
