import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/Assets/notification_pop.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/network_connectivity.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:geolocator/geolocator.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Assets/notification_service.dart';
import 'globalVars.dart' as glb;
import 'globalVars.dart';
import 'models/shared_pref.dart';
import 'models/user_model.dart';
import 'screens/maintinance_screen.dart';
import 'screens/profile/profileScroll.dart';
import 'package:timezone/data/latest.dart';

import 'screens/service/screen_record.dart';

String? role;
String? about;

// String? fcmToken;

Future<void> main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenshotDetection.initialize();
  NotificationServiceLocal().initNotification();
  initializeTimeZones();
  NotificationData notificationData = NotificationData();
  notificationData.requestNotificationPermission();
  notificationData.firebaseInit();
// DependencyInjection.init();
  notificationData.isTokenRefresh();
  notificationData.getDeviceToken().then((value) {
    glb.deviceToken = value;
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationData().setupInteractMessage();
  });

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Handle notifications received while app is terminated
  messaging.getInitialMessage().then((RemoteMessage? message) async {
    if (message != null) {
      // Navigator.of(context).pushNamed(message.data["route"]);
      print('Received message on launch: ${message.notification!.title}');
      // Handle the notification
    }
  });

  // final prefs = await SharedPreferences.getInstance();
  handleAuth() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    try {
      SharedPref sharedPref = SharedPref();
      User userSave = User.fromJson(await sharedPref.read("user") ?? {});
      location = userSave.Location;
      glb.userSave = userSave;
    } catch (e) {
      print(e);
    }
  }

  await handleAuth();
  if (userSave.email == null || userSave.email == "") {
    runApp(const Main());
  } else {
    NotificationData().setupInteractMessage();
    String findusercond = await AuthService().findadminuser(userSave.email!);
    if (findusercond == "true") {
      // glb.userSave = userSave;
      runApp(SecondMain());
    } else {
      runApp(const Main());
    }
  }
}

// Define a background message handler function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Received message in background: ${message.notification!.title}');
  // Handle the notification
  print(message.data['click_action']);
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _isRequestingPermission =
      false; // Flag to prevent multiple permission requests

  Future<void> getToken() async {
    // Check if permission request is already in progress
    if (_isRequestingPermission) {
      print('Permission request already in progress, please wait.');
      return;
    }

    // Set the flag to indicate permission request is in progress
    _isRequestingPermission = true;

    try {
      // Request notification permissions
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Check if permissions were granted
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("Notification Permission Granted");

        // Get the device token
        glb.deviceToken = await FirebaseMessaging.instance.getToken();
        print('Device Token: ${glb.deviceToken}');
      } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('User denied notification permission.');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.notDetermined) {
        print('Notification permission not determined.');
      }
    } catch (e) {
      print('Error in requesting permission: $e');
    } finally {
      // Reset the flag once done to allow future requests
      _isRequestingPermission = false;
    }
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Icon(
            Icons.error,
            color: main_color,
          ),
          content: const Text('No Internet Connection'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                if (!mounted) return;
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  if (!mounted) return;
                  setState(() => isAlertSet = true);
                }
              },
              child: Text(
                'OK',
                style: TextStyle(color: main_color),
              ),
            )
          ],
        ),
      );
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  getConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      if (mounted) setState(() => isAlertSet = false);

      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      if (mounted) setState(() => isAlertSet = false);

      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      if (mounted) setState(() => isAlertSet = false);
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      if (mounted) setState(() => isAlertSet = false);
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      if (mounted) setState(() => isAlertSet = false);

      // Bluetooth connection available.
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      if (mounted) setState(() => isAlertSet = false);

      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      showDialogBox();
      if (mounted) setState(() => isAlertSet = true);
    }
    // subscription = Connectivity().onConnectivityChanged.listen(
    //       (ConnectivityResult result) async {
    //         // Ensure the widget is still mounted
    //         if (!mounted) return;

    //         print("Shivam is Connected: $result");
    //         isDeviceConnected = await InternetConnectionChecker().hasConnection;

    //         // Show alert if the device is disconnected and no alert is set
    //         if (!isDeviceConnected && !isAlertSet) {
    //           showDialogBox();
    //           if (mounted)
    //             setState(() => isAlertSet = true); // Update state if mounted
    //         } else if (isDeviceConnected && isAlertSet) {
    //           // Reset alert state when the connection is restored
    //           if (mounted) setState(() => isAlertSet = false);
    //         }
    //       } as void Function(List<ConnectivityResult> event)?,
    //     );
  }

  connectivityCheck() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: avoid_print
      }
    } on SocketException catch (_) {
      print("not connected");
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SnackBarContent(
                error_text: "No Internet Connection",
                appreciation: "",
                icon: Icons.error,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });

      // connectivityCheck();
    }
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
    getConnectivity();
    getToken();
    connectivityCheck();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     theme: ThemeData(useMaterial3: false,
      scaffoldBackgroundColor: Colors.white
      ,appBarTheme: AppBarTheme(color: Colors.white,elevation: 0)),
      title: 'Couple Mate',
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else if (permission == LocationPermission.denied) {
      // Permissions are denied but not permanently, so another error
      return Future.error('Location permissions are denied.');
    }
  }

  // If permissions are granted, get the current position
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    return await Geolocator.getCurrentPosition();
  } else {
    return Future.error('Unexpected permission state.');
  }
}

class SecondMain extends StatefulWidget {
  SecondMain({Key? key}) : super(key: key);

  @override
  State<SecondMain> createState() => _SecondMainState();
}

class _SecondMainState extends State<SecondMain> {
  SharedPref sharedPref = SharedPref();
  var data;
  void getallmaintenance() async {
    data = await HomeService().getmaintenance();
    if (data[0]["isUnder"] == false) {
      if (userSave.email == "s9053622222@gmail.com" ||
          userSave.email == "s9728401234@gmail.com" ||
          userSave.email == "yunishpandit98@gmail.com" ||
          userSave.email == "pandityunish1228@gmail.com") {
        print("mein ${userSave.email}");
        Get.offAll(SlideProfile());
      } else {
        Get.offAll(const MeintenanceScreen());
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getallmaintenance();
    //  AuthService().getadmin(userSave.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext maincontext) {
    // NotificationFunction.setonlineStatus(glb.userSave.uid!, "Online");
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: false,
            scaffoldBackgroundColor: Colors.white
      ,appBarTheme: AppBarTheme(color: Colors.white,elevation: 0),
        
          expansionTileTheme: ExpansionTileThemeData(
            iconColor: main_color,
            textColor: main_color,
          )
          //  colorScheme: ColorScheme.fromSeed(seedColor: main_color,primary: main_color),
          ),
      debugShowCheckedModeBanner: false,
      home: SlideProfile(),
      // routes: {
      //   'profilepage': (_) => ProfilePage(
      //         userSave: profiledata,
      //       ),
      // },
    );
  }
}
