import 'package:date_ug/components/custom_app_bar.dart';
import 'package:date_ug/components/custom_button.dart';
import 'package:date_ug/components/custom_snack_bar.dart';
import 'package:date_ug/screens/discover_screen.dart';
import 'package:date_ug/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';

class AddPicturesScreen extends StatefulWidget {
  final String uid;
  final String gender;
  final String name;
  const AddPicturesScreen(
      {Key? key, required this.uid, required this.gender, required this.name})
      : super(key: key);

  @override
  State<AddPicturesScreen> createState() => _AddPicturesScreenState();
}

class _AddPicturesScreenState extends State<AddPicturesScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> images = [];
  String imagePath = "";
  bool hasImage = false;
  late File image;
  String imagePath1 = "";
  late File image1;
  bool hasImage1 = false;
  String imagePath2 = "";
  late File image2;
  bool hasImage2 = false;
  List<String> photoUrlList = [];
  Future pickImage() async {
    try {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      } else {
        setState(() {
          imagePath = image.path;
        });
        return imagePath;
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<List<String>> uploadFiles(List<File> photo) async {
    var photoUrls = await Future.wait(photo.map((photo) => uploadFile(photo)));
    return photoUrls;
  }

  Future<String> uploadFile(
    File photo,
  ) async {
    dynamic storageReference =
        FirebaseStorage.instance.ref().child('images/${photo.path}');
    storageReference.putFile(photo);
    dynamic downloadUrl = await storageReference.getDownloadURL();

    return downloadUrl;
  }

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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Add Your Favorite Picture",
                    style: GoogleFonts.arsenal(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage().then((value) {
                            setState(() {
                              image = File(value);
                            });
                            if (value.toString().isNotEmpty) {
                              setState(() {
                                hasImage = true;
                              });
                              setState(() {
                                images.add(image);
                              });
                            }
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60.0,
                          child: ClipOval(
                            child: hasImage
                                ? Image.file(
                                    height: 120.0,
                                    width: 120.0,
                                    fit: BoxFit.cover,
                                    image,
                                  )
                                : const Icon(Icons.add, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                left: 6.0,
                right: 6.0,
              ),
              child: CustomButton(
                buttonText: "UPLOAD Pictures",
                buttonFunction: () {
                  uploadFiles(images).then((value) {
                    setState(() {
                      photoUrlList = value;
                    });
                  });
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 6.0,
                right: 6.0,
              ),
              child: CustomButton(
                buttonText: "NEXT",
                buttonFunction: () {
                  print(photoUrlList);
                  Map<String, dynamic> data = {"photoUrlList": photoUrlList};
                  print(data);
                  if (photoUrlList.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(error: "Upload your pictures")
                            .showSnackBar());
                  } else {
                    Provider.of<DatabaseService>(context, listen: false)
                        .addUserPictures(widget.uid, data)
                        .then((value) {
                      print("Success");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => DiscoverScreen(
                                gender: widget.gender,
                                uid: widget.uid,
                                name: widget.name,
                              )),
                        ),
                      );
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
