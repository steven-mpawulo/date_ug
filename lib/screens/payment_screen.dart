import 'dart:convert';

import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/email_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ade_flutterwave_working_version/core/ade_flutterwave.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          hasActions: false, hasBackButton: true, title: "DATE UG"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Before signing up for Date Ug, a one time fee of 5000UGX is required.",
                  style: GoogleFonts.arsenal(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Kindly provide the required details in order to make the payment.",
                  style: GoogleFonts.arsenal(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Thank you so much and enjoy Date Ug.",
                  style: GoogleFonts.arsenal(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                    textFieldText: "email",
                    controller: _email,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: false,
                    hasIcon: false),
                const SizedBox(height: 8.0),
                CustomTextField(
                    textFieldText: "phone number",
                    controller: _phoneNumber,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: true,
                    hasIcon: false),
                const SizedBox(height: 8.0),
                CustomTextField(
                    textFieldText: "name",
                    controller: _name,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: false,
                    hasIcon: false),
                const SizedBox(height: 8.0),
                CustomTextField(
                    textFieldText: "amount",
                    controller: _amount,
                    hasMultiline: false,
                    forPassword: false,
                    forNumber: true,
                    hasIcon: false),
                const SizedBox(height: 40.0),
                CustomButton(
                  buttonText: "PROCEED TO PAY",
                  buttonFunction: () async {
                    if (_email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(error: "Provide email address")
                              .showSnackBar());
                    } else if (_phoneNumber.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(error: "Provide phone number")
                              .showSnackBar());
                    } else if (_name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(error: "Provide name").showSnackBar());
                    } else if (_amount.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(error: "Provide amount")
                              .showSnackBar());
                    } else if (_amount.text != "5000") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(error: "Amount is not 5000UGX ")
                              .showSnackBar());
                    } else {
                      var data = {
                        'amount': _amount.text,
                        'email': _email.text,
                        'phone': _phoneNumber.text,
                        'name': _name.text,
                        'payment_options':
                            'card, banktransfer, ussd, mobilemoney, mobile_money_uganda',
                        'title': 'Flutterwave payment',
                        'currency': "UGX",
                        'tx_ref':
                            "AdeFlutterwave-${DateTime.now().millisecondsSinceEpoch}",
                        'icon':
                            "https://www.aqskill.com/wp-content/uploads/2020/05/logo-pde.png",
                        'public_key':
                            "",
                        'sk_key':
                            ''
                      };

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdeFlutterWavePay(data),
                        ),
                      ).then((response) {
                        //response is the response from the payment
                        // print(response.body);
                        Map<String, dynamic> data = response;
                        // print(data);
                        print(data['status']);
                        print(data['message']);
                        print(data['data']['status']);
                        if (data['status'] == 'success' &&
                            data['message'] ==
                                'Transaction fetched successfully' &&
                            data['data']['status'] == 'successful') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EmailScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(error: "Transaction failed")
                                  .showSnackBar());
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
