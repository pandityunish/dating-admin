import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globalVars.dart';
// import 'package:couple_match/screens/congo.dart';

class Use extends StatefulWidget {
  const Use({Key? key}) : super(key: key);

  @override
  State<Use> createState() => _UseState();
}

class _UseState extends State<Use> {
  int value = 0;
  TextEditingController nameController = TextEditingController();
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "",
        middle: Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
          TextSpan(
              text: "Free",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: "Showg")),
          TextSpan(
              text: "rishteywala",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: main_color,
                  fontFamily: "Showg")),
          // TextSpan(
          //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
        ])),
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              /*crossAxisAlignment: CrossAxisAlignment.start,*/
              children: [
                Container(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "How to Use CoupleMatch",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                    Text(
                      "10:30 minutes",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Edit Profile ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Turn Notifications On ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Contact Customer Care ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Block A User ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Shortlist A User ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Report A User ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_outline,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    title: Text("How To Search Profile ?"),
                    subtitle: Text("16:12 minutes"),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
