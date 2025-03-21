import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globalVars.dart';

class Great2 extends StatefulWidget {
  const Great2({Key? key}) : super(key: key);

  @override
  State<Great2> createState() => _ReligionState();
}

class _ReligionState extends State<Great2> {
  int value = 0;

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Great!",
                  style: TextStyle(
                      fontSize: 30,
                      color: main_color,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'According to your preference',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "A match recently joined CoupleMatch",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
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
            ElevatedButton(
                onPressed: () async {
                  /*Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AboutMe()));
                */
                },
                child: Text(
                  "View Profile",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white),
                      //Size: Size.fromWidth(500),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white))),
          ],
        ),
      ),
    );
  }
}
