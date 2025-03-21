import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/navigation/FreePersonalizeMatchmaking/free_chat_screen.dart';


import '../../../Chat/widgets/match_component.dart';
import 'audio_video_call_screen.dart';

class UserListCall extends StatefulWidget {
  const UserListCall({super.key});

  @override
  State<UserListCall> createState() => _FreeMatchmakingScreenState();
}

class _FreeMatchmakingScreenState extends State<UserListCall> {


  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(130), // Adjust AppBar height
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
                          child: Text("Live matchmaker (audio Call)"),
                        ),
                         Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CupertinoSearchTextField(
                                    // controller: _searchController,
                                    onSubmitted: (value) {
                                     
                                    },
                                    // onChanged: (value) {},
                                    onSuffixTap: () {
                                     
                                    },
                                  ),
                                ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(
                         children: [
                           CircleAvatar(
                                backgroundColor: main_color,
                                backgroundImage: const AssetImage(
                                           "images/newlogo.png",
                                ),
                                radius: 26,
                              ),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("S Mehndiratta",style: TextStyle(fontWeight: ui.FontWeight.bold,fontSize: 18),),
                                  Text("FRWMSFGGHJF",style: TextStyle(color: main_color,fontSize: 12),)
                                ],
                              ),
                         ],
                       ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1BBB0C)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.call_end,color: Colors.white,size: 17,),
                                  ),
                                ),
                              ),
                              SizedBox(width: 60,),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFF4D4D)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.call_end,color: Colors.white,size: 17,),
                                  ),
                                ),
                              )
                            ],
                          )
                    ],
                   )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
