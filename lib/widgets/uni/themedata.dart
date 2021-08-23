import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: AppDefaultColors.colorPrimaryBlue,
    switchTheme: SwitchThemeData(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
      (states) => states.contains(MaterialState.disabled)
          ? AppDefaultColors.colorPrimaryGrey
          : AppDefaultColors.colorPrimaryBlue[900],
    )),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        // onSurface: AppDefaultColors.colorPrimaryBlue,
        // backgroundColor: AppDefaultColors.colorPrimaryGrey[50],
        backgroundColor: AppDefaultColors.colorPrimaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        minimumSize: Size(80, 40),
      ),
      // TODO: Change to ButtonStyle() instead of TextButton.styleFrom()
      // style: ButtonStyle(
      //   textStyle: MaterialStateProperty.resolveWith<TextStyle>(
      //       (states) => TextStyle(color: Colors.white)),
      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //     (Set<MaterialState> states) {
      //       if (states.contains(MaterialState.disabled)) {
      //         return AppDefaultColors.colorPrimaryGrey;
      //       } else if (states.contains(MaterialState.pressed)) {
      //         return AppDefaultColors.colorPrimaryBlue[300];
      //       }
      //       return AppDefaultColors.colorPrimaryBlue;
      //     },
      //   ),
      //   shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
      //     (states) => RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(7),
      //     ),
      //   ),
      //   minimumSize: MaterialStateProperty.resolveWith<Size>(
      //     (states) => Size(80, 40),
      //   ),
      // ),
    ),
  );
}
