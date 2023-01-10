import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BiographyScreen extends StatefulWidget {
  final String uid;
  final String userName;
  final int age;
  final String gender;
  const BiographyScreen({
    Key? key,
    required this.uid,
    required this.userName,
    required this.age,
    required this.gender,
  }) : super(key: key);

  @override
  State<BiographyScreen> createState() => _BiographyScreenState();
}

class _BiographyScreenState extends State<BiographyScreen> {
  List<String> interests = [];
  bool isMusic = false;
  bool isSport = false;
  bool isMovies = false;
  bool isPets = false;
  bool isFashion = false;
  bool isDancing = false;
  bool isCooking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "DATE UG",
        hasActions: false,
        hasBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "What Do You Like? ",
                style: GoogleFonts.arsenal(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Sports',
                      style: GoogleFonts.arsenal(
                        color: isSport ? Colors.white : Colors.black,
                      ),
                    ),
                    avatar: isSport
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                    selected: isSport,
                    selectedColor: Colors.red,
                    onSelected: (value) {
                      setState(() {
                        isSport = value;
                      });

                      if (isSport == true) {
                        if (interests.contains("sports")) {
                        } else {
                          interests.add("sports");
                        }
                      } else {
                        if (interests.contains("sports")) {
                          interests.remove("sports");
                        } else {}
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ChoiceChip(
                      label: Text(
                        'Music',
                        style: GoogleFonts.arsenal(
                          color: isMusic ? Colors.white : Colors.black,
                        ),
                      ),
                      avatar: isMusic
                          ? const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : const SizedBox(),
                      selected: isMusic,
                      selectedColor: Colors.red,
                      onSelected: (value) {
                        setState(() {
                          isMusic = value;
                        });

                        if (isSport == true) {
                          if (interests.contains("music")) {
                          } else {
                            interests.add("music");
                          }
                        } else {
                          if (interests.contains("music")) {
                            interests.remove("music");
                          } else {}
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Movies',
                      style: GoogleFonts.arsenal(
                        color: isMovies ? Colors.white : Colors.black,
                      ),
                    ),
                    avatar: isMovies
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                    selected: isMovies,
                    selectedColor: Colors.red,
                    onSelected: (value) {
                      setState(() {
                        isMovies = value;
                      });

                      if (isMovies == true) {
                        if (interests.contains("movies")) {
                        } else {
                          interests.add("movies");
                        }
                      } else {
                        if (interests.contains("movies")) {
                          interests.remove("movies");
                        } else {}
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      'Pets',
                      style: GoogleFonts.arsenal(
                        color: isPets ? Colors.white : Colors.black,
                      ),
                    ),
                    avatar: isPets
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                    selected: isPets,
                    selectedColor: Colors.red,
                    onSelected: (value) {
                      setState(() {
                        isPets = value;
                      });

                      if (isPets == true) {
                        if (interests.contains("pets")) {
                        } else {
                          interests.add("pets");
                        }
                      } else {
                        if (interests.contains("pets")) {
                          interests.remove("pets");
                        } else {}
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Fashion',
                      style: GoogleFonts.arsenal(
                        color: isFashion ? Colors.white : Colors.black,
                      ),
                    ),
                    avatar: isFashion
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                    selected: isFashion,
                    selectedColor: Colors.red,
                    onSelected: (value) {
                      setState(() {
                        isFashion = value;
                      });

                      if (isFashion == true) {
                        if (interests.contains("fashion")) {
                        } else {
                          interests.add("fashion");
                        }
                      } else {
                        if (interests.contains("fashion")) {
                          interests.remove("fashion");
                        } else {}
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      'Cooking',
                      style: GoogleFonts.arsenal(
                        color: isCooking ? Colors.white : Colors.black,
                      ),
                    ),
                    avatar: isCooking
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox(),
                    selected: isCooking,
                    selectedColor: Colors.red,
                    onSelected: (value) {
                      setState(() {
                        isCooking = value;
                      });

                      if (isPets == true) {
                        if (interests.contains("cooking")) {
                        } else {
                          interests.add("cooking");
                        }
                      } else {
                        if (interests.contains("cooking")) {
                          interests.remove("cooking");
                        } else {}
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  label: Text(
                    'Dacing',
                    style: GoogleFonts.arsenal(
                      color: isDancing ? Colors.white : Colors.black,
                    ),
                  ),
                  avatar: isDancing
                      ? const Icon(
                          Icons.check,
                          color: Colors.black,
                        )
                      : const SizedBox(),
                  selected: isDancing,
                  selectedColor: Colors.red,
                  onSelected: (value) {
                    setState(() {
                      isDancing = value;
                    });

                    if (isDancing == true) {
                      if (interests.contains("dancing")) {
                      } else {
                        interests.add("dancing");
                      }
                    } else {
                      if (interests.contains("dancing")) {
                        interests.remove("dancing");
                      } else {}
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 180.0),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                left: 6.0,
                right: 6.0,
              ),
              child: CustomButton(
                buttonText: "NEXT",
                buttonFunction: () {
                  if (interests.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(error: "Choose an interest")
                            .showSnackBar());
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => LocationScreen(
                            uid: widget.uid,
                            age: widget.age,
                            gender: widget.gender,
                            userName: widget.userName,
                            interests: interests)),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
