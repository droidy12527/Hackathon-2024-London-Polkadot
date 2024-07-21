import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "success";
  }

  static signUserInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return "Invalid Credentials";
      }
      return e.code;
    }
    return "success";
  }

  static signUserUpWithEmail(String email, String password, String passwordconfiramtion) async {
    if (password.trim() != passwordconfiramtion.trim()) {
      return "Passwords do not match";
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "Invalid Email";
      }
      if (e.code == "weak-password") {
        return "Password should be\nat least 6 letters long.";
      }
      if (e.code == "email-already-exists") {
        return "Account With This Email Already Exists";
      }

      return e.code;
    }
    return "success";
  }

  static signOut() async {
    FirebaseAuth.instance.signOut();
  }

  static resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "success";
  }
}
