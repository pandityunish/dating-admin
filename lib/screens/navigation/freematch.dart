import 'dart:async';

import 'package:matrimony_admin/screens/navigation/howToUse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';

import '../../Assets/Error.dart';
import '../../common/widgetAll/circular_bubles.dart';
import '../../globalVars.dart';
import '../profile/profileScroll.dart';
import 'help&supp.dart';
import 'navigator.dart';

class FreeMatch extends StatefulWidget {
  const FreeMatch({Key? key}) : super(key: key);

  @override
  State<FreeMatch> createState() => _FreeMatchState();
}

class _FreeMatchState extends State<FreeMatch> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          // middle: Icon(
          //   Icons.supervised_user_circle_outlined,
          //   // color: ma/
          //   size: 30,
          // ),
          middle: Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
            TextSpan(
                text: "Couple", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: "match",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: main_color)),
            TextSpan(
                text: ".in", style: TextStyle(fontWeight: FontWeight.bold)),
          ])),
          previousPageTitle: "",
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
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

            Center(
              child: SizedBox(
                height: 250,
                child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Subscribe"),
                          Text("For"),
                          Text("Free Personalised Matchmaking"),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SnackBarContent(
                                        appreciation: "",
                                        error_text: "Request Sent Successfully",
                                        icon: Icons.check,
                                        sec: 1,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    );
                                  }).then((value) => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SnackBarContent(
                                              appreciation: "",
                                              error_text:
                                                  "Sorry \n Service is Not Available \n In \n Your Area. \n You Can Search By Yourself.",
                                              sec: 2,
                                              icon: Icons.error),
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        );
                                      })
                                  .then((value) => Navigator.of(context)
                                      .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  SlideProfile()),
                                          (route) => false)));
                            },
                            child: Text(
                              'Subscribe',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry?>(
                                    EdgeInsets.symmetric(
                                        horizontal: 90, vertical: 20)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        side: BorderSide(color: Colors.white))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => Use()));
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry?>(
                                    EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        side: BorderSide(color: Colors.white))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ));
  }
}
