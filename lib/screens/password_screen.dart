import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/user_name_screen.dart';
import 'package:date_ug/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  const PasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String uid = "";
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
                    "What's Your Password? ",
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
                    textFieldText: "Password",
                    controller: _passwordController,
                    hasMultiline: false,
                    forPassword: true,
                    forNumber: false,
                    hasIcon: true,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: CustomTextField(
                    textFieldText: "Confirm Password",
                    controller: _confirmPasswordController,
                    hasMultiline: false,
                    forPassword: true,
                    forNumber: false,
                    hasIcon: true,
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
                      if (_passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide password")
                                .showSnackBar());
                      } else if (_confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Confirm password")
                                .showSnackBar());
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Passwords dont match")
                                .showSnackBar());
                      } else {
                        showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Center(
                                  child: SizedBox(
                                    height: 80.0,
                                    width: MediaQuery.of(context).size.width -
                                        40.0,
                                    child: Column(
                                      children: [
                                        const SpinKitWave(
                                          color: Colors.black,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "Processing...",
                                          style: GoogleFonts.arsenal(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });

                        String email = widget.email;
                        String password = _passwordController.text;
                        Provider.of<AuthService>(context, listen: false)
                            .signUp(email, password)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              uid = value.user.uid;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    UserNameScreen(uid: uid)),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                Provider.of<AuthService>(context, listen: false)
                                    .error);
                            Navigator.pop(context);
                          }
                        });
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
