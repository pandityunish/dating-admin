// // ignore: file_names
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../Assets/Error.dart';
// import '../../Assets/G_Sign.dart';
// import '../../Assets/box.dart';
// import '../../Assets/caldener.dart';
// import '../../Assets/calender.dart';
// import '../../Assets/defaultAlgo/profileMatch.dart';
// import '../../globalVars.dart' as glb;
// import '../../models/country.dart';
// import '../../models/user_model.dart';
// import '../../sendUtils/notiFunction.dart';
// import '../Search_profile/locationSearch.dart';
// import '../data_collection/congo.dart';
// import '../navigation/kundli_match.dart';
// import 'buttons.dart';
// import 'imageslider.dart';
// import 'dart:io';

// import 'tempchat.dart';

// // ignore: must_be_immutabl/e
// class ProfilePageActivity extends StatefulWidget {
//   ProfilePageActivity({
//     super.key,
//     required this.userSave,
//     this.type = "",
//   });
//   User? userSave = User();
//   String type;
//   @override
//   State<ProfilePageActivity> createState() => _ProfilePageActivityState();
// }

// class _ProfilePageActivityState extends State<ProfilePageActivity>
//     with WidgetsBindingObserver {
//   // ignore: prefer_typing_uninitialized_variables
//   var matchValue;
//   var age;
//   // ignore: prefer_typing_uninitialized_variables
//   var galleryItems;
//   User userSave = User();
//   ProfileMatch pm = ProfileMatch();
//   SavedPref userSp = SavedPref();
//   late DatabaseReference _dbref;
//   SavedPref defaultSp = SavedPref();

//   var connectivity = '';
//   var tempImage = [
//     "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/Images%2FGroup%20513745.png?alt=media&token=10ab9a8a-eeb6-4057-bd41-80753732489d"
//   ];

//   @override
//   initState() {
//     super.initState();
//     _dbref = FirebaseDatabase.instance.ref();
//     setconnection();

//     matchValue = pm.profileMatch(widget.userSave).toString();
//     setState(() {
//       userSave = (widget.userSave == null) ? User() : widget.userSave!;
//       galleryItems = (userSave.imageUrls == null || userSave.imageUrls!.isEmpty)
//           ? tempImage
//           : userSave.imageUrls;
//     });
//     setSavedPreferences();
//     setDefaultPreference();
//     WidgetsBinding.instance.addObserver(this);
//     connectivityCheck();
//   }

//   Future<double> getDistanceBetweenLocations(
//       double startLat, double startLong, double endLat, double endLong) async {
//     double distanceInMeters =
//         await Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
//     double distanceInKm = distanceInMeters / 1000;
//     return distanceInKm;
//   }

//   setconnection() {
//     _dbref = _dbref.child("onlineStatus");
//     _dbref.child(widget.userSave!.uid!).onValue.listen((event) {
//       // var values = event.snapshot.value as Map<dynamic, dynamic>;
//       try {
//         var res = event.snapshot.child('status').value;
//         // connectivity = values[0]['status'];
//         // List<Map<dynamic, dynamic>> updatedList = [];
//         // connectivity = snapshot.ValueKey('status');
//         // print(res.toString());

//         setState(() {
//           connectivity = res.toString();
//         });
//       } catch (e) {
//         print(e);
//       }
//     });
//   }

//   Future<void> setSavedPreferences() async {
//     var doc = await FirebaseFirestore.instance
//         .collection("saved_pref")
//         .doc(widget.userSave!.uid)
//         .get();
//     setState(() {
//       userSp = SavedPref.fromdoc(doc);
//     });
//   }

//   String? distance;
//   setDefaultPreference() async {
//     DateTime dob = DateTime.fromMillisecondsSinceEpoch(userSave.dob!);
//     var temp = calculateAge(dob);
//     // print(userSave.dob);
//     setState(() {
//       age = temp;
//     });
// //age condition
//     if (widget.userSave!.gender == 'male') {
//       if (age <= 24) {
//         defaultSp.AgeList.add('18');
//       } else {
//         defaultSp.AgeList.add((age - 6).toString());
//       }
//       defaultSp.AgeList.add(age.toString());
//     } else {
//       if (age >= 21) {
//         defaultSp.AgeList.add(age.toString());
//         defaultSp.AgeList.add((age + 6).toString());
//       } else {
//         defaultSp.AgeList.add('21');
//         defaultSp.AgeList.add('26');
//       }
//     }
//     if (widget.userSave!.Disability == "Normal") {
//       defaultSp.DisabilityList.add("Normal");
//     } else {
//       defaultSp.DisabilityList.add("Any");
//     }
//     if (widget.userSave!.Diet == "Vegetarian") {
//       defaultSp.dietList.add("Vegetarian");
//     } else {
//       defaultSp.dietList.add("Any");
//     } //forheight list
//     var highttemp = widget.userSave!.Height!.split(" ");
//     var ft;
//     var inc;
//     if (highttemp[1] == "ft") {
//       inc = double.parse(highttemp[2]);
//     } else {
//       highttemp = widget.userSave!.Height!.split(".");
//       inc = double.parse(highttemp[1].split(" ")[0]);
//     }
//     // print(highttemp[0]);
//     ft = double.parse(highttemp[0]);

//     var height = ft + inc / 12;
//     if (widget.userSave!.gender == 'male') {
//       if (height < 3.6) {
//         defaultSp.HeightList.add("3.0");
//       } else {
//         defaultSp.HeightList.add((height - 0.6).toStringAsFixed(1));
//       }
//       defaultSp.HeightList.add(height.toStringAsFixed(1));
//     } else {
//       defaultSp.HeightList.add(height.toStringAsFixed(1));
//       if (height > 7.4) {
//         defaultSp.HeightList.add("8.0");
//       } else {
//         defaultSp.HeightList.add((height + 0.6).toStringAsFixed(1));
//       }
//     }
//     defaultSp.ReligionList.add(widget.userSave!.religion!);
//     defaultSp.KundaliDoshList.add("Any");
//     defaultSp.MaritalStatusList.add("Any");

//     defaultSp.EducationList.add("Any");
//     defaultSp.HeightList.add("Any");
//     defaultSp.IncomeList.add("Any");
//     defaultSp.LocatioList.add("Any");
//     defaultSp.ProfessionList.add("Any");
//     defaultSp.DrinkList.add("Any");
//     defaultSp.SmokeList.add("Any");
//     defaultSp.HeightList.add("Any");

//     var dist = await getDistanceBetweenLocations(
//         glb.userSave.latitude!,
//         glb.userSave.longitude!,
//         widget.userSave!.latitude!,
//         widget.userSave!.longitude!);

//     distance = dist.toStringAsFixed(2); // print(glb.userSave.latitude);
//     // print(glb.userSave.longitude);
//     // print(userSave.longitude);
//     // print(userSave.latitude);
//     // distance = await getDistanceBetweenLocations(
//     //     28.2090551, 78.2561578, 29.947631, 76.8197412);
//   }

//   calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     int month1 = currentDate.month;
//     int month2 = birthDate.month;
//     if (month2 > month1) {
//       age--;
//     } else if (month1 == month2) {
//       int day1 = currentDate.day;
//       int day2 = birthDate.day;
//       if (day2 > day1) {
//         age--;
//       }
//     }
//     return age;
//   }

//   savedPrefCard(boxname, imgicon, defaultText) {
//     // print(boxname.toString());
//     return Box(
//       box_text: (boxname.isEmpty)
//           ? (defaultText.length > 1)
//               ? "${defaultText[0]} +${defaultText.length - 1}}"
//               : defaultText[0]
//           : (boxname.length > 1)
//               ? "${boxname[0]} +${boxname.length - 1}"
//               : boxname[0],
//       icon: imgicon,
//     );
//   }

//   ageCard(boxname, imgicon, defaultText) {
//     // print(boxname.toString());
//     return Box(
//       box_text: (boxname.isEmpty)
//           ? (defaultText.length > 1)
//               ? "${defaultText[0]} - ${defaultText[1]} "
//               : ""
//           : (boxname.length > 1)
//               ? "${boxname[0]} - ${boxname[1]}"
//               : '',
//       icon: imgicon,
//     );
//   }

//   heightard(boxname, imgicon, defaultText) {
//     // print(boxname.toString());
//     return Box(
//       box_text: (boxname.isEmpty)
//           ? (defaultText.length > 1)
//               ? "${defaultText[0]} - ${defaultText[1]} feet "
//               : ""
//           : (boxname.length > 1)
//               ? "${boxname[0]} - ${boxname[1]} feet"
//               : '',
//       icon: imgicon,
//     );
//   }

//   void setStatus(status) async {
//     // await FirebaseFirestore.instance
//     //     .collection('user_data')
//     //     .doc(glb.uid)
//     //     .update({"connectivity": status});
//     NotificationFunction.setonlineStatus(glb.uid, status);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setStatus("Online");
//     } else {
//       setStatus("Resumed");
//     }
//   }

//   var _selectedDate;
//   var _age;

//   // void _showDatePicker() async {
//   //   final DateTime? picked = await showDatePicker(
//   //       context: context,
//   //       initialDate: DateTime.now(),
//   //       firstDate: DateTime(1900),
//   //       lastDate: DateTime.now());
//   //   if (picked != null && picked != _selectedDate) {
//   //     setState(() {
//   //       _selectedDate = picked;
//   //       _age = calculateAge(_selectedDate);
//   //     });
//   //   }
//   // }

//   // int calculateAge(DateTime birthDate) {
//   //   DateTime today = DateTime.now();
//   //   int age = today.year - birthDate.year;
//   //   if (today.month < birthDate.month ||
//   //       (today.month == birthDate.month && today.day < birthDate.day)) {
//   //     age--;
//   //   }
//   //   return age;
//   // }

//   connectivityCheck() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         // ignore: avoid_print
//       }
//     } on SocketException catch (_) {
//       print("not connected");
//       showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) {
//             Future.delayed(const Duration(seconds: 1), () {
//               Navigator.of(context).pop(true);
//             });
//             return AlertDialog(
//               content: SnackBarContent(
//                 error_text: "No Internet Connection",
//                 appreciation: "",
//                 icon: Icons.error_rounded,
//                 sec: 10000,
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             );
//           });
//     }
//   }

//   List<Widget> _createImgList() {
//     if (galleryItems == null) {
//       return [const Text("image not found")];
//     } else {
//       return List<Widget>.generate(galleryItems.length, (int index) {
//         return Image.network(
//           galleryItems[index],
//           fit: BoxFit.cover,
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Object>(
//         stream: FirebaseFirestore.instance.collection('user_data').snapshots(),
//         builder: (BuildContext context, snapshot) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//                 body: Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(color: Colors.white),
//                   child: Stack(
//                     children: [
//                       SingleChildScrollView(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(children: [
//                               SizedBox(
//                                 // height:
//                                 // MediaQuery.of(context).size.height * 0.42,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.47,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: GestureDetector(
//                                   child: ImageSlideshow(
//                                       indicatorRadius: 5,
//                                       initialPage: 0,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.25,
//                                       width: MediaQuery.of(context).size.width,

//                                       /// The color to paint the indicator.
//                                       indicatorColor: glb.main_color,
//                                       isLoop: true,
//                                       children:
//                                           _createImgList() //returns list of images

//                                       ),
//                                   onTap: () {
//                                     NotificationFunction.setNotification(
//                                       "admin",
//                                       "${glb.userSave.name!.substring(0, 1)} ${glb.userSave.surname} ${glb.userSave.uid?.substring(userSave.uid!.length - 5)} SEEN PHOTO ${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave.uid!.length - 5)} PROFILE ",
//                                       'profileseen',
//                                     );
//                                     NotificationFunction.setNotification(
//                                         "user2",
//                                         "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1)} ${glb.userSave.surname} ${glb.userSave.uid?.substring(userSave.uid!.length - 5)}",
//                                         'profileseen',
//                                         useruid: userSave.uid!);
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ImageSliderPopUp(
//                                                   galleryItems: galleryItems,
//                                                 )));
//                                   },
//                                 ),
//                               ),
//                               Positioned(
//                                 left: 0,
//                                 bottom: 8,
//                                 child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             margin:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               "${userSave.name!.substring(0, 1)} ${userSave.surname}",
//                                               style: const TextStyle(
//                                                 fontFamily: "Sans-serif",
//                                                 fontSize: 20,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w700,
//                                                 shadows: <Shadow>[
//                                                   Shadow(
//                                                       color: Colors.black,
//                                                       blurRadius: 33.0)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           // const SizedBox(
//                                           //   width: 2,
//                                           // ),
//                                           Container(
//                                             margin:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               age.toString(),
//                                               style: const TextStyle(
//                                                 fontFamily: "Sans-serif",
//                                                 fontSize: 14,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w700,
//                                                 shadows: <Shadow>[
//                                                   Shadow(
//                                                       color: Colors.black,
//                                                       blurRadius: 33.0)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 8,
//                                           ),
//                                           Image.asset(
//                                             'assets/flags/${(userSave.Location != "" && userSave.Location != null) ? countryCode(userSave.Location!.split(' ')[userSave.Location!.split(' ').length - 1]).toLowerCase() : countryCode("India").toLowerCase()}.png',
//                                             package: 'intl_phone_field',
//                                             width: 20,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           (userSave.verifiedStatus ==
//                                                   "verified")
//                                               ? Icon(
//                                                   Icons.verified_user,
//                                                   color: glb.main_color,
//                                                   size: 16,
//                                                 )
//                                               : Container(),
//                                         ],
//                                       ),
//                                       Container(
//                                         margin: const EdgeInsets.only(left: 5),
//                                         child: Row(children: [
//                                           const Icon(
//                                             Icons.location_on,
//                                             color: Color(0xFF38B9F4),
//                                             shadows: <Shadow>[
//                                               Shadow(
//                                                   color: Colors.black,
//                                                   blurRadius: 5.0)
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             (distance != null ||
//                                                     distance != 0.0)
//                                                 ? "${distance} Km"
//                                                 : "70Km",
//                                             style: const TextStyle(
//                                               fontFamily: "Sans-serif",
//                                               fontSize: 14,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w300,
//                                               shadows: <Shadow>[
//                                                 Shadow(
//                                                     color: Colors.black,
//                                                     blurRadius: 5.0)
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             (userSave.Location == null ||
//                                                     userSave.Location == "")
//                                                 ? ""
//                                                 : userSave.Location!
//                                                     .split(' ')[0]
//                                                     .substring(
//                                                         0,
//                                                         userSave.Location!
//                                                                 .split(' ')[0]
//                                                                 .length -
//                                                             1),
//                                             style: const TextStyle(
//                                               fontFamily: "Sans-serif",
//                                               fontSize: 14,
//                                               color: Colors.white,
//                                               // color: Colors.white,
//                                               fontWeight: FontWeight.w400,
//                                               shadows: <Shadow>[
//                                                 Shadow(
//                                                     color: Colors.black,
//                                                     blurRadius: 5.0)
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           ClipOval(
//                                             child: Container(
//                                               width: 9,
//                                               height: 9,
//                                               decoration: BoxDecoration(
//                                                   color: (connectivity ==
//                                                           "Online")
//                                                       ? const Color(0xFF00FF19)
//                                                       : (connectivity ==
//                                                               "Resumed")
//                                                           ? const Color
//                                                                   .fromARGB(
//                                                               255, 255, 208, 0)
//                                                           : const Color(
//                                                               0xFFBDBDBD)
//                                                   // color: Color(0xFF33D374)),
//                                                   // color: if(userSave.connectivity == "Online"){Color(0xFF00FF19)}else if(userSave.connectivity == "Offline"){Color(0xFFBDBDBD)} else{Color(0xFFDBFF00)}
//                                                   ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           (userSave.uid != glb.uid)
//                                               ? Container(
//                                                   width: 28,
//                                                   height: 28,
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           color: Colors.white),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Text(
//                                                         "${matchValue}%",
//                                                         style: const TextStyle(
//                                                           fontSize: 10,
//                                                           fontFamily:
//                                                               "Sans-serif",
//                                                         ),
//                                                       ),
//                                                       const Text(
//                                                         "Match",
//                                                         style: TextStyle(
//                                                           fontSize: 5,
//                                                           fontFamily:
//                                                               "Sans-serif",
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 )
//                                               : Container(),
//                                         ]),
//                                       ),
//                                     ]),
//                               ),
//                             ]),
//                             // SizedBox(
//                             //   height: MediaQuery.of(context).size.height * 0.01,
//                             // ),

//                             //****Scrollable*/
//                             //
//                             Container(
//                               // height: MediaQuery.of(context).size.height * 0.49,
//                               height: MediaQuery.of(context).size.height * 0.42,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     // crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         margin: const EdgeInsets.only(left: 28),
//                                         child: Text(
//                                           "${userSave.name!.substring(0, 1)} ${userSave.surname}",
//                                           style: TextStyle(
//                                             fontFamily: "Sans-serif",
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700,
//                                             color: glb.main_color,
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         margin:
//                                             const EdgeInsets.only(right: 28),
//                                         child: Text(
//                                           "Profile ID- ${userSave.uid!.substring(userSave.uid!.length - 5)}",
//                                           style: const TextStyle(
//                                             fontFamily: "Sans-serif",
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Color(0xFF38B9F4),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   // SizedBox(
//                                   //   height: MediaQuery.of(context).size.height *
//                                   //       0.007,
//                                   // ),

//                                   Stack(
//                                       //expandable text
//                                       children: [
//                                         Container(
//                                           // width: MediaQuery.of(context).size.width * 1,
//                                           margin: const EdgeInsets.only(
//                                             left: 28,
//                                             right: 0,
//                                           ),
//                                           child: Wrap(
//                                             // alignment:WrapAlignment.spaceBetween,
//                                             children: [
//                                               SizedBox(
//                                                 height: MediaQuery.of(context)
//                                                         .size
//                                                         .height *
//                                                     0.04,
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width,
//                                               ),
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.of(context).push(
//                                                       MaterialPageRoute(
//                                                           builder: (builder) =>
//                                                               ChatPagetemp()));
//                                                   // Navigator.of(context).push(
//                                                   //     MaterialPageRoute(
//                                                   //         builder: (builder) =>
//                                                   //             Calender(
//                                                   //               useTwentyOneYears:
//                                                   //                   true,
//                                                   //             )));
//                                                 },
//                                                 child: Box(
//                                                     // width: userSave.religion!.length * 15.5,
//                                                     box_text: userSave.religion,
//                                                     icon:
//                                                         'images/icons/religion.png'),
//                                               ),
//                                               Box(
//                                                 // width: userSave.KundaliDosh!.length * 15.5,
//                                                 box_text: userSave.KundaliDosh,
//                                                 icon: 'images/icons/kundli.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.MartialStatus!.length * 15.5,
//                                                 box_text:
//                                                     userSave.MartialStatus,
//                                                 icon:
//                                                     'images/icons/marital_status.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Height!.length * 15.5,
//                                                 box_text: userSave.Height,
//                                                 icon: 'images/icons/height.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Diet!.length * 15.5,
//                                                 box_text: userSave.Diet,
//                                                 icon: 'images/icons/food.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Education!.length * 15.5,
//                                                 box_text: userSave.Education,
//                                                 icon:
//                                                     'images/icons/education.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Profession!.length * 15.5,
//                                                 box_text: userSave.Profession,
//                                                 icon:
//                                                     'images/icons/profession_suitcase.png',
//                                               ),
//                                               Box(
//                                                 // width: (userSave.Location!.split(' ')[0].length - 1) *
//                                                 //     15.5,
//                                                 box_text: (userSave.Location ==
//                                                             null ||
//                                                         userSave.Location == "")
//                                                     ? ""
//                                                     : userSave.Location!
//                                                         .split(' ')[0]
//                                                         .substring(
//                                                             0,
//                                                             userSave.Location!
//                                                                     .split(
//                                                                         ' ')[0]
//                                                                     .length -
//                                                                 1),
//                                                 icon:
//                                                     'images/icons/location_home.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Profession!.length * 15.5,
//                                                 box_text: userSave.Drink,
//                                                 icon: 'images/icons/drink.png',
//                                               ),
//                                               Box(
//                                                 // width: userSave.Profession!.length * 15.5,
//                                                 box_text: userSave.Smoke,
//                                                 icon: 'images/icons/smoke.png',
//                                               ),
//                                               (userSave.Disability == 'Normal')
//                                                   ? Container(width: 0)
//                                                   : Box(
//                                                       // width: userSave.Profession!.length * 15.5,
//                                                       box_text:
//                                                           userSave.Disability,
//                                                       icon:
//                                                           'images/icons/disability.png',
//                                                     ),
//                                               Box(
//                                                 // width: userSave.Profession!.length * 15.5,
//                                                 box_text: userSave.Income,
//                                                 icon:
//                                                     'images/icons/hand_rupee.png',
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           // width: MediaQuery.of(context).size.width,
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(8.0),
//                                               boxShadow: const [
//                                                 BoxShadow(blurRadius: 0.05)
//                                               ]),
//                                           margin: const EdgeInsets.only(
//                                             left: 28,
//                                             right: 0,
//                                           ),
//                                           padding: const EdgeInsets.only(
//                                               left: 7,
//                                               right: 7,
//                                               top: 7,
//                                               bottom: 7),
//                                           child: ExpandableText(
//                                             (userSave.About_Me == null ||
//                                                     userSave.About_Me == "")
//                                                 ? "hi welcome to my profile i am a professional software engineer with a sallary of 3 lakh and living in west dehli. i am a non manglik and non veg person. i occasionally smoke and newer drink any kind of alcohol"
//                                                 : (userSave.About_Me!.length <
//                                                         40)
//                                                     ? "${userSave.About_Me} ................................................................................................................."
//                                                     : userSave.About_Me!,
//                                             collapseText: 'Less',
//                                             linkColor: glb.main_color,
//                                             expandText: 'More',
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                       ]),

//                                   //interested in marraige with
//                                   Container(
//                                     margin: const EdgeInsets.only(left: 28),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Partner Preferences",
//                                           // textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                               fontFamily: "Sans-serif",
//                                               fontSize: 20,
//                                               color: glb.main_color,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   // SizedBox(
//                                   //   height: MediaQuery.of(context).size.height *
//                                   //       0.002,
//                                   // ),

//                                   Stack(
//                                     children: [
//                                       //expandable text
//                                       Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               1,
//                                           margin: const EdgeInsets.only(
//                                             left: 28,
//                                             right: 0,
//                                           ),
//                                           child: Wrap(children: [
//                                             SizedBox(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   0.04,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                             ),
//                                             // const Box(
//                                             //   // width: userSave.Profession!.length * 15.5,
//                                             //   box_text: '18 - 36',
//                                             //   icon: 'images/icons/calender.png',
//                                             // ),
//                                             ageCard(
//                                                 userSp.AgeList,
//                                                 'images/icons/calender.png',
//                                                 defaultSp.AgeList),
//                                             // const Box(
//                                             //   box_text: 'Hindu +2 more',
//                                             //   icon: 'images/icons/religion.png',
//                                             // ),
//                                             savedPrefCard(
//                                                 userSp.ReligionList,
//                                                 'images/icons/religion.png',
//                                                 defaultSp.ReligionList),
//                                             savedPrefCard(
//                                                 userSp.KundaliDoshList,
//                                                 'images/icons/kundli.png',
//                                                 defaultSp.KundaliDoshList),
//                                             savedPrefCard(
//                                                 userSp.MaritalStatusList,
//                                                 'images/icons/marital_status.png',
//                                                 defaultSp.MaritalStatusList),

//                                             heightard(
//                                                 userSp.HeightList,
//                                                 'images/icons/height.png',
//                                                 defaultSp.HeightList),
//                                             savedPrefCard(
//                                                 userSp.dietList,
//                                                 'images/icons/food.png',
//                                                 defaultSp.dietList),
//                                             savedPrefCard(
//                                                 userSp.EducationList,
//                                                 'images/icons/education.png',
//                                                 defaultSp.EducationList),
//                                             savedPrefCard(
//                                                 userSp.ProfessionList,
//                                                 'images/icons/profession_suitcase.png',
//                                                 defaultSp.ProfessionList),
//                                             savedPrefCard(
//                                                 userSp.LocatioList,
//                                                 'images/icons/location.png',
//                                                 defaultSp.LocatioList),
//                                             savedPrefCard(
//                                                 userSp.DrinkList,
//                                                 'images/icons/drink.png',
//                                                 defaultSp.DrinkList),
//                                             savedPrefCard(
//                                                 userSp.SmokeList,
//                                                 'images/icons/smoke.png',
//                                                 defaultSp.SmokeList),
//                                             (userSave.Disability == "Normal")
//                                                 ? Container(width: 0)
//                                                 : savedPrefCard(
//                                                     userSp.DisabilityList,
//                                                     'images/icons/disability.png',
//                                                     defaultSp.DisabilityList),
//                                             savedPrefCard(
//                                                 userSp.IncomeList,
//                                                 'images/icons/hand_rupee.png',
//                                                 defaultSp.IncomeList),
//                                           ])),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(8.0),
//                                             boxShadow: const [
//                                               BoxShadow(blurRadius: 0.05)
//                                             ]),
//                                         margin: const EdgeInsets.only(
//                                           left: 28,
//                                           right: 0,
//                                         ),
//                                         padding: const EdgeInsets.only(
//                                             left: 7,
//                                             right: 7,
//                                             top: 7,
//                                             bottom: 7),
//                                         child: ExpandableText(
//                                           (userSave.Partner_Prefs == null ||
//                                                   userSave.Partner_Prefs == "")
//                                               ? "i am looking for a caring and loving guy. it does not drink and smoke"
//                                               : (userSave.Partner_Prefs!
//                                                           .length <
//                                                       40)
//                                                   ? "${userSave.Partner_Prefs} ................................................................................................................."
//                                                   : userSave.About_Me!,
//                                           collapseText: 'Less',
//                                           // linkColor: Colors.red,
//                                           expandText: 'More',
//                                           linkColor: glb.main_color,
//                                           maxLines: 1,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.011,
//                                   ),

//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 (userSave.uid != glb.uid)
//                     ? Positioned(
//                         top: MediaQuery.of(context).size.height * 0.87,
//                         child: Pbuttons(
//                           profileData: userSave,
//                         ),
//                       )
//                     : Container(),
//                 Positioned(
//                   left: MediaQuery.of(context).size.width * 0.05,
//                   top: MediaQuery.of(context).size.height * 0.04,
//                   child: IconButton(
//                     icon: const Icon(
//                       // Icons.more_vert_outlined,//for three dots
//                       Icons.arrow_back_ios, //for three lines
//                       size: 20,
//                       color: Colors.white,
//                       shadows: <Shadow>[
//                         Shadow(color: Colors.black, blurRadius: 15.0)
//                       ],
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//               ],
//             )),
//           );
//         });
//   }
// }
