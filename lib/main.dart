import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.bottomsheets.dart';
import 'package:todo/app/app.dialogs.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/ui/common/shared_pref_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  setupDialogUi();
  setupBottomSheetUi();
  await SharedPrefUtils.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
