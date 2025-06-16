import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/services/databasenote_service.dart';
import 'package:todo/services/fireauth_service.dart';
import 'package:todo/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:todo/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:todo/ui/views/home/home_view.dart';
import 'package:todo/ui/views/login/login_view.dart';
import 'package:todo/ui/views/startup/startup_view.dart';

// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FireauthService),
    LazySingleton(classType: DatabasenoteService),

// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
