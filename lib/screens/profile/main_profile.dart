// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dating App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,

//         children: [

//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [

//               Icon(FontAwesomeIcons.user, size: 24, color:  Colors.black,),
//               Spacer()
//             ],
//           )
//         ],
//       ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

// import 'ProfilePage.dart';
import 'profileScroll.dart';

class main_profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoupleMatch App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SlideProfile()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.95,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                        left: 30,
                        right: 30),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.userAlt,
                              size: 24,
                              color: Colors.blue,
                            ),
                            Spacer(),
                            Text(
                              "Profile Image",
                              style: TextStyle(
                                  fontFamily: "Proxima-Nova-Extrabold",
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(
                              FontAwesomeIcons.facebookMessenger,
                              size: 24,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/main_actor.jpg"))),
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 0,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25)),
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFFF)
                                                  .withOpacity(0.8)),
                                          child: Container(
                                            margin: EdgeInsets.all(22),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ram Prasad, 23",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Proxima-Nova-Extrabold",
                                                      fontSize: 22,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Actor in Bollywood",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "ProximaNova-Regular",
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: FloatingActionButton(
                    heroTag: "cross",
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    elevation: 10,
                    // child: Icon(
                    //     // LineIcons.close,
                    //     // color: Color(0xFFA29FBE),
                    //     // size: 28,
                    //     ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.44,
                  child: FloatingActionButton(
                    onPressed: () {},
                    heroTag: "love",
                    backgroundColor: Colors.white,
                    elevation: 10,
                    child: Icon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFF4DD5FF),
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  right: MediaQuery.of(context).size.width * 0.15,
                  child: FloatingActionButton(
                    onPressed: () {},
                    heroTag: "heart",
                    backgroundColor: Colors.white,
                    elevation: 10,
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Color(0xFFFF636B),
                      size: 24,
                    ),
                  ),
                )
              ],
            )));
  }
}
