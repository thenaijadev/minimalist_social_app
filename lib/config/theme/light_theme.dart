import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Multi",
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      background: Colors.grey.shade300,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade500,
      inversePrimary: Colors.grey.shade800,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.grey[800], displayColor: Colors.black),
    // appBarTheme: const AppBarTheme(
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //     centerTitle: true,
    //     iconTheme: IconThemeData(color: Colors.grey),
    //     titleTextStyle: TextStyle(color: Colors.grey, fontSize: 18)),
  );
}
