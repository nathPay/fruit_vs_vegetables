import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  colorScheme: ColorScheme(
    // ## Primary ##
    primary: Color.fromARGB(255, 137, 226, 25),
    primaryVariant: Color.fromARGB(255, 97, 186, 0),
    onPrimary: Colors.white,

    // ## Secondary ##
    secondary: Colors.orange[300]!,
    secondaryVariant: Color.fromARGB(255, 185, 185, 185),
    onSecondary: Colors.black,

    // ## Background ## 
    background: Colors.brown[100]!,
    onBackground: Color.fromARGB(255, 112, 108, 112),

    // ## Surface ##
    surface: Colors.white,
    onSurface: Color.fromARGB(255, 185, 185, 185),
    
    brightness: Brightness.light,
    
    onError: Colors.white,
    error: Color.fromARGB(255, 220, 80, 80),
  ),
);
