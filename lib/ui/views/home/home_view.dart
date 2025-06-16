import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/ui/common/app_colors.dart';
import 'package:todo/ui/common/shared_pref_keys.dart';
import 'package:todo/ui/common/shared_pref_utils.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        title: Text(
            'Welcome ${SharedPrefUtils.getString(SharedPrefKeys.userName) ?? 'User'}'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container()),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
