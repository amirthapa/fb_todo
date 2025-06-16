import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/services/fireauth_service.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthService = locator<FireauthService>();
  final _dialogService = locator<DialogService>();
  UserCredential? _user;
  UserCredential? get user => _user;

  Future<void> signInWithGmail() async {
    try {
      _user = await _firebaseAuthService.signInWithGoogle();
      String? token = await _firebaseAuthService.currentUser?.getIdToken();
      if (token != null) {
        debugPrint(_user!.user!.email);
        debugPrint(token);
        Fluttertoast.showToast(
            msg: "Successfully logged in with Gmail as ${_user!.user!.email}");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }
}
