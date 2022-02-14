import 'package:flutter/material.dart';

Color mainColor = Color(0xff464040);


Map<int, Color> cColor = {
  50: Color.fromRGBO(70, 64, 64, .1),
  100: Color.fromRGBO(70, 64, 64, .2),
  200: Color.fromRGBO(70, 64, 64, .3),
  300: Color.fromRGBO(70, 64, 64, .4),
  400: Color.fromRGBO(70, 64, 64, .5),
  500: Color.fromRGBO(70, 64, 64, .6),
  600: Color.fromRGBO(70, 64, 64, .7),
  700: Color.fromRGBO(70, 64, 64, .8),
  800: Color.fromRGBO(70, 64, 64, .9),
  900: Color.fromRGBO(70, 64, 64, 1),
};

MaterialColor materialMainColor = MaterialColor(0xff464040, cColor);