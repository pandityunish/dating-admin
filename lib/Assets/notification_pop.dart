import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../../globalVars.dart' as glb;
import 'dart:io' show Platform;
// import 'package:audioplayers/audioplayers.dart' as audio;
import '../Chat/main.dart';
import '../Chat/service/chat_service.dart';
import '../globalVars.dart';
import '../models/new_user_model.dart';
import '../screens/profile/profileScroll.dart';

FlutterLocalNotificationsPlugin flutterNotificationPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationData with WidgetsBindingObserver {
  // audio.AudioPlayer player = audio.AudioPlayer();

  AndroidNotificationChannel main_channel = const AndroidNotificationChannel(
      // message.notification!.android!.channelId.toString(),
      // message.notification!.android!.channelId.toString(),
      'high_importance_channel',
      'The Errors',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('navnot'));
  AndroidNotificationChannel chat_channel = const AndroidNotificationChannel(
      'high_importance_channel_2', 'Chat',
      importance: Importance.defaultImportance,
      enableVibration: true,
      showBadge: true,
      playSound: true,
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('chatnot'));
  static bool isChatting = false;
  static var uid = "";
  var notiDataUid = "";

  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      print("***********************");
      print(message);
      print(payload);
      print("*******************");
      handleMessage(message);
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      notiDataUid = message.data['uid'].toString();
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      print("NotidataUid : ${notiDataUid}");
      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');

        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(message);
        showNotification(message);
        // flutterLocalNotificationsPlugin
        //     .resolvePlatformSpecificImplementation<
        //         AndroidFlutterLocalNotificationsPlugin>()!
        //     .createNotificationChannel(main_channel);
        // flutterLocalNotificationsPlugin
        //     .resolvePlatformSpecificImplementation<
        //         AndroidFlutterLocalNotificationsPlugin>()!
        //     .createNotificationChannel(chat_channel);
        // await player.setSource(AssetSource('sound/notification.wav'));
        // await player.resume();
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  String getNotificationSoundPath(String notificationType) {
    // switch (notificationType) {
    //   case 'profilepage':
    //     print("navnot");
    //     return 'navnot';
    //   case 'chat':
    //     print("chatnot");
    //     return 'chatnot';
    //   default:
    //     return 'null';
    // }
    if (notificationType == 'profilepage') {
      print('navnot');
      return 'navnot';
    } else if (notificationType == 'chat') {
      print('chatnot');
      return 'chatnot';
    } else {
      return 'null';
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    if (kDebugMode) {
      print("isChatting: ${isChatting}");
      print("UID: ${uid}");
    }
    print("Channel Sound : ${message.data['sound']}");
    // HomeService().getuserdata();

    // print("Notification Sound: ${message.data['sound']}");
    if (message.data['sound'] == "chatnot") {
      if (notiDataUid != uid) {
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
                // channel.id.toString(), channel.name.toString(),
                chat_channel.id,
                chat_channel.name,
                icon: "@mipmap/ic_launcher",
                channelDescription: 'This is the Chat Notifications ',
                importance: chat_channel.importance,
                priority: Priority.high,
                playSound: chat_channel.playSound,
                ticker: 'ticker',
                // largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
                sound: const RawResourceAndroidNotificationSound('chatnot')

                //  icon: largeIconPath
                );

        const DarwinNotificationDetails darwinNotificationDetails =
            DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true);

        NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails,
            iOS: darwinNotificationDetails);

        Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails,
          );
        });
      }
    } else if (isChatting == true && userSave.status == 'approved') {
      if (notiDataUid != uid) {
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
                // channel.id.toString(), channel.name.toString(),
                chat_channel.id,
                chat_channel.name,
                channelDescription: 'This is the Chat Notifications ',
                importance: chat_channel.importance,
                priority: Priority.high,
                playSound: chat_channel.playSound,
                ticker: 'ticker',
                icon: "@mipmap/ic_launcher",
                // largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
                sound: const RawResourceAndroidNotificationSound('navnot')

                //  icon: largeIconPath
                );

        const DarwinNotificationDetails darwinNotificationDetails =
            DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true);

        NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails,
            iOS: darwinNotificationDetails);

        Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails,
          );
        });
      }
    } else if (userSave.status == 'approved') {
      print("Second Run");
      print("Channel Sound : ${message.data['sound']}");

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              // channel.id.toString(), channel.name.toString(),
              // channelDescription: 'your channel description',
              main_channel.id,
              main_channel.name,
              channelDescription: 'This is the main high descriptive channel',
              importance: main_channel.importance,
              priority: Priority.high,
              icon: "@mipmap/ic_launcher",
              playSound: main_channel.playSound,
              ticker: 'ticker',
              // largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),

              // sound: channel.sound
              // sound: RawResourceAndroidNotificationSound(
              //     getNotificationSoundPath(message.data['route']))
              sound: const RawResourceAndroidNotificationSound('navnot')
              //  icon: largeIconPath
              );

      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true);

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);

      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      });
    }
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage() async {
    // print("Called Background Message"); // when app is terminated
    // var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    // showNotification(initialMessage!);

    // // print(initialMessage!.data['notification']);
    // if (initialMessage != null) {
    //   handleMessage(initialMessage);
    // }

    // //when app ins background
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   handleMessage(event);
    // });
  }

  void handleMessage(RemoteMessage message) async {
    // print("context: ${contextmain}");
    // print("UID Value ${message.data['uid']}");

    // var profile = await FirebaseFirestore.instance
    //     .collection("user_data")
    //     .where('uid', isEqualTo: message.data["uid"])
    //     .get();
    if (message.data["route"] == "profilepage") {
      print(message.data["uid"]);
      NewUserModel newUserModel =
          await ChatService().getuserdata(message.data["uid"]);

      // ignore: use_build_context_synchronously
      // Navigator.push(
      //     context,
      //     PageRouteBuilder(
      //         transitionDuration: const Duration(milliseconds: 0),
      //         reverseTransitionDuration: const Duration(milliseconds: 0),
      //         pageBuilder: (_, __, ___) => MainAppContainer(
      //               notiPage: true,
      //               user_data: profile,
      //             )));
      Get.to(SlideProfile(
        user_data: [newUserModel],
      ));
      HomeService().getuserdata();
      // Navigator.of(contextmain!).push(MaterialPageRoute(
      //     builder: (contextmain) => MainAppContainer(
      //           notiPage: true,
      //           user_data: profile,
      //         )));
    } else if (message.data["route"] == "profilepage") {
      NewUserModel newUserModel;
      // newUserModel = await HomeService().getuserdata(message.data["uid"]);
      // Get.to(MobileChatScreen(
      //   profileDetail: newUserModel,
      //   profilepic: newUserModel.imageurls.isNotEmpty
      //       ? newUserModel.imageurls[0]
      //       : "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2",
      //   roomid: "some",
      // ));
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
