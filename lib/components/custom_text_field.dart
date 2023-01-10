import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String textFieldText;
  final TextEditingController controller;
  final bool hasMultiline;
  bool forPassword;
  final bool forNumber;
  final bool hasIcon;
  CustomTextField(
      {Key? key,
      required this.textFieldText,
      required this.controller,
      required this.hasMultiline,
      required this.forPassword,
      required this.forNumber,
      required this.hasIcon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.forPassword ? true : false,
      maxLines: widget.hasMultiline ? null : 1,
      keyboardType:
          widget.forNumber ? TextInputType.number : TextInputType.name,
      style: GoogleFonts.arsenal(),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        suffixIcon: widget.hasIcon
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.forPassword == false) {
                      widget.forPassword = true;
                    } else {
                      widget.forPassword = false;
                    }
                  });
                },
                child: widget.forPassword
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ))
            : const SizedBox(),
        hintText: widget.textFieldText,
        hintStyle: GoogleFonts.arsenal(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
