import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeCustom = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: const Color.fromARGB(255, 27, 27, 27),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.white,
    tertiary: const Color.fromARGB(255, 255, 111, 0),
    secondary: Colors.grey,
    surface: const Color.fromARGB(255, 27, 27, 27),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.getFont('Outfit',
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.getFont('Outfit',
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: GoogleFonts.getFont('Outfit',
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: GoogleFonts.getFont('Outfit',
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: GoogleFonts.getFont('Outfit',
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: GoogleFonts.getFont('Outfit',
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: GoogleFonts.getFont('Outfit', fontSize: 16, color: Colors.white),
    bodyMedium:
        GoogleFonts.getFont('Outfit', fontSize: 14, color: Colors.white),
    bodySmall: GoogleFonts.getFont('Outfit',
        fontSize: 12, color: Colors.white.withOpacity(0.4)),
  ),
);
