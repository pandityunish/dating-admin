import 'dart:async';

import 'package:matrimony_admin/common/global.dart';
// import 'package:matrimony_admin/features/chat/screens/phone_call.dart';
// import 'package:matrimony_admin/features/chat/screens/video_call.dart';
// import 'package:matrimony_admin/features/home/screens/profile_details_screen.dart';
import 'package:flutter/material.dart';

import '../../globalVars.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List chats = [
    {"message": "How are you", "date": "12:30"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: main_color,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "G sharma",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("CMM15421",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => VideoCallScreen(),
                //     ));
              },
              icon: const Icon(
                Icons.video_call_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PhoneCall(),
                //     ));
              },
              icon: const Icon(Icons.phone_outlined)),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: const Text(
                    'Need conference call',
                  ),
                  onTap: () {
                    Future(() => customAlertBox1(
                        context,
                        Icons.check_circle_outline_outlined,
                        "",
                        "Conference Call request successfully",
                        () {}));
                    Timer(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }),
              PopupMenuItem(
                  child: const Text(
                    'Mark as Read',
                  ),
                  onTap: () {}),
              PopupMenuItem(
                  child: const Text(
                    'View Profile',
                  ),
                  onTap: () {
                    // Future(() => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProfileDetails(),
                    //     )));
                    Timer(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }),
              PopupMenuItem(
                  child: const Text(
                    'Block',
                  ),
                  onTap: () {
                    Future(() => customAlertBox1(
                        context,
                        Icons.check_circle_outline_outlined,
                        "Blocked successfully",
                        " ",
                        () {}));
                    Timer(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  })
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: chats.length,
            reverse: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 219, 219, 219),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                chats[index]["message"],
                                style: TextStyle(fontSize: 20),
                              )),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(chats[index]["date"]))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
          Text("22,06,2023"),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_missed_outlined,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Missed A Voice Call")
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hintText: 'Type a message!',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 2,
                      left: 2,
                    ),
                    child: CircleAvatar(
                      backgroundColor: main_color,
                      radius: 25,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
