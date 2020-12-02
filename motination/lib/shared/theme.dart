import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = new ThemeData();

getTheme(){
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: blue,
    //fontFamily: GoogleFonts.spartan().toString(),
  textTheme: TextTheme(
      headline1: GoogleFonts.spartan(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600)),
      headline2: GoogleFonts.spartan(
                textStyle: TextStyle(
                    color: bgColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600)),
      headline3: GoogleFonts.spartan(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.w600)),
      headline4: GoogleFonts.spartan(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
      headline5: GoogleFonts.spartan(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400)),
      bodyText1: GoogleFonts.spartan(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w400)),
      bodyText2: GoogleFonts.spartan(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
      
    ),
  );
}