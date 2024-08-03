import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInController with ChangeNotifier {
  Map? userData;

  login() async {
    var _auth;
    var result = await FacebookAuth.instance.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      final AuthCredential facebookcredentials =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      final userData = await _auth.signInWithCredentials(facebookcredentials);

      notifyListeners();
    }
  }

  // logout
  logout() async {
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }
}
