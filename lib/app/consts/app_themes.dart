import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // light
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      accentColor: AppColors.brownRed,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brown,
      ),
      textTheme: GoogleFonts.openSansCondensedTextTheme(
        Theme.of(context).textTheme,
      ),
      textButtonTheme: TextButtonThemeData(
        // buttonColor: AppColors.lightPurple,
        // textTheme: ButtonTextTheme.normal,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.lightPurple),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
      ),
    );
  }

  // dark
}
