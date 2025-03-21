
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/models/match_model2.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KundaliMatchData3Screen extends StatefulWidget {
  final String boydob;
  final String boytob;
  final double boylat;
  final double boyon;
  final String boyname;
  final String girlname;
   final String girldob;
   final String gunpoint;
  final String girltob;
  final double girllat;
  final double girlon;
  const KundaliMatchData3Screen({
    Key? key, required this.boydob, required this.boytob, required this.boylat, required this.boyon, required this.girldob, required this.girltob, required this.girllat, required this.girlon, required this.boyname, required this.girlname, required this.gunpoint,
   
  }) : super(
          key: key,
        );

  

  @override
  KundaliMatchData3ScreenState createState() => KundaliMatchData3ScreenState();
}

class KundaliMatchData3ScreenState extends State<KundaliMatchData3Screen> {
  var data;
Match2? match2;

String? manglikornotboy;
String? manglikornotgirl;
String determineManglikStatus(int score) {
  if (score < 30) {
    return "MANGLIK";
  } else if (score >= 30 && score <= 50) {
    return " ANSHIK MANGLIK";
  } else if (score > 50) {
    return "NON-MANGLIK";
  }
  return "Manglik";
}
  Future<void> sendPostRequest() async {
   match2=await HomeService().getusermatch2(boydob:widget. boydob, boytob: widget.boytob, boylat:widget. boylat, boyon:widget. boyon);
   setState(() {
     
   });

manglikornotboy= determineManglikStatus(match2!.response.score);
  setState(() {
    
  });
  }
Match2? matchgirl;
  Future<void> sendPostRequestgirl() async {
   matchgirl=await HomeService().getusermatch2(boydob:widget. girldob, boytob: widget.girltob, boylat:widget. girllat, boyon:widget. girlon);
   setState(() {
     
   });
 
  manglikornotgirl=determineManglikStatus(matchgirl!.response.score);
  setState(() {
    
  });
  }
  @override
  initState() {
    sendPostRequest();
    sendPostRequestgirl();
    //   print(
    //     widget.m_day,
    //   );
    //   print(widget.m_hour);
    //   // print(widget.m_hour);
    //   print(widget.m_lon);
    //   print(widget.m_lat);
    //   print(widget.m_min);
    //   print(widget.m_month);
    //   print(widget.m_name);
    //   // print(widget.m_name);
    //   print(widget.m_tzone);
    //   print(widget.m_year);
    //   print(widget.m_gender);
    //   print(widget.m_place);
    //   print(widget.m_sec);

    //   print(
    //     widget.f_day,
    //   );
    //   print(widget.f_hour);
    //   // print(widget.f_hour);
    //   print(widget.f_lon);
    //   print(widget.f_lat);
    //   print(widget.f_min);
    //   print(widget.f_month);
    //   print(widget.f_name);
    //   // print(widget.m_name);
    //   print(widget.f_tzone);
    //   print(widget.f_year);
    //   print(widget.f_gender);
    //   print(widget.f_place);
    //   print(widget.f_sec);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Display Data from Server'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ElevatedButton(
    //           onPressed: sendPostRequest,
    //           child: const Text('Send POST Request'),
    //         ),
    //         if (data != null)
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Text(
    //               'Data from Server: ${data['manglik']['male_manglik_dosha']}',
    //               style: const TextStyle(fontSize: 20.0),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          
          middle: Row(
            children: [
              BigText(
                text: "Kundli Match",
                size: 20,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          previousPageTitle: "",
            leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: main_color,
              size: 25,
            ),
          ),
        ),
        child: Container(
          child: Center(
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  //   margin: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                  child: SizedBox(
                    width: 300,
                    height: 70,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.boyname}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: "Serif",
                              color: Colors.black,
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          (manglikornotboy != null)
                              ? Text(
                                  manglikornotboy!, 
                                  style: TextStyle(
                                      fontFamily: "Serif",
                                      color: main_color,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none),
                                )
                              : CircularProgressIndicator(
                                  color: main_color,
                                ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  //   margin: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                  child: SizedBox(
                    width: 300,
                    height: 70,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.girlname}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: "Serif",
                              color: Colors.black,
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          (manglikornotgirl != null)
                              ? Text(
                                  manglikornotgirl!,
                                  style: TextStyle(
                                      fontFamily: "Serif",
                                      color: main_color,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none),
                                )
                              : CircularProgressIndicator(
                                  color: main_color,
                                ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  //   margin: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                                  "Total Gun Milan ${widget.gunpoint}/36"
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Serif",
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none),
                                )
                              
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
