import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  final String error;
  CustomSnackBar({required this.error});

  SnackBar showSnackBar() {
    return SnackBar(
      content: SizedBox(
        height: 70.0,
        child: Center(
          child: Text(
            error,
            style: GoogleFonts.arsenal(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.pinkAccent,
      duration: const Duration(
        seconds: 4,
      ),
      behavior: SnackBarBehavior.floating,
      width: 300.0,
    );
  }
}
