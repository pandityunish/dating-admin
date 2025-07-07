// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/G_Sign.dart';
import 'package:matrimony_admin/common/widgets2/social_button.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matrimony_admin/screens/profile/moving_bubble.dart';
import '../Assets/Error.dart';
import '../Assets/T&C_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/widgets/circular_bubles.dart';
import '../models/shared_pref.dart';
import 'data_collection/LetsStart.dart';
import 'SignIn.dart';
import 'profile/profileScroll.dart';
import 'service/auth_service.dart';

String? role;
String? location;
String? pPref;
// ignore: non_constant_identifier_names
String? uid_value;

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  SharedPref sharedPref = SharedPref();
  showinfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(40)),
                  child: ImageIcon(
                    AssetImage(
                      'images/icons/Close_icon.png',
                    ),
                    // fontWeight:FontWeight.w700,
                    color: main_color,
                  ),
                ),
              )
            ],
          ),
          content: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text.rich(TextSpan(
                  //     style: const TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.w700,
                  //         fontFamily: 'Arial'),
                  //     children: [
                  //       const TextSpan(
                  //           text: "Couple",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontFamily: 'Arial')),
                  //       TextSpan(
                  //           text: "match",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: main_color,
                  //               fontFamily: 'Arial')),
                  //     ])),
                  Image.asset('images/icons/free_ristawala.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Text(
                  //   "World’s only matrimonial where we don’t charge",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  const Text(
                    "जरूरी सूचना ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "हमारी कंपनी किसी भी प्रकार का पैसा नहीं लेती है, यह सुविधा बिल्कुल मुफ्त है, कृपया सावधान रहें।",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Improtant Information",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Our company newer charge any money it is totally free platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/saurabh.png"),
                            // image: NetworkImage(
                            //     "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                            fit: BoxFit.cover)),
                  ),
                  const Text(
                      "By \nSourabh mehndiratta\n KURUKSHETRA SOCIAL WORKER",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  var data;
  void getallbubbles() async {
    data = await UserService().getbubbles();
    setState(() {});
  }
 showsigindialog() {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  signup(context);
                },
                child: const SocialButton(
                    image: "images/google.png", name: "Continue With Google")),
            InkWell(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: SnackBarContent(
                          error_text: "Please Continue With Google",
                          appreciation: "",
                          icon: Icons.error,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
              },
              child: const SocialButton(
                  image: "images/facebook.png", name: "Continue With Facebook"),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: SnackBarContent(
                          error_text: "Please Continue With Google",
                          appreciation: "",
                          icon: Icons.error,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
              },
              child: const SocialButton(
                  image: "images/instagram.png",
                  name: "Continue With Instagram"),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: SnackBarContent(
                          error_text: "Please Continue With Google",
                          appreciation: "",
                          icon: Icons.error,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
              },
              child: const SocialButton(
                  image: "images/twitter.png", name: "Continue With Twitter"),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: SnackBarContent(
                          error_text: "Please Continue With Google",
                          appreciation: "",
                          icon: Icons.error,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
              },
              child: const SocialButton(
                  image: "images/linkedin.png", name: "Continue With Linkedin"),
            ),
          ],
        ),
      ),
    ));
  }
  @override
  void initState() {
    Timer.run(() {
      showinfo();
    });
    getallbubbles();

    super.initState();
  }

  // ignore: non_constant_identifier_names
  bool color_done = false;

  var error;

  bool term = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      BubbleImage(height: MediaQuery.of(context).size.height * 0.7 / 8),
      
          Column(
                  children: [
                    SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                   
                    Image.asset(
                      'images/icons/free_ristawala1.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                   SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            activeColor: main_color,
                            value: term,
                            onChanged: (term) {
                              setState(() {
                                this.term = term!;
                              });
                            }),
                        const Text(
                          "I agree with Free Rishtey Wala's",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => TCPopup(),
                            );
                            FirebaseFirestore.instance
                                .collection('data')
                                .add({'text': 'data added through app'});
                          },
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(color: main_color, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          style: ButtonStyle(
                             minimumSize: WidgetStatePropertyAll(Size(double.infinity, 48)),
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 15)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: (color_done == false)
                                            ? Colors.white
                                            : main_color,
                                      ))),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white)),
                          onPressed: () {
                            setState(() {
                              color_done = true;
                            });
                            if (term == false) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SnackBarContent(
                                        error_text:
                                            "Please Accept \n Term & Conditions",
                                        appreciation: "",
                                        icon: Icons.error,
                                        sec: 2,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    );
                                  });
                            } else {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => handleAuthState()),
                              // );
                              showsigindialog();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                                      
                              //           SignInScreen()
                                  
                              //       ),
                              // );
                            }
                          },
                          child: Text(
                            "Continue",
                            style: (color_done == false)
                                ? TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Serif',
                                    fontWeight: FontWeight.w700)
                                : TextStyle(
                                    color: main_color,
                                    fontSize: 20,
                                    fontFamily: 'Serif',
                                    fontWeight: FontWeight.w700),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
