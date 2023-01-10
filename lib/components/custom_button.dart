import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final dynamic buttonFunction;
  final String buttonText;
  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.blueGrey],
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        height: 60.0,
        onPressed: buttonFunction,
        child: Text(
          buttonText,
          style: GoogleFonts.arsenal(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
