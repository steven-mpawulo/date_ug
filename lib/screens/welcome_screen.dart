import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/screens/email_screen.dart';
import 'package:date_ug/screens/log_in_screen.dart';
import 'package:date_ug/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<bool> _onWillPopScope() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "DATE UG",
          hasActions: false,
          hasBackButton: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "Welcome to  Date Ug",
                      style: GoogleFonts.arsenal(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Your soul mate is waiting!",
                      style: GoogleFonts.arsenal(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 300.0,
                child: Image(
                  image: AssetImage("lib/assets/logo_transparent.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  buttonText: "SIGN UP",
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  buttonText: "LOG IN",
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
    );
  }
}
