import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matrimony_admin/screens/service/auth_service.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../../globalVars.dart';

import '../profile/profileScroll.dart';

class Congo extends StatefulWidget {
  Congo({super.key});
  @override
  State<Congo> createState() => _ReligionState();
}

class _ReligionState extends State<Congo> {
    HomeService homeservice=Get.put(HomeService());

  @override
  void initState() {
    homeservice.getuserdata();
    
    // print("Name ${userSave}");
    // NotificationFunction.setNotification(
    //   "admin",
    //   " ${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} CMM16454 COMPLETE SIGN UP ",
    //   'completesignup',
    // );
    // NotificationFunction.setNotification(
    //   "user1",
    //   "PROFILE HAS BEEN APPROVED SUCCESSFULLY",
    //   'congo',
    // );
    // NotificationFunction.setNotification(
    //   "user1",
    //   "KNOW HOW TO USE APP",
    //   'knowHow',
    // );

  }
 UserService userService=Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 3),
        // const Duration(minutes: 10),
        () {
          // print()
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SlideProfile();
              },
            ),
            (route) => false,
          );
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Congratulations! ",
                          style: TextStyle(
                              color: main_color,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Sans-serif'),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(left: 50),
                            child: Text(
                              "Welcome to ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Sans-serif'),
                            ),
                          ),
                          Text(
                            "free",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                           ),
                          ),
                          Text(
                            "RisteyWala",
                            style: TextStyle(
                                color: main_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                               ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "You have successfully registered",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Sans-serif'),
                          ),
                          Container(
                            // margin: EdgeInsets.only(left: 120),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "with",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Sans-serif'),
                                ),
                                const Text(
                                  " Free",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                   ),
                                ),
                                Text(
                                  "RisteyWala",
                                  style: TextStyle(
                                      color: main_color,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: Icon(
                          Icons.check_circle,
                          color: main_color,
                        ),
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Sans-serif'),
                          ),
                          Text(
                            " Free",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                ),
                          ),
                          Text(
                            "RisteyWala",
                            style: TextStyle(
                                color: main_color,
                                fontSize: 16,
                               ),
                          ),
                          Text(
                            " ID is ${userService.userdata["puid"]}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Sans-serif'),
                          ),
                        ],
                      ),
                      Text(
                        "${userService.userdata["email"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sans-serif'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
