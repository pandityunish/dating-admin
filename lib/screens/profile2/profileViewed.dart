import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';

import '../../globalVars.dart';

class pViewed extends StatefulWidget {
  const pViewed({Key? key}) : super(key: key);

  @override
  State<pViewed> createState() => _ReligionState();
}

class _ReligionState extends State<pViewed> {
  int value = 0;
  bool pressed = false;
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.lightBlue, //change your color here
        ),
        title: Text("Profile Viewed",
            style: GoogleFonts.poppins(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        /*bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
                child: TextButton(
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
              },
              child: Container(
                //margin: const EdgeInsets.all(8),
                //height: 100,
                width: 340,
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(15),
                // ),
                alignment: Alignment.center,
                child: Text(
                  'Blocked',
                  style: pressed
                      ? TextStyle(
                          color: main_color,
                          fontSize: 18,
                        )
                      : TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                ),
              ),
            )),
          ],
        ),*/
      ),
      body: Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    'Shortlisted me',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 210,
                  alignment: Alignment.center,
                  child: Text(
                    'Shortlisted By Me',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    'Profile Viewed',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    'Profile Viewer',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Sent',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Recieved',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 210,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Accepted by User',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 210,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Accepted by Me',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 210,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Declined by User',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 210,
                  alignment: Alignment.center,
                  child: Text(
                    'Request Declined by Me',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Block Profiles',
                    style: pressed
                        ? TextStyle(
                            color: main_color,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
