import 'package:flutter/material.dart';

import '../../globalVars.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
      TextSpan(
          text: "Free",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Showg")),
      TextSpan(
          text: "rishteywala",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: main_color,
              fontFamily: "Showg")),
      // TextSpan(
      //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
    ]));
  }
}
