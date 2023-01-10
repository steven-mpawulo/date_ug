import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final dynamic textFunction;
  final String text;
  const CustomTextButton(
      {Key? key, required this.textFunction, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: textFunction,
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Color.fromARGB(255, 1, 36, 71)],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.arsenal(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
