import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/colors.dart';
import 'package:matrimony_admin/Chat/screens/mobile_layout_screen.dart';
import 'package:matrimony_admin/Chat/screens/web_layout_screen.dart';
import 'package:matrimony_admin/Chat/utils/responsive_layout.dart';
import 'package:matrimony_admin/models/new_user_model.dart';

// void main() {
//   runApp(const ChatPageHome());
// }

class ChatPageHome extends StatefulWidget {
  final NewUserModel newusermodel;
  const ChatPageHome({Key? key, required this.newusermodel}) : super(key: key);

  @override
  State<ChatPageHome> createState() => _ChatPageHomeState();
}

class _ChatPageHomeState extends State<ChatPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // title: 'Couple Match Chat',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: backgroundColor,
      // ),
      body: MobileLayoutScreen(newusermodel: widget.newusermodel,),
    );
  }
}
