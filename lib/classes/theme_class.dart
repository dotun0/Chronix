import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: const Color.fromARGB(255, 207, 207, 207),
    secondary: Colors.grey.shade600,
    tertiary: Colors.black.withOpacity(0.7)
  ),
);
ThemeData darkMode = ThemeData(brightness: Brightness.dark,
colorScheme: ColorScheme.dark(
  surface: const Color.fromARGB(255, 44, 44, 44).withOpacity(0.7),
  primary: const Color.fromARGB(255, 126, 125, 125).withOpacity(0.5),
  secondary:const Color.fromARGB(255, 107, 106, 106) ,
  tertiary: Colors.white.withOpacity(0.7)
)
);
