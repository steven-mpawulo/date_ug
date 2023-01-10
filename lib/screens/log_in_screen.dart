import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/constants/check_internet_connection.dart';
import 'package:date_ug/screens/discover_screen.dart';
import 'package:date_ug/screens/payment_screen.dart';
import 'package:date_ug/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                    "Enter Your Email and Password to Login ",
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
                    textFieldText: "Email",
                    controller: _email,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: false,
                    hasIcon: false,
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
                    textFieldText: "Password",
                    controller: _password,
                    hasMultiline: false,
                    forPassword: true,
                    forNumber: false,
                    hasIcon: true,
                  ),
                ),
                const SizedBox(
                  height: 140.0,
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
                      if (_email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide an email address")
                                .showSnackBar());
                      } else if (_password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide a password")
                                .showSnackBar());
                      } else if (_email.text.isEmpty &&
                          _password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                                    error: "Provide your email and password")
                                .showSnackBar());
                      } else {
                        print(_email.text);
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
                        Provider.of<AuthService>(context, listen: false)
                            .signIn(_email.text, _password.text)
                            .then((value) async {
                          if (value != null) {
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(value.user.uid)
                                .get()
                                .then((value) {
                              Map<String, dynamic>? data = value.data();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => DiscoverScreen(
                                        uid: data!["uid"],
                                        gender: data["gender"],
                                        name: data["userName"],
                                      )),
                                ),
                              );
                            });
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
                const SizedBox(
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: CustomButton(
                    buttonText: "CREATE ACCOUNT INSTEAD",
                    buttonFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const PaymentScreen()),
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
    );
  }
}
