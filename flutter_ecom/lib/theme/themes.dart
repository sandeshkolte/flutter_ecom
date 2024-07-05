import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: darkBluishColor,
      cardColor: Colors.white,
      canvasColor: creamColor,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: darkBluishColor),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(darkBluishColor))),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily);

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      cardColor: const Color.fromRGBO(27, 28, 30, 1.0),
      canvasColor: const Color(0xff111111),
      primaryColor: Colors.white,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: lightBluishColor),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(lightBluishColor))),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily);

//Colors
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkcreamColor = Vx.gray900;
  static Color darkBluishColor = const Color(0xff403b58);
  static Color lightBluishColor = Vx.purple700;
}
