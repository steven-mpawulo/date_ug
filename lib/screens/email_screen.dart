import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/log_in_screen.dart';
import 'package:date_ug/screens/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_ug/constants/check_internet_connection.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String email = "";
  CheckInternetConnectivity checkInternet = CheckInternetConnectivity();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await checkInternet.checkInternetConnection().then((value) {
      if (value != null) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(error: "No internet connection").showSnackBar());
      }
    });
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPopScope,
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
                      "What's Your Email Address? ",
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
                      textFieldText: "example@example.com",
                      controller: _emailController,
                      hasMultiline: false,
                      forPassword: false,
                      forNumber: false,
                      hasIcon: false,
                    ),
                  ),
                  const SizedBox(
                    height: 260.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                      left: 6.0,
                      right: 6.0,
                    ),
                    child: CustomButton(
                      buttonText: "NEXT",
                      buttonFunction: () {
                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(error: "Provide email address")
                                  .showSnackBar());
                        } else {
                          setState(() {
                            email = _emailController.text;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                                  PasswordScreen(email: email)),
                            ),
                          );
                          _emailController.clear();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                      left: 6.0,
                      right: 6.0,
                    ),
                    child: CustomButton(
                      buttonText: "LOG IN INSTEAD",
                      buttonFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const LogInScreen()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
