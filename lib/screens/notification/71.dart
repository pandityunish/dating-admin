import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globalVars.dart';

class Accepted extends StatefulWidget {
  const Accepted({Key? key}) : super(key: key);

  @override
  State<Accepted> createState() => _ReligionState();
}

class _ReligionState extends State<Accepted> {
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
                  "Congratulations!",
                  style: TextStyle(
                      fontSize: 30,
                      color: main_color,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Your request to connect has been',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Accepted by N Dua",
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
                  "Chat Now",
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
