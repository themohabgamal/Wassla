import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontHelper {
  static const String poppinsFontFamily = 'Poppins';

  static TextStyle poppins16Regular({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle poppins18Regular({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle poppins20Regular({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle poppins24Regular({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle poppins16Bold({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle poppins18Bold({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle poppins20Bold({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle poppins24Bold({
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}
