import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../globalVars.dart';

class Match extends StatefulWidget {
  const Match({Key? key}) : super(key: key);

  @override
  State<Match> createState() => _ReligionState();
}

class _ReligionState extends State<Match> {
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
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "It's a match!",
                  style: TextStyle(
                      fontSize: 30,
                      color: main_color,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'You have accepted N Dua',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Connect Request",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💓',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                        '                                                                                ')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //for (int i = 0; i < 2; i++)
                    Align(
                      widthFactor: 0.8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 57,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/id/65/200/300'),
                        ),
                      ),
                    ),
                    Align(
                      widthFactor: 0.8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 57,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/id/65/200/300'),
                        ),
                      ),
                    ),
                  ],
                ),
                /*CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 57,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/65/200/300'),
                  ),
                )*/
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '💓',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                        '                                                                           ')
                  ],
                ),
                /*SizedBox(
                  height: 20,
                ),*/
                Text(
                  " Now you can connect",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
