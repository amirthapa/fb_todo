import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/ui/common/common.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login for Todo App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            AppButton(
                label: loginWithGmail,
                onPressed: () {
                  viewModel.signInWithGmail();
                }),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
