import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/services/fireauth_service.dart';
import 'package:todo/ui/common/common.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthService = locator<FireauthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  Future<void> signInWithGmail() async {
    try {
      await _firebaseAuthService.signInWithGoogle();
      Fluttertoast.showToast(
        msg:
            "Successfully logged in with Gmail as ${_firebaseAuthService.currentUser?.email}",
      );
      await _saveAuthDataToSharedPref(_firebaseAuthService.currentUser);
    } catch (e) {
      debugPrint(e.toString());

      _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    }
  }

  _gotoHomeView() {
    _navigationService.replaceWithHomeView();
  }

  _saveAuthDataToSharedPref(User? user) async {
    String? token = await user?.getIdToken();
    if (user != null && token != null) {
      SharedPrefUtils.setString(
        SharedPrefKeys.userEmail,
        user.email!,
      );
      SharedPrefUtils.setBool(
        SharedPrefKeys.isLoggedIn,
        true,
      );
      SharedPrefUtils.setString(
        SharedPrefKeys.userId,
        user.uid,
      );
      SharedPrefUtils.setString(
        SharedPrefKeys.userName,
        user.displayName!,
      );

      SharedPrefUtils.setString(
        SharedPrefKeys.token,
        token ?? "",
      );
      _gotoHomeView();
    } else {
      Fluttertoast.showToast(
        msg: "User is null, cannot save auth data",
      );
    }
  }
}
