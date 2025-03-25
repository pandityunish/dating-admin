// ignore: file_names
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony_admin/models/new_save_pref.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profile/date_slide.dart';
import 'package:matrimony_admin/screens/profile/horoscopepage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ticker_text/ticker_text.dart';
import '../navigation/navigator.dart';

import '../../Assets/Error.dart';
import '../../Assets/box.dart';
import '../../Assets/defaultAlgo/profileMatch.dart';
import '../../Assets/sendMessage.dart';
import '../../globalVars.dart' as glb;
import '../../globalVars.dart';
import '../../models/country.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';
// import '../../testing.dart';
import '../notification/navHome.dart';
import '../service/home_service.dart';
import '../service/search_profile.dart';
import 'buttons.dart';
import 'imageslider.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'profile_service.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage(
      {super.key,
      this.index,
      this.userSave,
      // required this.pushchat,
      this.controller,
      this.isDelete,
      this.type = ""});
  NewUserModel? userSave;
  var index;
  String type;
  // Function pushchat;
  var controller;
  var isDelete;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  // ignore: prefer_typing_uninitialized_variables
  var matchValue;
  bool expaned = false;
  var age;
  var city = '';
  var country;
  // ignore: prefer_typing_uninitialized_variables
  var galleryItems;
  int _unreadCount = 0;

  // User userSave = User();
  ProfileMatch pm = ProfileMatch();
  SavedPref userSp = SavedPref();
  late DatabaseReference _dbref;
  late DatabaseReference _dbref5;
  SavedPref defaultSp = SavedPref();

  var connectivity = '';
  var token = '';
  var tempImage = [
    "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2"
  ];
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int numofnoti = 0;
  void getallnumofunreadnoti() async {
    numofnoti = await HomeService().getthenumberofunread();
    setState(() {});
  }

  get R => null;

  SendMessage sendMessage = SendMessage();

  _moreNoti() {
    if (expaned == false) {
      try {
        sendMessage.sendPushMessage(
            "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid}",
            "VIEWED PROFILE",
            widget.userSave!.token,
            "profilepage",
            token);
      } catch (e) {
        print(e);
      }
      expaned = true;
    }
  }

  void setStatus(status) async {
    NotificationFunction.setonlineStatus(userSave.uid!, status);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     setStatus("Online");
  //   } else {
  //     setStatus("Resumed");
  //   }
  // }

  @override
  initState() {
    print("99999999999999999999999");
    print(userSave.latitude);
    getallnumofunreadnoti();
    getdefaultpreference();
    profileComplete();
    // checkBlockedStatus();
    // didChangeAppLifecycleState(AppLifecycleState.resumed);
    super.initState();

    _dbref = FirebaseDatabase.instance.ref();
    _dbref5 = FirebaseDatabase.instance.ref();
    setconnection();
    matchValue = pm.profileMatch(widget.userSave, widget.userSave!).toString();
    setState(() {
      galleryItems = (widget.userSave!.imageurls.isEmpty)
          ? []
          : (widget.userSave!.imageurls.length > 6)
              ? widget.userSave!.imageurls.sublist(0, 6)
              : widget.userSave!.imageurls;
    });
    setLocation();
    // setSavedPreferences();

    setDefaultPreference();
    getdistance();
    WidgetsBinding.instance.addObserver(this);
  }

  // checkBlockedStatus() async {
  //   var doc = FirebaseDatabase.instance.ref().child('block_list');
  //   doc = doc.child(widget.userSave!.aboutme!);
  //   var res = await doc.child(glb.userSave.uid!).get();
  //   print(res);
  //   if (res.exists) {
  //     if (kDebugMode) {
  //       print("true");
  //     }
  //     // await widget.list.removeAt(widget.index);
  //     setState(() {
  //       widget.controller.animateToPage(
  //         widget.index + 1, // The page index you want to navigate to
  //         duration:
  //             Duration(milliseconds: 100), // The duration of the animation
  //         curve: Curves.easeInOut, // The animation curve
  //       );
  //     });
  //   } else {
  //     if (kDebugMode) {
  //       print("false");
  //     }
  //   }
  // }

  setLocation() {
    if (widget.userSave!.Location != "") {
      try {
        setState(() {
          city = userSave.city ?? "";
        });
      } catch (e) {
        print("error in city : $e");
        city = "";
      }
      try {
        setState(() {
          country = widget.userSave!.Location
              .split(' ')[widget.userSave!.Location.split(' ').length - 1];
        });

        print("country : $country");
        print(countryCode(country).toLowerCase());
      } catch (e) {
        print("error in country : $e");
        country = "India";
      }
    } else {
      setState(() {
        city = "";
        country = "India";
      });
    }
    setState(() {});
  }

  var profilePercentage = 50;
  Future<int> profileComplete() async {
    NewSavePrefModel? newSavePrefModel =
        await HomeService().getusersaveprefdata1(widget.userSave!.email);

    if (widget.userSave!.About_Me != null || widget.userSave!.About_Me != "") {
      profilePercentage += 5;
    }
    if (widget.userSave!.Partner_Prefs != null ||
        widget.userSave!.Partner_Prefs != "") {
      profilePercentage += 5;
    }
    if (widget.userSave!.imageurls.isNotEmpty) {
      profilePercentage += 10;
    }
    if (widget.userSave!.status == "approved") {
      profilePercentage += 10;
    }
    if (newSavePrefModel != null) {
      profilePercentage += 5;
    }
    if (widget.userSave!.verifiedstatus == "verified") {
      profilePercentage += 15;
    }
    setState(() {});
    return profilePercentage;
  }

  Future<double> getDistanceBetweenLocations(
      double startLat, double startLong, double endLat, double endLong) async {
    double distanceInMeters =
        await Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  setconnection() {
    _dbref = _dbref.child("onlineStatus");
    _dbref5 = _dbref5.child("token");
    _dbref.child(widget.userSave!.id).onValue.listen((event) {
      try {
        var res = event.snapshot.child('status').value;
        setState(() {
          connectivity = res.toString();
        });
      } catch (e) {
        print(e);
      }
    });
    _dbref5.child(widget.userSave!.id).onValue.listen((event) {
      try {
        var res = event.snapshot.child('token').value;
        setState(() {
          token = res.toString();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  // Future<void> setSavedPreferences() async {
  //   var doc = await FirebaseFirestore.instance
  //       .collection("saved_pref")
  //       .doc(widget.userSave!.aboutme)
  //       .get();
  //   setState(() {
  //     userSp = SavedPref.fromdoc(doc);
  //   });
  // }
  NewSavePrefModel? newSavePrefModel;
  void getdefaultpreference() async {
    newSavePrefModel = await HomeService().getsavepref(widget.userSave!.email);
    setState(() {});
    print(newSavePrefModel);
  }

  String? distance;
  setDefaultPreference() async {
    DateTime dob = DateTime.fromMillisecondsSinceEpoch(widget.userSave!.dob);
    var temp = calculateAge(dob);
    // print(userSave.dob);
    setState(() {
      age = temp;
    });
//age condition
    if (widget.userSave!.gender == 'male') {
      if (age <= 24) {
        defaultSp.AgeList.add('18');
      } else {
        defaultSp.AgeList.add((age - 6).toString());
      }
      defaultSp.AgeList.add(age.toString());
    } else {
      if (age >= 21) {
        defaultSp.AgeList.add(age.toString());
        defaultSp.AgeList.add((age + 6).toString());
      } else {
        defaultSp.AgeList.add('21');
        defaultSp.AgeList.add('26');
      }
    }
    if (widget.userSave!.Disability == "Normal") {
      defaultSp.DisabilityList.add("Normal");
    } else {
      defaultSp.DisabilityList.add("Any");
    }
    if (widget.userSave!.Diet == "Vegetarian") {
      defaultSp.dietList.add("Vegetarian");
    } else {
      defaultSp.dietList.add("Any");
    } //forheight list
    var highttemp = widget.userSave!.Height!.split(" ");
    var ft;
    var inc;
    print(highttemp);
    if (highttemp[0] == "ft") {
      inc = double.parse(highttemp[2]);
    } else {
      highttemp = widget.userSave!.Height!.split(".");
      inc = double.parse(highttemp[0].split(" ")[0]);
    }
    print(highttemp[0]);
    ft = double.parse(highttemp[0]);

    var height = ft + inc / 12;
    if (widget.userSave!.gender == 'male') {
      if (height < 3.6) {
        defaultSp.HeightList.add("3.0");
      } else {
        defaultSp.HeightList.add((height - 0.6).toStringAsFixed(1));
      }
      defaultSp.HeightList.add(height.toStringAsFixed(1));
    } else {
      defaultSp.HeightList.add(height.toStringAsFixed(1));
      if (height > 7.4) {
        defaultSp.HeightList.add("8.0");
      } else {
        defaultSp.HeightList.add((height + 0.6).toStringAsFixed(1));
      }
    }
    print(widget.userSave!.religion);
    if (widget.userSave!.religion == "'") {
      defaultSp.ReligionList.add("Any");
    } else {
      defaultSp.ReligionList.add(widget.userSave!.religion);
    }
    // defaultSp.KundaliDoshList.add("Any");
    if (widget.userSave!.MartialStatus == "Unmarried") {
      defaultSp.MaritalStatusList.add("Unmarried");
    } else {
      defaultSp.MaritalStatusList.add("Any");
    }

    defaultSp.EducationList.add("Any");
    defaultSp.KundaliDoshList.add("Any");
    defaultSp.HeightList.add("Any");
    defaultSp.IncomeList.add("Any");
    defaultSp.LocatioList.add(["Any"]);
    defaultSp.ProfessionList.add("Any");
    defaultSp.DrinkList.add("Any");
    defaultSp.SmokeList.add("Any");
    defaultSp.HeightList.add("Any");

    //print(glb.userSave.latitude);
    // print(glb.userSave.longitude);
    // print(userSave.longitude);
    // print(userSave.latitude);
    // distance = await getDistanceBetweenLocations(
    //     28.2090551, 78.2561578, 29.947631, 76.8197412);
  }

  void getdistance() async {
    var dist = await getDistanceBetweenLocations(
      userSave.latitude ?? 0.0,
      userSave.longitude ?? 0.0,
      widget.userSave!.lat.toDouble(),
      widget.userSave!.lng.toDouble(),
    );

    distance = dist.toStringAsFixed(2);
    setState(() {});
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  savedPrefCard(boxname, imgicon, defaultText) {
    // print(boxname.toString());
    return Box(
      box_text: (boxname.isEmpty)
          ? (defaultText.length > 1)
              ? "${defaultText[0]} +${defaultText.length - 1}}"
              : defaultText[0]
          : (boxname.length > 1)
              ? boxname.contains("Any")
                  ? "Any"
                  : "${boxname[0]} +${boxname.length - 1}"
              : boxname[0],
      icon: imgicon,
    );
  }

  locationCard(boxname, imgicon, defaultText) {
    print(boxname.toString() + "hello");
    return Container(
        margin: const EdgeInsets.only(bottom: 1.5, right: 2),
        height: MediaQuery.of(context).size.height * 0.0195,

        // width: (width == null) ? box_text.length * 8 + 32.0 : width,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33.0),
          border: Border.all(color: main_color, width: 0.5),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              ImageIcon(
                AssetImage(imgicon),
                size: 16,
                color: main_color,
              ),
              const SizedBox(
                width: 5,
              ),
              boxname.contains("1")
                  ? Text(
                      "Any",
                      // textScaleFactor: 1.0,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: main_color,
                      ),
                    )
                  : Text(
                      boxname,
                      // textScaleFactor: 1.0,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: main_color,
                      ),
                    )
            ],
          ),
        ));
    //  Box(
    //   box_text: ( boxname.isEmpty)
    //       ? "Any"
    //       : (boxname[0].isEmpty)
    //           ? (boxname[1].isEmpty)
    //               ? (boxname[2].length > 1)
    //                   ? "${boxname[2][0]} +${boxname[2].length - 1}"
    //                   : boxname[2][0]
    //               : (boxname[1].length > 1)
    //                   ? "${boxname[1][0]} +${boxname[1].length - 1}"
    //                   : boxname[1][0]
    //           : (boxname[0].length > 1)
    //               ? "${boxname[0][0]} +${boxname[0].length - 1}"
    //               : boxname[0][0],
    //   icon: imgicon,
    // );
  }

  ageCard(boxname, imgicon, defaultText) {
    // print(boxname.toString());
    return Box(
      box_text: (boxname.isEmpty)
          ? (defaultText.length > 1)
              ? "${defaultText[0]} - ${defaultText[1]} "
              : ""
          : (boxname.length > 1)
              ? "${boxname[0]} - ${boxname[1]}"
              : '',
      icon: imgicon,
    );
  }

  heightard(boxname, imgicon, defaultText) {
    // print(boxname.toString());
    return Box(
      box_text: (boxname.isEmpty)
          ? (defaultText.length > 1)
              ? "${defaultText[0]} - ${defaultText[1]}"
              : ""
          : (boxname.length > 1)
              ? "${boxname[0]} - ${boxname[1]}"
              : '',
      icon: imgicon,
    );
  }

  var _selectedDate;
  var _age;

  // void _showDatePicker() async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime.now());
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       _age = calculateAge(_selectedDate);
  //     });
  //   }
  // }

  // int calculateAge(DateTime birthDate) {
  //   DateTime today = DateTime.now();
  //   int age = today.year - birthDate.year;
  //   if (today.month < birthDate.month ||
  //       (today.month == birthDate.month && today.day < birthDate.day)) {
  //     age--;
  //   }
  //   return age;
  // }

  bool isExpanded = false;
  connectivityCheck() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: avoid_print
      }
    } on SocketException catch (_) {
      print("not connected");
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SnackBarContent(
                error_text: "No Internet Connection",
                appreciation: "",
                icon: Icons.error,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });

      // connectivityCheck();
    }
  }

  List<Widget> _createImgList() {
    if (galleryItems == null) {
      return [const Text("image not found")];
    } else {
      return List<Widget>.generate(galleryItems.length, (int index) {
        return widget.userSave!.isBlur == true
            ?  SizedBox(
                height: 25,
                width: 25,
                child: ClipRRect(
                  // Clipping the child widget
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius if needed
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        galleryItems[index],
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(
                              0), // Required to make BackdropFilter work
                        ),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/lock.png"),
                      SizedBox(height: 10,),
                      Text("Locked",style: TextStyle(color: main_color),)
                    ],)
                    ],
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: galleryItems[index],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress, color: main_color),
                ),
              );
      });
    }
  }

  int numindex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.userSave!.email);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                            // height:
                            // MediaQuery.of(context).size.height * 0.42,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              child: widget.userSave!.imageurls.isEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: tempImage[0],
                                      fit: BoxFit.cover,
                                      // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      //     CircularProgressIndicator(
                                      //         value: downloadProgress.prog ress, color: main_color),
                                    )
                                  : ImageSlideshow(
                                      indicatorRadius: 0,
                                      initialPage: 0,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width,

                                      /// The color to paint the indicator.
                                      indicatorColor: glb.main_color,
                                      indicatorBottomPadding: 20,
                                      indicatorPadding: 30,
                                      onPageChanged: (value) {
                                        setState(() {
                                          numindex = value;
                                        });
                                      },
                                      isLoop: false,
                                      children: _createImgList()
                                      // .map((url) =>
                                      //     CachedNetworkImageProvider(url))
                                      // .map((provider) =>
                                      //     Image(image: provider))
                                      // .toList(),
                                      //returns list of images
                                      ),
                              onTap: () {
                                if (galleryItems.isNotEmpty) {
                                  SearchProfile().addtoadminnotification(
                                      userid: "2345",
                                      useremail: "",
                                      userimage: "",
                                      title:
                                          "${userSave.displayName} SEEN ${widget.userSave!.name.substring(0, 1)} ${widget.userSave!.surname.toUpperCase()} ${widget.userSave!.puid} PROFILE BY CLICK PHOTO",
                                      email: userSave.email!,
                                      subtitle: "");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageSliderPopUp(
                                            currentindex: numindex,
                                            profileData: widget.userSave!,
                                            galleryItems: galleryItems,
                                          )));
                                }
                              },
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 8,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          " ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.substring(0, 1).toUpperCase() + widget.userSave!.surname.substring(1).toLowerCase()}",
                                          // "${widget. userSave!.name!.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.substring(0, 1).toUpperCase()}",
                                          style: const TextStyle(
                                            fontFamily: "Sans-serif",
                                            fontSize: 20,
                                            color: Colors.white,
                                            
                                            fontWeight: FontWeight.w700,
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 33.0)
                                            ],
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 2,
                                      // ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          age.toString(),
                                          style: const TextStyle(
                                            fontFamily: "Sans-serif",
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 33.0)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 2),
                                            child: Image.asset(
                                              'assets/flags/${countryCode(country).toLowerCase()}.png',
                                              package: 'intl_phone_field',
                                              width: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          (widget.userSave!.verifiedstatus ==
                                                  "verified")
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 2),
                                                  child: Icon(
                                                    Icons.verified_user,
                                                    color: glb.main_color,
                                                    size: 16,
                                                  ),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Color(0xFF38B9F4),
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 5.0)
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              (distance != null ||
                                                      distance != 0.0)
                                                  ? "${distance} Km"
                                                  : "70Km",
                                              style: const TextStyle(
                                                fontFamily: "Sans-serif",
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 5.0)
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              (city.length < 15)
                                                  ? city ?? ""
                                                  : city.substring(0, 14),
                                              style: const TextStyle(
                                                fontFamily: "Sans-serif",
                                                fontSize: 14,
                                                color: Colors.white,
                                                // color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 5.0)
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  // padding: EdgeInsets.all(30),
                                                  width: 9,
                                                  height: 9,
                                                  decoration: BoxDecoration(
                                                      color: (connectivity ==
                                                              "Online")
                                                          ? const Color(
                                                              0xFF00FF19)
                                                          : (connectivity ==
                                                                  "Resumed")
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  255, 208, 0)
                                                              : const Color(
                                                                  0xFFBDBDBD)
                                                      // color: Color(0xFF33D374)),
                                                      // color: if(userSave.connectivity == "Online"){Color(0xFF00FF19)}else if(userSave.connectivity == "Offline"){Color(0xFFBDBDBD)} else{Color(0xFFDBFF00)}
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2.5,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            child: TickerText(
                                              // default values
                                              scrollDirection: Axis.horizontal,
                                              speed: 20,
                                              startPauseDuration:
                                                  const Duration(seconds: 1),
                                              endPauseDuration:
                                                  const Duration(seconds: 1),
                                              returnDuration: const Duration(
                                                  milliseconds: 800),
                                              primaryCurve: Curves.linear,

                                              returnCurve: Curves.easeOut,
                                              child: Text(
                                                "${widget.userSave!.city},${widget.userSave!.state},${widget.userSave!.country}",
                                                style: const TextStyle(
                                                  fontFamily: "Sans-serif",
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5.0)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          DateSlide(
                                            newdate: widget.userSave!
                                                        .offlinetime ==
                                                    ""
                                                ? widget.userSave!.createdAt!
                                                : widget.userSave!.offlinetime!,
                                            olddate:
                                                widget.userSave!.createdAt!,
                                          ),
                                          const Column(
                                            children: [
                                              SizedBox(
                                                height: 2.5,
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),
                        ]),
                        SizedBox(
                          // height: MediaQuery.of(context).size.height * 0.49,
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "About ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.substring(0, 1).toUpperCase() + widget.userSave!.surname.substring(1).toLowerCase()}",
                                      style: TextStyle(
                                        fontFamily: "Sans-serif",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: glb.main_color,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        Clipboard.setData(ClipboardData(
                                                text: widget.userSave!.puid))
                                            .then((value) {
                                          //only if ->
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Copied successfully")));
                                        });
                                      },
                                      child: Text(
                                        "ID- ${widget.userSave!.puid}",
                                        style: const TextStyle(
                                          fontFamily: "Sans-serif",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF38B9F4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              Stack(
                                  //expandable text
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                        top: 5
                                      ),
                                      child: Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        // alignment:WrapAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.035,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              print("tapped");

                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (builder) =>
                                              //             HomePage()));
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (builder) =>
                                              //             Calender(
                                              //               useTwentyOneYears:
                                              //                   true,
                                              //             )));
                                              // Get.to(
                                              //   () => const MyProfile(),
                                              //   transition: Transition.zoom,
                                              // );
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder:
                                              //             (builder) =>
                                              //                 LOcated()));
                                              // Load the audio file from assets

                                              // Play the audio file from the temporary file
                                              // await player.play(tempFile.path);
                                            },
                                            child: Box(
                                                // width: userSave.religion!.length * 15.5,
                                                box_text:
                                                    widget.userSave!.religion,
                                                icon:
                                                    'images/icons/religion.png'),
                                          ),
                                          (widget.userSave!.religion == "Hindu")
                                              ? Box(
                                                  box_text: widget
                                                      .userSave!.KundaliDosh,
                                                  icon:
                                                      'images/icons/kundli.png',
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          Box(
                                            // width: userSave.MartialStatus!.length * 15.5,
                                            box_text:
                                                widget.userSave!.MartialStatus,
                                            icon:
                                                'images/icons/marital_status.png',
                                          ),
                                          Box(
                                            // width: userSave.Height!.length * 15.5,
                                            box_text: widget.userSave!.Height,
                                            icon: 'images/icons/height.png',
                                          ),
                                          Box(
                                            // width: userSave.Diet!.length * 15.5,
                                            box_text: widget.userSave!.Diet,
                                            icon: 'images/icons/food.png',
                                          ),
                                          Box(
                                            // width: userSave.Education!.length * 15.5,
                                            box_text:
                                                widget.userSave!.Education,
                                            icon: 'images/icons/education.png',
                                          ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            box_text:
                                                widget.userSave!.Profession,
                                            icon:
                                                'images/icons/profession_suitcase.png',
                                          ),
                                          // Box(
                                          //   // width: (userSave.Location!.split(' ')[0].length - 1) *
                                          //   //     15.5,
                                          //   box_text: (widget. userSave!.Location ==
                                          //               null ||
                                          //           widget. userSave!.Location == "")
                                          //       ? ""
                                          //       : widget. userSave!.Location
                                          //           .split(' ')[0]
                                          //           .substring(
                                          //               0,
                                          //               widget. userSave!.Location
                                          //                       .split(
                                          //                           ' ')[0]
                                          //                       .length -
                                          //                   1),
                                          //   icon:
                                          //       'images/icons/location_home.png',
                                          // ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            box_text: widget.userSave!.Drink,
                                            icon: 'images/icons/drink.png',
                                          ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            box_text: widget.userSave!.Smoke,
                                            icon: 'images/icons/smoke.png',
                                          ),
                                          (widget.userSave!.Disability ==
                                                  'Normal')
                                              ? Container(width: 0)
                                              : Box(
                                                  // width: userSave.Profession!.length * 15.5,
                                                  box_text: widget
                                                      .userSave!.Disability,
                                                  icon:
                                                      'images/icons/disability.png',
                                                ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            box_text: widget.userSave!.Income,
                                            icon: 'images/icons/hand_rupee.png',
                                          ),
                                        ],
                                      ),
                                    ),
                               
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: const [
                                              BoxShadow(blurRadius: 0.05)
                                            ]),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 0,
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 7,
                                            right: 7,
                                            top: 7,
                                            bottom: 7),
                                        child: ExpandableText(
                                          (widget.userSave!.About_Me == null ||
                                                  widget.userSave!.About_Me ==
                                                      "")
                                              ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                              : (widget.userSave!.About_Me!
                                                          .length <
                                                      100)
                                                  ? "${widget.userSave!.About_Me} ................................................................................................................."
                                                  : widget.userSave!.About_Me!,
                                          collapseText: 'Less',
                                          style: TextStyle(
                                              fontSize: 12),
                                          linkColor: glb.main_color,
                                          onExpandedChanged: (value) {
                                            SearchProfile().addtoadminnotification(
                                                userid: "2345",
                                                useremail: "",
                                                userimage: "",
                                                title:
                                                    "${userSave.displayName} SEEN ${widget.userSave!.name.substring(0, 1)} ${widget.userSave!.surname.toUpperCase()} ${widget.userSave!.puid} PROFILE BY CLICK MORE-1",
                                                email: userSave.email!,
                                                subtitle: "");
                                            _moreNoti();
                                            isExpanded = expaned;
                                          },
                                          // linkEllipsis:false,
                                          expandText: 'More',
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),

                              //interested in marraige with
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Partner Preferences",
                                      // textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Sans-serif",
                                          fontSize: 17,
                                          color: glb.main_color,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height *
                              //       0.002,
                              // ),
                              SizedBox(
                                height: 10,
                              ),

                              Stack(
                                children: [
                                  //expandable text
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 0, top: 4),
                                    child: newSavePrefModel == null
                                        ? const Center()
                                        : Wrap(
                                            spacing: 3,
                                        runSpacing: 3,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                              // const Box(
                                              //   // width: userSave.Profession!.length * 15.5,
                                              //   box_text: '18 - 36',
                                              //   icon: 'images/icons/calender.png',
                                              // ),
                                              ageCard(
                                                  newSavePrefModel!.ageList,
                                                  'images/icons/calender.png',
                                                  defaultSp.AgeList),
                                              // const Box(
                                              //   box_text: 'Hindu +2 more',
                                              //   icon: 'images/icons/religion.png',
                                              // ),
                                              savedPrefCard(
                                                  newSavePrefModel!
                                                      .religionList,
                                                  'images/icons/religion.png',
                                                  defaultSp.ReligionList),
                                              (widget.userSave!.religion ==
                                                      "Hindu")
                                                  ? savedPrefCard(
                                                      newSavePrefModel!
                                                          .kundaliDoshList,
                                                      'images/icons/kundli.png',
                                                      defaultSp.KundaliDoshList)
                                                  : Container(width: 0),
                                              savedPrefCard(
                                                  newSavePrefModel!
                                                      .maritalStatusList,
                                                  'images/icons/marital_status.png',
                                                  defaultSp.MaritalStatusList),

                                              heightard(
                                                  newSavePrefModel!.heightList,
                                                  'images/icons/height.png',
                                                  defaultSp.HeightList),
                                              savedPrefCard(
                                                  newSavePrefModel!.dietList,
                                                  'images/icons/food.png',
                                                  defaultSp.dietList),
                                              savedPrefCard(
                                                  newSavePrefModel!
                                                      .educationList,
                                                  'images/icons/education.png',
                                                  defaultSp.EducationList),
                                              savedPrefCard(
                                                  newSavePrefModel!
                                                      .professionList,
                                                  'images/icons/profession_suitcase.png',
                                                  defaultSp.ProfessionList),
                                              locationCard(
                                                  newSavePrefModel!.location
                                                              .isEmpty &&
                                                          newSavePrefModel!
                                                              .statelocation
                                                              .isEmpty &&
                                                          newSavePrefModel!
                                                              .citylocation
                                                              .isEmpty
                                                      ? "Any"
                                                      : "${newSavePrefModel!.location.join(', ') + ","}, ${newSavePrefModel!.statelocation.join(', ') + ","} ${newSavePrefModel!.citylocation.join(', ')}",
                                                  'images/icons/location.png',
                                                  defaultSp.LocatioList),
                                              savedPrefCard(
                                                  newSavePrefModel!.drinkList,
                                                  'images/icons/drink.png',
                                                  defaultSp.DrinkList),
                                              savedPrefCard(
                                                  newSavePrefModel!.smokeList,
                                                  'images/icons/smoke.png',
                                                  defaultSp.SmokeList),
                                              (widget.userSave!
                                                          .Disability ==
                                                      "Normal")
                                                  ? Container(width: 0)
                                                  : savedPrefCard(
                                                      newSavePrefModel!
                                                          .disabilityList,
                                                      'images/icons/disability.png',
                                                      defaultSp.DisabilityList),
                                              savedPrefCard(
                                                  newSavePrefModel!.incomeList,
                                                  'images/icons/hand_rupee.png',
                                                  defaultSp.IncomeList),
                                            ],
                                          ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(blurRadius: 0.05)
                                          ]),
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, top: 7, bottom: 7),
                                      child: ExpandableText(
                                        (widget.userSave!.Partner_Prefs ==
                                                    null ||
                                                widget.userSave!
                                                        .Partner_Prefs ==
                                                    "")
                                            ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                            : (widget.userSave!.Partner_Prefs!
                                                        .length <
                                                    100)
                                                ? "${widget.userSave!.Partner_Prefs} ................................................................................................................."
                                                : widget
                                                    .userSave!.Partner_Prefs!,
                                        collapseText: 'Less',
                                        style: TextStyle(
                                            fontSize:12),
                                        onExpandedChanged: (value) {
                                          _moreNoti();
                                          SearchProfile().addtoadminnotification(
                                              userid: "2345",
                                              useremail: "",
                                              userimage: "",
                                              title:
                                                  "${userSave.displayName} SEEN ${widget.userSave!.name.substring(0, 1)} ${widget.userSave!.surname.toUpperCase()} ${widget.userSave!.puid} PROFILE BY CLICK MORE-2",
                                              email: userSave.email!,
                                              subtitle: "");
                                        },
                                        // linkColor: Colors.red,
                                        expandText: 'More',
                                        linkColor: glb.main_color,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.0006,
              top: MediaQuery.of(context).size.height * 0.04,
              child: IconButton(
                icon: const Icon(
                  // Icons.more_vert_outlined,//for three dots
                  Icons.menu, //for three lines
                  size: 20,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(color: Colors.black, blurRadius: 15.0)
                  ],
                ),
                onPressed: () {
                  numofnoti = 0;
                  setState(() {});
                  if (listofadminpermissions!.contains("Can See left menu") ||
                      listofadminpermissions!
                          .contains("Can See user’s full name") ||
                      listofadminpermissions!.contains("All")) {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "",
                        userimage: "",
                        title:
                            "${userSave.displayName} CLICK ON THE LEFT MENU ",
                        email: userSave.email!,
                        subtitle: "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfile(
                                  profilecomp: profilePercentage,
                                  userSave: widget.userSave!,
                                  isDelete:
                                      widget.isDelete == "true" ? true : false,
                                )));
                  }

                  // Get.to(() => const MyProfile(),
                  //     transition: Transition.zoom);
                },
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.004,
              top: MediaQuery.of(context).size.height * 0.04,
              child: IconButton(
                icon: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(
                        // Icons.more_vert_outlined,//for three dots
                        FontAwesomeIcons.bell, //for three lines
                       size: 22,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(color: Colors.black, blurRadius: 15.0)
                        ],
                      ),
                    ),
                    if (_unreadCount >= 0)
                      Positioned(
                        // right: 2.0,
                        // top: 1.0,
                        right: 1.0,
                        top: 1.0,
                        child: numofnoti == 0
                            ? const Text("")
                            : Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: main_color, shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '$numofnoti',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 6.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),
                onPressed: () {
                  if (listofadminpermissions!
                          .contains("Can see main admin activities") ||
                      listofadminpermissions!
                          .contains("Can see sub admin activities") ||
                      listofadminpermissions!.contains("All")) {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "",
                        userimage: "",
                        title: "${userSave.displayName} SEEN NOTIFICATION",
                        email: userSave.email!,
                        subtitle: "");
                    NotificationFunction.setNotification(
                      "admin",
                      "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave.uid!.length - 5)} SEEN NOTIFICATIONS",
                      'notificationbell',
                    );
                    NotiService().updatenoti();
                    numofnoti = 0;
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavHome(
                                  newUserModel: widget.userSave,
                                )));
                  }
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.86,
              // bottom: MediaQuery.of(context).size.height * 0.005,

              child: Pbuttons(
                profileData: widget.userSave,
                type: widget.isDelete,
              ),
            ),
            (widget.type == 'other')
                ? Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.04,
                    child: IconButton(
                      icon: Icon(
                        // Icons.more_vert_outlined,//for three dots
                        Icons.arrow_back_ios, //for three lines
                        size: 25,
                        color: main_color,
                        shadows: const <Shadow>[
                          Shadow(color: Colors.black, blurRadius: 15.0)
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                : const SizedBox(width: 0, height: 0),
          ],
        ),
      ),
    );
  }
}
