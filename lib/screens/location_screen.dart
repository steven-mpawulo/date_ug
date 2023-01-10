import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/components/custom_text_field.dart';
import 'package:date_ug/screens/add_pictures_screen.dart';
import 'package:date_ug/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  final String uid;
  final String userName;
  final int age;
  final String gender;
  final List interests;
  const LocationScreen(
      {Key? key,
      required this.uid,
      required this.age,
      required this.gender,
      required this.userName,
      required this.interests})
      : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  String location = "";

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
                    "Where Are You? ",
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
                    textFieldText: "Your location",
                    controller: _locationController,
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
                      if (_locationController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(error: "Provide your location")
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
                        setState(() {
                          location = _locationController.text;
                        });

                        Map<String, dynamic> data = {
                          "uid": widget.uid,
                          "userName": widget.userName,
                          "age": widget.age,
                          "gender": widget.gender,
                          "interests": widget.interests,
                          "location": location,
                        };
                        Provider.of<DatabaseService>(context, listen: false)
                            .createUser(widget.uid, data)
                            .then((value) {
                          if (value == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => AddPicturesScreen(
                                      uid: widget.uid,
                                      gender: widget.gender,
                                      name: widget.userName,
                                    )),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                Provider.of<DatabaseService>(context,
                                        listen: false)
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
