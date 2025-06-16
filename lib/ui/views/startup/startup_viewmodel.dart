import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/ui/common/common.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    bool isLoggedIn =
        SharedPrefUtils.getBool(SharedPrefKeys.isLoggedIn) ?? false;
    isLoggedIn
        ? _navigationService.replaceWithHomeView()
        : _navigationService.replaceWithLoginView();
  }
}
