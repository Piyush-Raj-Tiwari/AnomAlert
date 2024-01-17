import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData().copyWith(
      inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFFF7F8F9),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFE8ECF4),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E1E1E),
          fixedSize: const Size(double.maxFinite, 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1E1E1E),
              fixedSize: const Size(double.maxFinite, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ))),
      textTheme: TextTheme(
          titleLarge:
              GoogleFonts.urbanist(fontSize: 28, color: Color(0xFF1E1E1E)),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E1E1E)));
}
