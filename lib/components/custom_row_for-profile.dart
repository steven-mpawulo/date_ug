import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRowForProfile extends StatelessWidget {
  final String text;
  const CustomRowForProfile({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: GoogleFonts.arsenal(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
