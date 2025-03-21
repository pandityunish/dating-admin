import 'dart:async';

// import 'package:couple_match/features/auth/screens/community.dart';
// import 'package:couple_match/features/auth/screens/permision_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../globalVars.dart';
import '../widgets/circular_bubles.dart';

// import '../../features/auth/widgets/circular_bubles.dart';

class ImportantInfo extends StatefulWidget {
  final VoidCallback callback;
  const ImportantInfo({super.key, required this.callback});

  @override
  State<ImportantInfo> createState() => _ImportantInfoState();
}

class _ImportantInfoState extends State<ImportantInfo> {
  void showinfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionScreen(),));
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: main_color,
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
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
                  Text.rich(TextSpan(style: const TextStyle(fontSize: 20), children: [
                    const TextSpan(
                        text: "Couple",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "match",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: main_color)),
                  ])),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "World’s only matrimonial where we don’t charge",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "जरूरी सूचना ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "हमारी कंपनी किसी भी प्रकार का पैसा नहीं लेती है, यह सुविधा बिल्कुल मुफ्त है, कृपया सावधान रहें।",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Improtant Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Our company newer charge any money it is totally free platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                            fit: BoxFit.cover)),
                  ),
                  Text("By \nSourabh mehndiratta\n kurukshetra social worker",
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

  @override
  void initState() {
    Timer.run(() {
      showinfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                            autoPlay: true)
                        .then()
                        .slideX(end: 2, delay: 2000.ms, duration: 5000.ms)
                        .then(),
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideY(end: 1)
                        .then(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                            autoPlay: true)
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideY(end: 1)
                        .then(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                            autoPlay: true)
                        .then()
                        .slideX(
                          end: 0,
                          delay: 2000.ms,
                          duration: 5000.ms,
                        )
                        .then(),
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                            autoPlay: true)
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideX(end: 1),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                            autoPlay: true)
                        .then()
                        .slideX(end: 1, delay: 5000.ms, duration: 4000.ms)
                        .then(),
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideY(end: 1)
                        .then(),
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .slideY(end: -1, delay: 2000.ms, duration: 5000.ms),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideY(end: 1)
                        .then(),
                    CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideX(end: 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .move(delay: 2000.ms, duration: 5000.ms)
                        .then()
                        .slideX(end: 1)
                        .then(),
                    const CircularBubles(
                            url:
                                "https://images.unsplash.com/photo-1543932927-a9def13a0e7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .then()
                        .slideY(end: 1, delay: 2000.ms, duration: 5000.ms)
                        .then(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
