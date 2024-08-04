import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aknan_user_app/features/chat/controller/cubit/chat_cubit_cubit.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_context/one_context.dart';

import '../features/chat/message_screen.dart';

class NotificationHelper {
  static String? _fcmToken;
  static String? get fcmToken => _fcmToken;

  static getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log(
          'onOpenApp From terminated By Click On Notification: ${message.data}',
          name: "TAG-FCM",
        );
        if (kDebugMode) {
          print(
              '[TAG-FCM] onOpenApp From terminated By Click On Notification: ${message.data}  ');
        }

        navigationOnClickOnNotification(message.data);
      }
    });
  }

  static void navigationOnClickOnNotification(Map<String, dynamic> data) {
    String notifyType = data['notify_type'];

    switch (notifyType) {
      // case "new_order":
      //   _navigateToMapScreenInNweOrder(data);
      //   break;
      case "chat":
        String orderId = data['maintenance_id'];
        _navigateToChatByOrderId(orderId);
        break;

      // case "change_order_status":
      //   // _navigateToMapScreenInCurrentOrder(data);

      default:
        () {};
    }
  }

  static void _navigateToChatByOrderId(String orderId) {
    OneContext.instance.context!.push(MessageScreen(
      maintenanceId: orderId,
    ));
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    _fcmToken = await FirebaseMessaging.instance.getToken();
    await _requestPermission(flutterLocalNotificationsPlugin);
    log('fcmToken: $_fcmToken', name: 'TAG-FCM');

    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          log(
            "on Click On Massage On foreground -- response.payload   ${json.decode(response.payload!)}",
            name: 'TAG-FCM',
          );

          Map<String, dynamic> data = json.decode(response.payload!);
          navigationOnClickOnNotification(data);
        } else {
          log("on Click On Massage On foreground ", name: 'TAG-FCM');
        }
        // TODO: Route
        // try{
        //   if(payload != null && payload.isNotEmpty) {
        //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
        //   }else {
        //     Get.toNamed(RouteHelper.getNotificationRoute());
        //   }
        // }catch (e) {}
        return;
      },
      onDidReceiveBackgroundNotificationResponse: myBackgroundMessageReceiver,
    );
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log(
          'onOpenApp From terminated By Click On Notification: ${message.data}',
          name: "TAG-FCM",
        );
        if (kDebugMode) {
          print(
              '[TAG-FCM] onOpenApp From terminated By Click On Notification: ${message.data}  ');
        }

        navigationOnClickOnNotification(message.data);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('onMessage  ForeGround: ${message.data}', name: 'TAG-FCM');

      NotificationHelper.showNotification(
        message,
        flutterLocalNotificationsPlugin,
        true,
      );
      actionOnReserveOnNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('onOpenApp From BackGround: ${message.data}', name: "TAG-FCM");
      navigationOnClickOnNotification(message.data);
    });
  }

  static Future<void> _requestPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();
    }
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      carPlay: true,
    );
  }

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
    bool isData,
  ) async {
    log(
      'showNotification: message.notification ${message.notification?.toMap()}',
      name: 'TAG-FCM',
    );
    log(
      'showNotification  message.data: ${message.data}',
      name: 'TAG-FCM',
    );
    String title = message.notification?.title ?? "";
    String body = message.notification?.body ?? "";
    String? orderID = message.data['order_id'];
    // String? image = (message.data['image'] != null &&
    //         message.data['image'].isNotEmpty)
    //     ? message.data['image'].startsWith('http')
    //         ? message.data['image']
    //         : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
    //     : null;

    try {
      await showBigPictureNotificationHiddenLargeIcon(
        title,
        body,
        orderID,
        // image,
        null,
        fln,
        jsonEncode(message.data),
      );
    } catch (e) {
      await showBigPictureNotificationHiddenLargeIcon(
        title,
        body,
        orderID,
        null,
        fln,
        jsonEncode(message.data),
      );
      log('Failed to show notification: ${e.toString()}', name: "TAG-FCM");
    }
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
    String title,
    String body,
    String? orderID,
    String? image,
    FlutterLocalNotificationsPlugin fln,
    String data,
  ) async {
    String? largeIconPath;
    String? bigPicturePath;
    BigPictureStyleInformation? bigPictureStyleInformation;
    BigTextStyleInformation? bigTextStyleInformation;
    if (image != null && !kIsWeb) {
      // TODO::
      // largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
      // bigPicturePath = largeIconPath;
      // bigPictureStyleInformation = BigPictureStyleInformation(
      //   FilePathAndroidBitmap(bigPicturePath),
      //   hideExpandedLargeIcon: true,
      //   contentTitle: title,
      //   htmlFormatContentTitle: true,
      //   summaryText: body,
      //   htmlFormatSummaryText: true,
      // );
    } else {
      bigTextStyleInformation = BigTextStyleInformation(
        body,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
      );
    }
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '6amTech',
      '6amTech',
      priority: Priority.max,
      importance: Importance.max,
      playSound: true,
      largeIcon:
          largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
      styleInformation: largeIconPath != null
          ? bigPictureStyleInformation
          : bigTextStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: data,
    );
  }

  static void actionOnReserveOnNotification(Map<String, dynamic> data) {
    String notifyType = data['notify_type'];
    final context = OneContext.instance.context!;
    switch (notifyType) {
      case "chat":
        final bool isInMessageScreen =
            ModalRoute.of(context)!.settings.name == "MessageScreen";

        if (isInMessageScreen) {
          BlocProvider.of<ChatCubitCubit>(context).addMsgOnSpotChat(data);
          // Get.find<ChatController>().addMsgOnSpotChat(data);
        }

      default:
    }
  }

  // static Future<String> _downloadAndSaveFile(
  //     String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final http.Response response = await http.get(Uri.parse(url));
  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage remoteMessage) async {
  log(' onMessage Received Background: ${remoteMessage.data}', name: "TAG-FCM");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}

@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageReceiver(
    NotificationResponse response) async {
  log('onBackgroundClicked: ${response.payload}', name: 'TAG-FCM');
}
