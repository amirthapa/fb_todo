import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/services/fireauth_service.dart';
import 'package:todo/ui/common/common.dart';
import 'package:todo/ui/common/pie_cred_const.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthService = locator<FireauthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  Future<String?> generatePieSocketJwt(User? user) async {
    // Ensure Firebase is initialized
    log(user?.getIdToken().toString() ?? "");
    if (user == null) {
      return null;
    }

    // 👇 Prepare payload for PieSocket
    final payload = {
      "user_id": user.uid,
      "sub": PieCredConst.roomId,
      "iat": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "name": user.displayName ?? "Guest",
      "email": user.email ?? "",
    };

    try {
      final jwt = JWT(payload);
      final token = jwt.sign(SecretKey(PieCredConst.secretKey),
          algorithm: JWTAlgorithm.HS256);
      log(token.toString());
      return token;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

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

      SharedPrefUtils.setString(
        SharedPrefKeys.userId,
        user.uid,
      );
      SharedPrefUtils.setString(
        SharedPrefKeys.userName,
        user.displayName!,
      );

      String? token = await generatePieSocketJwt(user);
      if (token != null) {
        await SharedPrefUtils.setString(
          SharedPrefKeys.token,
          token,
        );
        await SharedPrefUtils.setBool(
          SharedPrefKeys.isLoggedIn,
          true,
        );
        _gotoHomeView();
      } else {
        Fluttertoast.showToast(
          msg: "Unable to generate PieSocket JWT",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "User is null, cannot save auth data",
      );
    }
  }
}
