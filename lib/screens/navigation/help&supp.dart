import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';
import 'package:matrimony_admin/screens/navigation/support.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../Assets/Error.dart';
import '../../common/widgetAll/circular_bubles.dart';
import '../../globalVars.dart';
import '../../sendUtils/notiFunction.dart';
import 'navigator.dart';
import 'package:http/http.dart' as http;

class HelpSupport extends StatefulWidget {
  final NewUserModel newUserModel;
  const HelpSupport({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: "Support", iconImage: 'images/icons/community.png'),
        body: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1591969851586-adbbd4accf81?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: false),
                                  autoPlay: true)
                              // .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1513279922550-250c2129b13a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1531747056595-07f6cbbe10ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1500.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: 0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.2, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.2, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1637870996864-65dc1c00f4dc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: 0.3, duration: 3000.ms)
                              .then()
                              .slideY(end: 0.3, duration: 3000.ms)
                              .then()
                              .slideX(end: -0.3, duration: 3000.ms)
                              .then()
                              .slideY(end: -0.3, duration: 3000.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://media.istockphoto.com/id/1435198934/photo/this-is-my-life.jpg?s=612x612&w=is&k=20&c=ap2OM4yROkRUDD0KF08n_yjpMkgEKvmx-8zPoc2jYA4=")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: 0.4, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: 0.4, duration: 3000.ms)
                              .then()
                              .slideY(end: 0.05, duration: 1000.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: 0.1, duration: 400.ms)
                              .then()
                              // .slideY(end: 0.4, duration: 400.ms)
                              // .then()
                              .slideX(end: -0.1, duration: 400.ms)
                              .then()
                              .slideY(end: -0.1, duration: 400.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1591969851586-adbbd4accf81?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: false),
                                  autoPlay: true)
                              // .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then(),
                          SizedBox(
                            width: 50,
                          ),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1513279922550-250c2129b13a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1531747056595-07f6cbbe10ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1000.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1500.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideX(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1500.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: 0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.2, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.2, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1556229868-7b2d4b56b909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1500.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1559435578-231f6137aac5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: 0.1, duration: 1500.ms)
                              .then()
                              .slideX(end: -0.1, duration: 1500.ms)
                              .then()
                              .slideY(end: -0.1, duration: 1500.ms)
                              .then(),
                          CircularBubles(
                                  url:
                                      "https://images.unsplash.com/photo-1541679368093-5c967ac6de11?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGNvdXBsZSUyMGluJTIwbG92ZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60")
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                  autoPlay: true)
                              .slideX(end: -0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: -0.2, duration: 1000.ms)
                              .then()
                              .slideX(end: -0.2, duration: 1000.ms)
                              .then()
                              .slideY(end: 0.2, duration: 1000.ms)
                              .then(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            // RiveAnimation.asset(
            //   "RiveAssets/onboard_animation.riv",
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: SizedBox(
                  height: 350,
                  child: Material(
                      color: Colors.white,
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Help & Support",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Text(
                              "Query Reply",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLength: 300,
                                // enabled: !messageSend,
                                // enabled: true,
                                minLines: 5,
                                maxLines: 5,

                                scrollPhysics: AlwaysScrollableScrollPhysics(),
                                controller: descController,
                                cursorColor: main_color,
                                // scrollController: ScrollController(),
                                decoration: InputDecoration(
                                  focusColor: main_color,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: main_color),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Enter Reply Here",
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (name) => {
                                  /*setState(() {
                                            this.User_Name = name;
                                          })*/
                                },
                                //onSubmitted: (User_Name) => print('Submitted $User_Name'),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (messageSend == false)
                                      ? () {
                                          (descController.text.isNotEmpty)
                                              ? sendQuery()
                                              : showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SnackBarContent(
                                                          appreciation: "",
                                                          error_text:
                                                              "Please Enter Data",
                                                          sec: 1,
                                                          icon: Icons.error),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    );
                                                  });
                                        }
                                      : () {},
                                  child: Text(
                                    messageSend == true ? 'Pending' : 'Send ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Serif'),
                                  ),
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                          EdgeInsets.symmetric(
                                              horizontal: 65, vertical: 15)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              side: BorderSide(
                                                  color: Colors.white))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ));
  }

  bool messageSend = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  void sendPushMessage(
      String body, String title, String userid, String route, String token,
      {String userName = "", String sound = "navnot"}) async {
    try {
      print(token);
      http.Response res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAARNDuqEs:APA91bFMhCmAO8olPfJxG868C9czilKHzNIk_pYuXBJ7iFrGiK6bPl6K_O5Uqkq607hZFu_ScIfyCRq7ZBnHTtz_vl6HvrIvdDwxu_nxP4P4E-pDpGvIeGhP5Z3CQoxgwq6sZTlFLtYa',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'icon': 'ic_launcher'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'uid': userid,
              'route': route,
              'id': widget.newUserModel.id,
              'userName': userName,
              'status': 'done',
              'sound': sound
            },
            "to": token,
          },
        ),
      );
      print(res.body);
    } catch (e) {
      print("error push notification");
    }
  }

  sendQuery() {
    setState(() {
      messageSend = true;
    });
    SearchProfile().addtoadminnotification(
        userid: widget.newUserModel!.id!,
        useremail: widget.newUserModel!.email!,
        userimage: widget.newUserModel!.imageurls!.isEmpty
            ? ""
            : widget.newUserModel!.imageurls![0],
        title:
            "${userSave.displayName} QUERY REPLIED TO ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} ",
        email: userSave.email!,
        subtitle: "");
    SearchProfile()
        .postquery(email: widget.newUserModel.id, desc: descController.text);
    SearchProfile().addtonotification(
      email: widget.newUserModel.email!,
      title: "QUERY RESOLVED SUCCESSFULLY",
    );

    sendPushMessage("Query Resolved Successfully", "", widget.newUserModel.id,
        "/", widget.newUserModel.token,
        sound: "", userName: widget.newUserModel.name);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SnackBarContent(
              error_text: "Query Resolved Successfully",
              appreciation: "",
              icon: Icons.check_circle_rounded,
              sec: 3,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        }).whenComplete(() {
      Get.off(MyProfile(
        profilecomp: 50,
        userSave: widget.newUserModel,
      ));
    });

    setState(() {
      // messageSend = false;
      descController.clear();
    });
  }
}
