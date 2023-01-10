import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/gender_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNameScreen extends StatefulWidget {
  final String uid;
  const UserNameScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();
  String userName = "";
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
            title: "DATE UG", hasActions: false, hasBackButton: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "What's Your UserName? ",
                    style: GoogleFonts.arsenal(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: CustomTextField(
                    textFieldText: "UserName",
                    controller: _userNameController,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: false,
                    hasIcon: false,
                  ),
                ),
                const SizedBox(height: 280.0),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: CustomButton(
                    buttonText: "NEXT",
                    buttonFunction: () {
                      if (_userNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide your user name")
                                .showSnackBar());
                      } else {
                        setState(() {
                          userName = _userNameController.text;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => GenderScreen(
                                  uid: widget.uid,
                                  userName: userName,
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
