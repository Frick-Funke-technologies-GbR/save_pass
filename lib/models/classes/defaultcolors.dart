

import 'package:flutter/material.dart';

class AppDefaultColors {
  static Map<int, Color> swatchPrimaryBlue = {
    50: Color.fromRGBO(38, 151, 240, .1),
    100: Color.fromRGBO(38, 151, 240, .2),
    200: Color.fromRGBO(38, 151, 240, .3),
    300: Color.fromRGBO(38, 151, 240, .4),
    400: Color.fromRGBO(38, 151, 240, .5),
    500: Color.fromRGBO(38, 151, 240, .6),
    600: Color.fromRGBO(38, 151, 240, .7),
    700: Color.fromRGBO(38, 151, 240, .8),
    800: Color.fromRGBO(38, 151, 240, .9),
    900: Color.fromRGBO(38, 151, 240, 1),
  };
  static Map<int, Color> swatchPrimaryRed = {
    50: Color.fromRGBO(242, 29, 15, .1),
    100: Color.fromRGBO(242, 29, 15, .2),
    200: Color.fromRGBO(242, 29, 15, .3),
    300: Color.fromRGBO(242, 29, 15, .4),
    400: Color.fromRGBO(242, 29, 15, .5),
    500: Color.fromRGBO(242, 29, 15, .6),
    600: Color.fromRGBO(242, 29, 15, .7),
    700: Color.fromRGBO(242, 29, 15, .8),
    800: Color.fromRGBO(242, 29, 15, .9),
    900: Color.fromRGBO(242, 29, 15, 1),
  };
  static Map<int, Color> swatchPrimaryGrey = {
    50: Color.fromRGBO(158, 159, 160, .1),
    100: Color.fromRGBO(158, 159, 160, .2),
    200: Color.fromRGBO(158, 159, 160, .3),
    300: Color.fromRGBO(158, 159, 160, .4),
    400: Color.fromRGBO(158, 159, 160, .5),
    500: Color.fromRGBO(158, 159, 160, .6),
    600: Color.fromRGBO(158, 159, 160, .7),
    700: Color.fromRGBO(158, 159, 160, .8),
    800: Color.fromRGBO(158, 159, 160, .9),
    900: Color.fromRGBO(158, 159, 160, 1),
  };
  static Map<int, Color> swatchToplabelGrey = {
    500: Color.fromRGBO(242, 244, 245, .5)
  };

  static MaterialColor colorPrimaryBlue =
      MaterialColor(0xFF2697f0, swatchPrimaryBlue);
  static MaterialColor colorPrimaryRed =
      MaterialColor(0xFFf21d0f, swatchPrimaryRed);
  static MaterialColor colorPrimaryGrey =
      MaterialColor(0xFF9e9fa0, swatchPrimaryGrey);
  static MaterialColor colorToplabelGrey = MaterialColor(0xFFf2f4f5, swatchToplabelGrey);
}
