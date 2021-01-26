import 'package:flutter/material.dart';


class AppDefaultColors {
  static Map<int, Color> swatchPrimaryBlue = {
    50: Color.fromRGBO(7, 123, 173, .1),
    100: Color.fromRGBO(7, 123, 173, .2),
    200: Color.fromRGBO(7, 123, 173, .3),
    300: Color.fromRGBO(7, 123, 173, .4),
    400: Color.fromRGBO(7, 123, 173, .5),
    500: Color.fromRGBO(7, 123, 173, .6),
    600: Color.fromRGBO(7, 123, 173, .7),
    700: Color.fromRGBO(7, 123, 173, .8),
    800: Color.fromRGBO(7, 123, 173, .9),
    900: Color.fromRGBO(7, 123, 173, 1),
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


  static MaterialColor colorPrimaryRed = MaterialColor(0xFFf21d0f, swatchPrimaryRed);
  static MaterialColor colorPrimaryBlue = MaterialColor(0xFF077bad, swatchPrimaryBlue);
}