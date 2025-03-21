import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/navigation/FreePersonalizeMatchmaking/free_chat_screen.dart';


import '../../../Chat/widgets/match_component.dart';
import 'user_list_call.dart';

class AudioVideoCallScreen extends StatefulWidget {
  const AudioVideoCallScreen({super.key});

  @override
  State<AudioVideoCallScreen> createState() => _FreeMatchmakingScreenState();
}

class _FreeMatchmakingScreenState extends State<AudioVideoCallScreen> {


  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100), // Adjust AppBar height
              child: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: main_color,
                    size: 25,
                  ),
                ),
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(
                      top: 15), // Adjust padding for alignment
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       CircleAvatar(
            backgroundColor: main_color,
            backgroundImage: const AssetImage(
              "images/newlogo.png",
            ),
            radius: 20,
          ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: main_color,
                            fontFamily: 'Sans-serif',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          child: Text("Free Personalised Matchmaking"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(UserListCall(
                        
                        ));
                        // if (matchads.isNotEmpty) {
                        //   showadsbar(context, matchads, () {
                        //     Navigator.pop(context);
                        //   });
                        // }
                      },
                      child: MatchingComponents(
                        title: "Audio Call",
                      )),
                  GestureDetector(
                      onTap: () {
                           Get.to(UserListCall(
                        
                        ));
                        // Get.to(LiveAstroScreen(
                        //   id: "Live Astrologer",
                        // ));
                        // if (astroads.isNotEmpty) {
                        //   showadsbar(context, astroads, () {
                        //     Navigator.pop(context);
                        //   });
                        // }
                      },
                      child: MatchingComponents(
                        title: "Video Call",
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
