import 'package:flutter/material.dart';

import '../../globalVars.dart';

class Decline extends StatefulWidget {
  const Decline({Key? key}) : super(key: key);

  @override
  State<Decline> createState() => _ReligionState();
}

class _ReligionState extends State<Decline> {
  int value = 0;

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your request to connect has been',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Declined by N Dua",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 77,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/65/200/300'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "N Dua",
                    style: TextStyle(color: main_color, fontSize: 25),
                  ),
                  Text(
                    "CMF10210",
                    style: TextStyle(color: main_color, fontSize: 25),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
