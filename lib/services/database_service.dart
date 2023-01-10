import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic error;

  Future createUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection("Users").doc(uid).set(data);
    } on FirebaseException catch (e) {
      print(e.toString());
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
    }
  }

  Future addUserPictures(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection("Users").doc(uid).update(data);
    } on FirebaseException catch (e) {
      print(e.toString());
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
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
}
