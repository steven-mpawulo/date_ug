import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/biography_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderScreen extends StatefulWidget {
  final String uid;
  final String userName;
  const GenderScreen({Key? key, required this.uid, required this.userName})
      : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  bool isMale = false;
  bool isFemale = false;
  String gender = "";
  int age = 0;
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "DATE UG",
          hasActions: false,
          hasBackButton: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "What's Your Gender? ",
                    style: GoogleFonts.arsenal(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: isMale,
                      onChanged: (value) {
                        setState(() {
                          isFemale = false;
                        });
                        setState(() {
                          isMale = true;
                        });
                        setState(() {
                          gender = "male";
                        });
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "MALE",
                      style: GoogleFonts.arsenal(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: isFemale,
                      onChanged: (value) {
                        setState(() {
                          isMale = false;
                        });
                        setState(() {
                          isFemale = true;
                        });
                        setState(() {
                          gender = "female";
                        });
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "FEMALE",
                      style: GoogleFonts.arsenal(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "How Old Are You?",
                    style: GoogleFonts.arsenal(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomTextField(
                    textFieldText: "Your age",
                    controller: _ageController,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: true,
                    hasIcon: false,
                  ),
                ),
                const SizedBox(height: 140.0),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: CustomButton(
                    buttonText: "NEXT",
                    buttonFunction: () {
                      if (_ageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide your age")
                                .showSnackBar());
                      } else if (_ageController.text.startsWith('-')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Your age cant be negative")
                                .showSnackBar());
                      } else if (int.parse(_ageController.text) < 18) {
                        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                                error:
                                    "Sorry, your too young to join this platform")
                            .showSnackBar());
                      } else {
                        setState(() {
                          age = int.parse(_ageController.text);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => BiographyScreen(
                                  age: age,
                                  gender: gender,
                                  uid: widget.uid,
                                  userName: widget.userName,
                                )),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
