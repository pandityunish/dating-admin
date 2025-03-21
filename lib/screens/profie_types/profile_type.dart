import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';

class Profiletypes extends StatefulWidget {
  const Profiletypes({super.key});

  @override
  State<Profiletypes> createState() => _ProfiletypesState();
}

class _ProfiletypesState extends State<Profiletypes> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          children: [
            // Icon(
            //   Icons.chevron_left,
            //   size: 45,
            //   color: Colors.black,
            // ),
            BigText(
              text: "Profile Types",
              size: 20,
              color: main_color,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        previousPageTitle: "",
      ),
      child: Column(
        children: [
          BigText(text: "All Profiles (213542)"),
          BigText(text: "Male Profiles (213542)"),
          BigText(text: "Female Profiles (213542)"),
          BigText(text: "Pending Profiles New (213542)"),
        ],
      ),
    );
  }
}
