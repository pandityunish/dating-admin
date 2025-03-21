import 'package:matrimony_admin/Assets/ayushWidget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../Assets/G_Sign.dart';

import '../common/widgets/circular_bubles.dart';
import '../common/widgets/social_button.dart';
import '../globalVars.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Image.asset(
                'images/icons/free_ristawala1.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Stack(
                children: [
                  Column(
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
                    ],
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: 400,
                    // width: 406,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: MediaQuery.of(context).size.width * 0.035,
                        right: MediaQuery.of(context).size.width * 0.035),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(48)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0.5,
                              color: Color.fromRGBO(0, 0, 0, 0.19))
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                signup(context);
                              },
                              child: const SocialButton(
                                  image: "images/google.png",
                                  name: "Continue With Google")),
                          const SocialButton(
                              image: "images/facebook.png",
                              name: "Continue With Facebook"),
                          const SocialButton(
                              image: "images/instagram.png",
                              name: "Continue With Instagram"),
                          const SocialButton(
                              image: "images/twitter.png",
                              name: "Continue With Twitter"),
                          const SocialButton(
                              image: "images/linkedin.png",
                              name: "Continue With Linkedin"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.09,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: main_color,
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text("I Agree With FREERISHTEYWALA's",
                      style: TextStyle(fontSize: 12)),
                  BigText(
                    size: 12,
                    text: "Terms and Conditions",
                    color: main_color,
                  )
                ],
              ),
              Container(
                // margin: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            EdgeInsets.symmetric(vertical: 17)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    side: BorderSide(
                                      color: (color_done2 == false)
                                          ? Colors.white
                                          : main_color,
                                    ))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LetsStart(),));
                    },
                    child: Text(
                      "Continue",
                      style: (color_done2 == false)
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
            ],
          ),
        ),
      ),
    );
  }
}

bool color_done2 = false;
