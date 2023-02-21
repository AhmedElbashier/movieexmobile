import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    hintColor: Colors.white,
    cardColor: Colors.grey[900],
    hoverColor: Colors.grey[800],
    accentColor: Colors.red,
    fontFamily: 'Avenir',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.grey.shade900,
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    cardColor: Colors.grey[200],
    hoverColor: Colors.grey[500],
    hintColor: Colors.black,
    accentColor: Colors.red,
    fontFamily: 'Avenir',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
  );
}
