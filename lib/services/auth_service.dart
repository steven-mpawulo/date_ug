import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic error;

  String getUid() => _auth.currentUser!.uid;

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: GoogleFonts.arsenal(color: Colors.white),
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

  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
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

  Future signOut() async {
    await _auth.signOut();
  }
}
