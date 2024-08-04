import 'package:aknan_user_app/helpers/notification_helper.dart';
import 'package:aknan_user_app/widgets/screen_utile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'config/app.dart';
import 'firebase_options.dart';
 import 'helpers/cache_helper.dart';
 import 'package:chucker_flutter/chucker_flutter.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helpers/app_bloc_observer.dart';
import 'injection_container.dart';
import 'localization/localization_widget.dart';

bool isJustUiTest = false;
var img =
    "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();
  await LocalizationWidget.setUp();
  await initializeDependencies();
  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();

  ChuckerFlutter.showOnRelease = false;
  ChuckerFlutter.isDebugMode = false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);

  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
     PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  runApp(
    const LocalizationWidget(
      child: ScreenUtilInitWidget(
        child: AppWidget(),
      ),
    ),
  );
}



