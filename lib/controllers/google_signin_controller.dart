import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  // object
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  // function for login
  login() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    // call
    notifyListeners();
  }

  // function to logout
  logout() async {
    try {
      // sign out the user
      await _googleSignIn.signOut();

      // clear the googleSignInAccount value
      googleSignInAccount = null;

      // notify listeners of the change
      notifyListeners();
    } catch (error) {
      // handle any errors that occurred during the sign-out process
      print('Error signing out: $error');
    }
  }
}
