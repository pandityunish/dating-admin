import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void
        Function(List<ConnectivityResult> event)?);
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _updateConnectionStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Icon(
              Icons.error,
              color: main_color,
            ),
            content: Text('No Internet Connection'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Get.back(); // Close the dialog
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: main_color),
                ),
              )
            ],
          ),
        ),
        barrierDismissible: false,
      );
    } else {
      if (Get.isDialogOpen!) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        String? useremail = sharedPreferences.getString("email");

        Get.back();
      }
    }
  }
}
