import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/ui/common/app_button.dart';
import 'package:todo/ui/common/app_strings.dart';
import 'package:todo/ui/common/ui_helpers.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login for Todo App',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          verticalSpaceMedium,
          AppButton(label: loginWithGmail, onPressed: () {})
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
