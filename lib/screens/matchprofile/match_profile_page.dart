// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/match_model1.dart';
import 'package:matrimony_admin/models/match_model2.dart';
import 'package:matrimony_admin/models/new_save_pref.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/matchprofile/kundalimatchprofile.dart';
import 'package:matrimony_admin/screens/navigation/kundli_match_data.dart';
import 'package:matrimony_admin/screens/profile/buttons.dart';
import 'package:matrimony_admin/screens/profile/imageslider.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:ticker_text/ticker_text.dart';

import '../../Assets/Error.dart';
import '../../Assets/box.dart';
import '../../Assets/defaultAlgo/profileMatch.dart';
import '../../Assets/sendMessage.dart';
import 'package:http/http.dart' as http;
import '../../globalVars.dart' as glb;
import '../../globalVars.dart';
import '../../models/country.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class MatchProfilePage extends StatefulWidget {
  MatchProfilePage(
      {super.key,
      this.index,
      required this.userSave,
      required this.pushchat,
      this.controller,
      required this.currentuser,
      this.type = ""});
  NewUserModel? userSave;
  NewUserModel? currentuser;
  var index;
  String type;
  Function pushchat;
  var controller;
  @override
  State<MatchProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MatchProfilePage>
    with WidgetsBindingObserver {
  // ignore: prefer_typing_uninitialized_variables
  var matchValue;
  bool expaned = false;
  var age;
  var city;
  var country;
  // ignore: prefer_typing_uninitialized_variables
  var galleryItems;
  // User userSave = User();
  ProfileMatch pm = ProfileMatch();
  SavedPref userSp = SavedPref();
  late DatabaseReference _dbref;
  late DatabaseReference _dbref5;
  SavedPref defaultSp = SavedPref();
  var data;
  var connectivity = '';
  var token = '';
  var tempImage = [
    "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2"
  ];
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  Match1? match;
  Match2? match2;
  void getmatch() async {
    DateTime dateofbirth =
        DateTime.fromMillisecondsSinceEpoch(widget.currentuser!.dob!);

    String boydob = DateFormat('dd/MM/yyyy').format(dateofbirth);
    DateTime dateofbirth1 =
        DateTime.fromMillisecondsSinceEpoch(widget.userSave!.dob);
    String girldob = DateFormat('dd/MM/yyyy').format(dateofbirth1);
    String timeofbirhthofboy = widget.currentuser!.timeofbirth!
        .replaceAll("Am", "")
        .replaceAll("Pm", "");
    String timeofbirhthofgirl =
        widget.userSave!.timeofbirth.replaceAll("Am", "").replaceAll("Pm", "");

    match2 = await HomeService().getusermatch2(
      boydob: boydob,
      boytob: timeofbirhthofboy,
      boylat: widget.currentuser!.lat!,
      boyon: widget.currentuser!.lng!,
    );
  }

  get R => null;

  SendMessage sendMessage = SendMessage();
  void getallusermatch() async {
    if (widget.currentuser!.gender == "male") {
      DateTime dateofbirth =
          DateTime.fromMillisecondsSinceEpoch(widget.currentuser!.dob!);

      String m_day = dateofbirth.day.toString();
      String m_month = dateofbirth.month.toString();
      String m_year = dateofbirth.year.toString();
      DateTime dateofbirth1 =
          DateTime.fromMillisecondsSinceEpoch(widget.userSave!.dob);
      String f_day = dateofbirth1.day.toString();
      String f_month = dateofbirth1.month.toString();
      String f_year = dateofbirth1.year.toString();
      List<String> m_parts = widget.currentuser!.timeofbirth.split(':');
      int m_hours = int.parse(m_parts[0]);

      List<String> minuteAndAmPm = m_parts[1].split(' ');
      int m_minutes = int.parse(minuteAndAmPm[0]);
      List<String> f_parts = widget.userSave!.timeofbirth.split(':');
      int f_hours = int.parse(f_parts[0]);

      List<String> fminuteAndAmPm = f_parts[1].split(' ');
      int f_minutes = int.parse(fminuteAndAmPm[0]);
      var url = Uri.parse(
          'https://api.kundali.astrotalk.com/v1/combined/match_making');

      var payload = {
        "m_detail": {
          "day": m_day,
          "hour": m_hours,
          "lat": widget.currentuser!.lat,
          "lon": widget.currentuser!.lng,
          "min": m_minutes,
          "month": m_month,
          "name": widget.currentuser!.name,
          "tzone": "5.5",
          "year": m_year,
          "gender": "male",
          "place": widget.currentuser!.Location,
          "sec": 0
        },
        "f_detail": {
          "day": f_day,
          "hour": f_hours,
          "lat": widget.userSave!.lat,
          "lon": widget.userSave!.lng,
          "min": f_minutes,
          "month": f_month,
          "name": widget.userSave!.name,
          "tzone": "5.5",
          "year": f_year,
          "gender": "female",
          "place": widget.userSave!.Location,
          "sec": 0
        },
        "languageId": 1
      };

      var body = json.encode(payload);

      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        if (!mounted) return;
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      DateTime dateofbirth =
          DateTime.fromMillisecondsSinceEpoch(widget.userSave!.dob!);

      String m_day = dateofbirth.day.toString();
      String m_month = dateofbirth.month.toString();
      String m_year = dateofbirth.year.toString();
      DateTime dateofbirth1 =
          DateTime.fromMillisecondsSinceEpoch(widget.currentuser!.dob!);
      String f_day = dateofbirth1.day.toString();
      String f_month = dateofbirth1.month.toString();
      String f_year = dateofbirth1.year.toString();
      List<String> m_parts = widget.userSave!.timeofbirth!.split(':');
      int m_hours = int.parse(m_parts[0]);

      List<String> minuteAndAmPm = m_parts[1].split(' ');
      int m_minutes = int.parse(minuteAndAmPm[0]);
      List<String> f_parts = widget.currentuser!.timeofbirth!.split(':');
      int f_hours = int.parse(f_parts[0]);

      List<String> fminuteAndAmPm = f_parts[1].split(' ');
      int f_minutes = int.parse(fminuteAndAmPm[0]);
      var url = Uri.parse(
          'https://api.kundali.astrotalk.com/v1/combined/match_making');

      var payload = {
        "m_detail": {
          "day": m_day,
          "hour": m_hours,
          "lat": widget.userSave!.lat,
          "lon": widget.userSave!.lng,
          "min": m_minutes,
          "month": m_month,
          "name": widget.userSave!.name,
          "tzone": "5.5",
          "year": m_year,
          "gender": "male",
          "place": widget.userSave!.Location,
          "sec": 0
        },
        "f_detail": {
          "day": f_day,
          "hour": f_hours,
          "lat": widget.currentuser!.lat,
          "lon": widget.currentuser!.lng,
          "min": f_minutes,
          "month": f_month,
          "name": widget.currentuser!.name,
          "tzone": "5.5",
          "year": f_year,
          "gender": "female",
          "place": widget.currentuser!.Location,
          "sec": 0
        },
        "languageId": 1
      };

      var body = json.encode(payload);

      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        if (!mounted) return;
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  _moreNoti() {
    // if (expaned == false) {
    //   try {
    //     sendMessage.sendPushMessage(
    //         "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid}",
    //         "VIEWED PROFILE",
    //         widget.userSave!.token,
    //         "profilepage",
    //         token);
    //   } catch (e) {
    //     print(e);
    //   }
    //   expaned = true;
    // }
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
    getallusermatch();
    getdefaultpreference();
    // getmatch();

    // checkBlockedStatus();
    didChangeAppLifecycleState(AppLifecycleState.resumed);
    super.initState();

    _dbref = FirebaseDatabase.instance.ref();
    _dbref5 = FirebaseDatabase.instance.ref();
    setconnection();
    matchValue = pm.profileMatch(widget.userSave, widget.userSave!).toString();
    setState(() {
      galleryItems = (widget.userSave!.imageurls == null ||
              widget.userSave!.imageurls.isEmpty)
          ? []
          : (widget.userSave!.imageurls.length > 6)
              ? widget.userSave!.imageurls!.sublist(0, 6)
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
    // if (widget.userSave!.location != "" && widget.userSave!.location != null) {
    try {
      setState(() {
        city = widget.userSave!.city;
      });
    } catch (e) {
      print("error in city : $e");
      city = "";
    }
    try {
      setState(() {
        country = widget.userSave!.Location!
            .split(' ')[widget.userSave!.Location!.split(' ').length - 1];
      });
    } catch (e) {
      print("error in country : $e");
      country = "India";
    }
    // } else {
    //   setState(() {
    //     city = "";
    //     country = "India";
    //   });
    // }
    setState(() {});
  }

  Future<double> getDistanceBetweenLocations(
      double startLat, double startLong, double endLat, double endLong) async {
    double distanceInMeters =
        Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371.0; // Earth radius in kilometers

    double toRadians(double degrees) {
      return degrees * pi / 180.0;
    }

    double dLat = toRadians(lat2 - lat1);
    double dLon = toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(toRadians(lat1)) *
            cos(toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
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
        defaultSp.AgeList.add(age.toString());
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
    if (highttemp[0] == "ft") {
      inc = double.parse(highttemp[2]);
    } else {
      highttemp = widget.userSave!.Height!.split(".");
      inc = double.parse(highttemp[0].split(" ")[0]);
    }
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
    defaultSp.ReligionList.add(widget.userSave!.religion.toString());
    defaultSp.KundaliDoshList.add("Any");

    if (widget.userSave!.MartialStatus == "Unmarried") {
      defaultSp.MaritalStatusList.add("Unmarried");
    } else {
      defaultSp.MaritalStatusList.add("Any");
    }

    defaultSp.EducationList.add("Any");
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
        widget.currentuser!.lat!,
        widget.currentuser!.lng!,
        widget.userSave!.lat.toDouble(),
        widget.userSave!.lng.toDouble());
    var distance1 = calculateDistance(
        widget.currentuser!.lat!,
        widget.currentuser!.lng!,
        widget.userSave!.lat.toDouble(),
        widget.userSave!.lng.toDouble());
    distance = distance1.toStringAsFixed(2);
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
      currentusertext: "",

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
              SizedBox(
                width: 5,
              ),
              ImageIcon(
                AssetImage(imgicon),
                size: 16,
                color: main_color,
              ),
              SizedBox(
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
      currentusertext: "",

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
      currentusertext: "",
      box_text: (boxname.isEmpty)
          ? (defaultText.length > 1)
              ? "${defaultText[0]} - ${defaultText[1]}  "
              : ""
          : (boxname.length > 1)
              ? "${boxname[0]} - ${boxname[1]} "
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
            return AlertDialog(
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

  int numindex = 0;
  List<Widget> _createImgList() {
    if (galleryItems == null) {
      return [const Text("image not found")];
    } else {
      return List<Widget>.generate(galleryItems.length, (int index) {
        return CachedNetworkImage(
          imageUrl: galleryItems[index],
          fit: BoxFit.cover,
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     CircularProgressIndicator(
          //         value: downloadProgress.progress, color: main_color),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                            // height:
                            // MediaQuery.of(context).size.height * 0.42,
                            height: MediaQuery.of(context).size.height * 0.47,
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              child: widget.userSave!.imageurls.isEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: tempImage[0],
                                      fit: BoxFit.cover,
                                      // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      //     CircularProgressIndicator(
                                      //         value: downloadProgress.progress, color: main_color),
                                    )
                                  : ImageSlideshow(
                                      indicatorRadius: 5,
                                      initialPage: 0,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width,
                                      onPageChanged: (value) {
                                        numindex = value;
                                        setState(() {});
                                      },

                                      /// The color to paint the indicator.
                                      indicatorColor: glb.main_color,
                                      isLoop: (_createImgList().length > 1),
                                      children: _createImgList()
                                      // .map((url) =>
                                      //     CachedNetworkImageProvider(url))
                                      // .map((provider) =>
                                      //     Image(image: provider))
                                      // .toList(),
                                      //returns list of images
                                      ),
                              onTap: () {
                                if (userSave.status == "approved") {
                                  // NotificationFunction.setNotification(
                                  //   "admin",
                                  //   "${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid} SEEN PHOTO ${userSave.name!.substring(0, 1).toUpperCase()} ${userSave.surname!.toUpperCase()} ${userSave.puid} PROFILE ",
                                  //   'profileseen',
                                  // );
                                  // // NotificationService().addtoactivities(email: widget.userSave!.email,
                                  // //  title: "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid}",
                                  // //   username: glb.userSave.name!, userimage: userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], userid: glb.userSave.uid!);
                                  // NotificationFunction.setNotification(
                                  //     "user2",
                                  //     "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid}",
                                  //     'profileseen',
                                  //     useruid: userSave.uid!);
                                  _moreNoti();
                                  try {
                                    // sendMessage.sendPushMessage(
                                    //     "VIEWED PROFILE BY ${glb.userSave.name!.substring(0, 1).toUpperCase()} ${glb.userSave.surname!.toUpperCase()} ${glb.userSave.puid}",
                                    //     "VIEWED PROFILE",
                                    //     userSave.uid!,
                                    //     "profilepage",
                                    //     widget.userSave!.token);
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                                if (galleryItems[0] != tempImage[0]) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageSliderPopUp(
                                            profileData: widget.userSave!,
                                            galleryItems: galleryItems,
                                            currentindex: numindex,
                                          )));
                                }
                              },
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 8,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname!.substring(0, 1).toUpperCase() + widget.userSave!.surname.substring(1).toLowerCase()}",
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
                                          widget.userSave!.age.toString(),
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
                                          SizedBox(
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
                                          SizedBox(
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
                                              SizedBox(
                                                height: 2.5,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // Container(
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.15,
                                          //   child: SingleChildScrollView(
                                          //     scrollDirection: Axis.horizontal,
                                          //     child: Text(
                                          //       "${widget.userSave!.Location}",
                                          //       textAlign: TextAlign.end,
                                          //       style: const TextStyle(
                                          //         fontFamily: "Sans-serif",
                                          //         fontSize: 14,
                                          //         color: Colors.white,
                                          //         // color: Colors.white,
                                          //         fontWeight: FontWeight.w400,
                                          //         shadows: <Shadow>[
                                          //           Shadow(
                                          //               color: Colors.black,
                                          //               blurRadius: 5.0)
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
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
                                          Column(
                                            children: [
                                              (userSave.uid != glb.uid)
                                                  ? InkWell(
                                                      onTap: () {
                                                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HoroScopePage(match1: match!,),), (route) => false);
                                                        // DateTime dateofbirth = DateTime
                                                        //     .fromMillisecondsSinceEpoch(
                                                        //         widget
                                                        //             .currentuser!
                                                        //             .dob!);

                                                        // String boydob =
                                                        //     DateFormat(
                                                        //             'dd/MM/yyyy')
                                                        //         .format(
                                                        //             dateofbirth);
                                                        // DateTime dateofbirth1 =
                                                        //     DateTime
                                                        //         .fromMillisecondsSinceEpoch(
                                                        //             widget
                                                        //                 .userSave!
                                                        //                 .dob);
                                                        // String girldob =
                                                        //     DateFormat(
                                                        //             'dd/MM/yyyy')
                                                        //         .format(
                                                        //             dateofbirth1);
                                                        // String
                                                        //     timeofbirhthofboy =
                                                        //     widget.currentuser!
                                                        //         .timeofbirth
                                                        //         .replaceAll(
                                                        //             "Am", "")
                                                        //         .replaceAll(
                                                        //             "Pm", "");
                                                        // String
                                                        //     timeofbirhthofgirl =
                                                        //     widget.userSave!
                                                        //         .timeofbirth
                                                        //         .replaceAll(
                                                        //             "Am", "")
                                                        //         .replaceAll(
                                                        //             "Pm", "");
                                                        DateTime dateofbirth = DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                widget
                                                                    .currentuser!
                                                                    .dob!);

                                                        String m_day =
                                                            dateofbirth.day
                                                                .toString();
                                                        String m_month =
                                                            dateofbirth.month
                                                                .toString();
                                                        String m_year =
                                                            dateofbirth.year
                                                                .toString();
                                                        DateTime dateofbirth1 =
                                                            DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    widget
                                                                        .userSave!
                                                                        .dob);
                                                        String f_day =
                                                            dateofbirth1.day
                                                                .toString();
                                                        String f_month =
                                                            dateofbirth1.month
                                                                .toString();
                                                        String f_year =
                                                            dateofbirth1.year
                                                                .toString();
                                                        List<String> m_parts =
                                                            widget.currentuser!
                                                                .timeofbirth!
                                                                .split(':');
                                                        int m_hours = int.parse(
                                                            m_parts[0]);

                                                        List<String>
                                                            minuteAndAmPm =
                                                            m_parts[1]
                                                                .split(' ');
                                                        int m_minutes =
                                                            int.parse(
                                                                minuteAndAmPm[
                                                                    0]);
                                                        List<String> f_parts =
                                                            widget.userSave!
                                                                .timeofbirth
                                                                .split(':');

                                                        int f_hours = int.parse(
                                                            f_parts[0]);

                                                        List<String>
                                                            fminuteAndAmPm =
                                                            f_parts[1]
                                                                .split(' ');
                                                        int f_minutes =
                                                            int.parse(
                                                                fminuteAndAmPm[
                                                                    0]);
                                                        // Get.to(KundaliMatchData3Screen(
                                                        //     boydob: boydob,
                                                        //     boytob:
                                                        //         timeofbirhthofboy,
                                                        //     boylat: widget
                                                        //         .currentuser!
                                                        //         .lat!,
                                                        //     boyon: widget
                                                        //         .currentuser!
                                                        //         .lng!,
                                                        //     girldob: girldob,
                                                        //     girltob:
                                                        //         timeofbirhthofgirl,
                                                        //     girllat: widget
                                                        //         .userSave!.lat,
                                                        //     girlon: widget
                                                        //         .userSave!.lng,
                                                        //     boyname: widget
                                                        //         .currentuser!
                                                        //         .name!,
                                                        //     girlname: widget
                                                        //         .userSave!.name,
                                                        //     gunpoint: data['ashtkoot']
                                                        //                 ['total']
                                                        //             [
                                                        //             'received_points']
                                                        //         .toString()));
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        KundaliMatchDataScreen1(
                                                                          m_name: widget
                                                                              .currentuser!
                                                                              .name,
                                                                          f_name: widget
                                                                              .userSave!
                                                                              .name,
                                                                          m_month:
                                                                              m_month,
                                                                          f_month:
                                                                              f_month,
                                                                          m_day:
                                                                              m_day,
                                                                          f_day:
                                                                              f_day,
                                                                          m_year:
                                                                              m_year,
                                                                          f_year:
                                                                              f_year,
                                                                          m_hour:
                                                                              m_hours,
                                                                          f_hour:
                                                                              f_hours,
                                                                          m_min:
                                                                              m_minutes,
                                                                          f_min:
                                                                              f_minutes,
                                                                          m_place: widget
                                                                              .currentuser!
                                                                              .Location,
                                                                          f_place: widget
                                                                              .userSave!
                                                                              .Location,
                                                                          m_gender:
                                                                              "Male",
                                                                          f_gender:
                                                                              "Female",
                                                                          m_lat: widget
                                                                              .currentuser!
                                                                              .lat,
                                                                          m_lon: widget
                                                                              .currentuser!
                                                                              .lng,
                                                                          f_lat: widget
                                                                              .userSave!
                                                                              .lat,
                                                                          f_lon: widget
                                                                              .userSave!
                                                                              .lng,
                                                                          m_sec:
                                                                              0,
                                                                          f_sec:
                                                                              0,
                                                                          m_tzone:
                                                                              "5.5",
                                                                          f_tzone:
                                                                              "5.5",
                                                                        )));
                                                      },
                                                      child: Container(
                                                        width: 35,
                                                        height: 35,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "$matchValue",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize: 8,
                                                                    fontFamily:
                                                                        "Sans-serif",
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "/",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        "Sans-serif",
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "100",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize: 8,
                                                                    fontFamily:
                                                                        "Sans-serif",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                data == null
                                                                    ? Center()
                                                                    : Text(
                                                                        "${data['ashtkoot']['total']['received_points']}/36",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          fontFamily:
                                                                              "Sans-serif",
                                                                        ),
                                                                      ),
                                                                // Text(
                                                                //   "/",
                                                                //   textAlign: TextAlign.center,
                                                                //   style:
                                                                //       const TextStyle(
                                                                //         fontWeight: FontWeight.bold,
                                                                //     fontSize:
                                                                //         10,
                                                                //     fontFamily:
                                                                //         "Sans-serif",
                                                                //   ),
                                                                // ),
                                                                // Text(
                                                                //   "36",
                                                                //   textAlign: TextAlign.center,
                                                                //   style:
                                                                //       const TextStyle(
                                                                //     fontSize:
                                                                //         8,
                                                                //     fontFamily:
                                                                //         "Sans-serif",
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                            // const Text(
                                                            //   "Match",
                                                            //   style:
                                                            //       TextStyle(
                                                            //     fontSize:
                                                            //         5,
                                                            //     fontFamily:
                                                            //         "Sans-serif",
                                                            //   ),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
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
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),

                        //****Scrollable*/
                        //
                        //  Text(
                        //               "About ${widget.userSave!.name!} ${widget.userSave!.surname.toUpperCase() +widget. userSave!.surname.toLowerCase()}",
                        //               style: TextStyle(
                        //                 fontFamily: "Sans-serif",
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.w700,
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.49,
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "About ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname!.substring(0, 1).toUpperCase() + widget.userSave!.surname!.substring(1).toLowerCase()}",
                                      style: TextStyle(
                                        fontFamily: "Sans-serif",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: glb.main_color,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onLongPress: () {
                                      Clipboard.setData(ClipboardData(
                                              text: widget.userSave!.puid))
                                          .then((value) {
                                        //only if ->
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Copied successfully")));
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 4),
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
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height *
                              //       0.007,
                              // ),

                              Stack(
                                  //expandable text
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                      ),
                                      child: Wrap(
                                        // alignment:WrapAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
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
                                              //              (builder) =>
                                              //                 LOcated()));
                                              // Load the audio file from assets

                                              // Play the audio file from the temporary file
                                              // await player.play(tempFile.path);
                                            },
                                            child: Box(
                                              currentusertext: widget.currentuser!.religion,
                                                // width: userSave.religion!.length * 15.5,
                                                box_text:
                                                    widget.userSave!.religion,
                                                icon:
                                                    'images/icons/religion.png'),
                                          ),
                                          (widget.userSave!.religion == "Hindu")
                                              ? Box(
                                              currentusertext: widget.currentuser!.KundaliDosh,

                                                  box_text:
                                                    widget.  userSave?.KundaliDosh ??
                                                          "",
                                                  icon:
                                                      'images/icons/kundli.png',
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          Box(
                                            // width: userSave.MartialStatus!.length * 15.5,
                                              currentusertext: widget.currentuser!.MartialStatus,

                                            box_text:
                                                widget.userSave!.MartialStatus,
                                            icon:
                                                'images/icons/marital_status.png',
                                          ),
                                          Box(
                                              currentusertext: widget.currentuser!.Height??"",

                                            // width: userSave.Height!.length * 15.5,
                                            box_text: widget.userSave!.Height,
                                            icon: 'images/icons/height.png',
                                          ),
                                          Box(
                                            currentusertext: widget.currentuser!.Diet??"",
                                            // width: userSave.Diet!.length * 15.5,
                                            box_text: widget.userSave!.Diet,
                                            icon: 'images/icons/food.png',
                                          ),
                                          Box(
                                            currentusertext: widget.currentuser!.Education??"",
                                            box_text:
                                                widget.userSave!.Education,
                                            icon: 'images/icons/education.png',
                                          ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            currentusertext: widget.currentuser!.Profession??"",
                                            box_text:
                                                widget.userSave!.Profession,
                                            icon:
                                                'images/icons/profession_suitcase.png',
                                          ),
                                          // Box(
                                          //   // width: (userSave.Location!.split(' ')[0].length - 1) *
                                          //   //     15.5,
                                          //   box_text: (widget. userSave!.location ==
                                          //               null ||
                                          //           widget. userSave!.location == "")
                                          //       ? ""
                                          //       : widget. userSave!.location
                                          //           .split(' ')[0]
                                          //           .substring(
                                          //               0,
                                          //               widget. userSave!.location
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
                                            currentusertext: widget.currentuser!.Drink??"",
                                            icon: 'images/icons/drink.png',
                                          ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            box_text: widget.userSave!.Smoke,
                                            currentusertext: widget.currentuser!.Smoke??"",
                                            icon: 'images/icons/smoke.png',
                                          ),
                                          (widget.userSave!.Disability ==
                                                  'Normal')
                                              ? Container(width: 0)
                                              : Box(
                                                  // width: userSave.Profession!.length * 15.5,
                                                  currentusertext: widget.currentuser!.Disability??"",
                                                  box_text: widget
                                                      .userSave!.Disability,
                                                  icon:
                                                      'images/icons/disability.png',
                                                ),
                                          Box(
                                            // width: userSave.Profession!.length * 15.5,
                                            currentusertext: widget.currentuser!.Income??"",
                                            box_text: widget.userSave!.Income,
                                            icon: 'images/icons/hand_rupee.png',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
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
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016),
                                          linkColor: glb.main_color,
                                          onExpandedChanged: (value) {
                                            if (userSave.status == "approved") {
                                              _moreNoti();
                                            }
                                            isExpanded = expaned;
                                          },
                                          // linkEllipsis:false,
                                          expandText: 'More',
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ]),

                              //interested in marraige with
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Partner Preferences",
                                      // textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Sans-serif",
                                          fontSize: 20,
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

                              Stack(
                                children: [
                                  //expandable text
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                      ),
                                      child: newSavePrefModel == null
                                          ? Center(
                                              child: Wrap(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  ageCard([],
                                                      'images/icons/calender.png',
                                                      defaultSp.AgeList),
                                                  savedPrefCard([],
                                                      'images/icons/religion.png',
                                                      defaultSp.ReligionList),
                                                  (widget.userSave!.religion ==
                                                          "Hindu")
                                                      ? savedPrefCard(
                                                          [],
                                                          'images/icons/kundli.png',
                                                          defaultSp
                                                              .KundaliDoshList)
                                                      : Container(width: 0),
                                                  savedPrefCard(
                                                      [],
                                                      'images/icons/marital_status.png',
                                                      defaultSp
                                                          .MaritalStatusList),
                                                  heightard([],
                                                      'images/icons/height.png',
                                                      defaultSp.HeightList),
                                                  savedPrefCard([],
                                                      'images/icons/food.png',
                                                      defaultSp.dietList),
                                                  savedPrefCard([],
                                                      'images/icons/education.png',
                                                      defaultSp.EducationList),
                                                  savedPrefCard([],
                                                      'images/icons/profession_suitcase.png',
                                                      defaultSp.ProfessionList),
                                                  newSavePrefModel == null
                                                      ? locationCard(
                                                          "Any",
                                                          'images/icons/location.png',
                                                          defaultSp.LocatioList)
                                                      : locationCard(
                                                          newSavePrefModel!
                                                                      .location
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
                                                          defaultSp
                                                              .LocatioList),
                                                  savedPrefCard([],
                                                      'images/icons/drink.png',
                                                      defaultSp.DrinkList),
                                                  savedPrefCard([],
                                                      'images/icons/smoke.png',
                                                      defaultSp.SmokeList),
                                                  (widget.userSave!
                                                              .Disability ==
                                                          "Normal")
                                                      ? Container(width: 0)
                                                      : savedPrefCard(
                                                          [],
                                                          'images/icons/disability.png',
                                                          defaultSp
                                                              .DisabilityList),
                                                  savedPrefCard([],
                                                      'images/icons/hand_rupee.png',
                                                      defaultSp.IncomeList),
                                                ],
                                              ),
                                            )
                                          : Wrap(children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
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
                                                          .religionList,
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
                                              // locationCard(
                                              //     newSavePrefModel!.location,
                                              //     'images/icons/location.png',
                                              //     defaultSp.LocatioList),
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
                                            ])),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.016),
                                        onExpandedChanged: (value) {
                                          if (userSave.status == "approved") {
                                            _moreNoti();
                                          }
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.011,
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ])),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.86,
              // bottom: MediaQuery.of(context).size.height * 0.005,
              child: Pbuttons(
                profileData: widget.userSave,
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
                        shadows: <Shadow>[
                          Shadow(color: Colors.black, blurRadius: 15.0)
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                : Container(width: 0, height: 0),
          ],
        ),
      ),
    );
  }
}
