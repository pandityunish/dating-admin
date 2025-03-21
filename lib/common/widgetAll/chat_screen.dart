import 'dart:async';

import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/common/widgets/logotext.dart';
import 'package:flutter/material.dart';

import '../../globalVars.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List items = [
    {
      "name": "C Batra",
      "image":
          "https://images.unsplash.com/photo-1503443207922-dff7d543fd0e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80",
      "subtitle": "Miss Voice called"
    },
    {
      "name": "M Chabra",
      "image":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
      "subtitle": "Hello how are you"
    },
    {
      "name": "M Larba",
      "image":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      "subtitle": "Typing ...."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: main_color,
          ),
        ),
        centerTitle: true,
        title: const LogoText(),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_sharp,
                color: main_color,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: main_color,
              child: Center(
                child: Text(
                  "Chat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => MessageScreen(),
                        //     ));
                      },
                      title: Text(items[index]["name"]),
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(items[index]["image"]),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              )),
                        ],
                      ),
                      subtitle: Text("${items[index]["subtitle"]}  3 min ago"),
                      trailing: PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
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
                                'Report',
                              ),
                              onTap: () {
                                Future(() => customAlertBox1(
                                    context,
                                    Icons.check_circle_outline_outlined,
                                    "Repoted successfully",
                                    " ",
                                    () {}));
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
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
