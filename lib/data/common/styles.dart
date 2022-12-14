import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appName = 'ResTru';
const Color primaryColor = Color.fromARGB(255, 226, 197, 197);
const Color secondaryColor = Color.fromARGB(255, 77, 77, 78);
const Color primaryDarkColor = Color.fromARGB(255, 77, 77, 78);
const Color homeColor = Color.fromARGB(255, 106, 106, 148);
const Color homeSelectedColor = Color.fromARGB(255, 90, 90, 124);
const Color baseDarkColor = Color.fromARGB(255, 116, 116, 126);
const Color secondaryDarkColor = Color.fromARGB(255, 122, 122, 122);
const Color listColor = Color.fromARGB(255, 231, 217, 217);
const Color listDarkColor = Color.fromARGB(255, 104, 103, 103);
const Color baseColor = Color.fromARGB(255, 247, 240, 240);
const Color menuHeaderColor = Color.fromARGB(255, 194, 180, 180);
const Color searchHeaderColor = Color.fromARGB(255, 255, 251, 251);
const Color menuColor = Color.fromARGB(255, 129, 114, 114);
const Color ratingColor = Color.fromARGB(255, 255, 123, 0);
const Color locationColor = Colors.blueGrey;
const Color dividerColor = Colors.black26;
const Color backColor = Colors.red;
const Color categoryColor = Color.fromARGB(255, 235, 119, 11);
const Color reviewColor = Color.fromARGB(255, 255, 196, 2);
const Color shadowColor = Colors.grey;
const Color borderColor = Colors.grey;
const Color priceColor = Colors.green;
const Color favoriteColor = Colors.red;

final TextTheme resTruTheme = TextTheme(
  headline1: GoogleFonts.merriweather(
      fontSize: 90, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.merriweather(
      fontSize: 55, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.merriweather(
      fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.merriweather(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.merriweather(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.merriweather(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

final TextTheme resTruDarkTheme = TextTheme(
  headline1: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 90, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 55, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.merriweather(
      fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.merriweather(
    color: Colors.white,
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.libreFranklin(
    color: Colors.white,
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
    color: Colors.white,
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
    color: Colors.white,
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
    color: Colors.white,
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
