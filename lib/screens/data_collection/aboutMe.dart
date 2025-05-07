import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/addPhotos.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Assets/G_Sign.dart';
import '../../globalVars.dart' as glb;
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'custom_app_bar.dart';
// import 'package:couple_match/screens/data_collection/kundli_dosh.dart';

// String? aboutMe ;

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _ReligionState();
}

class _ReligionState extends State<AboutMe> {
  int value = 0;
  var aboutMe = TextEditingController();
  var partnerPref = TextEditingController();
  String? puid;

  void setpuid() async {
    puid = await createPuid(userService.userdata["gender"]);

    setState(() {});
    print(puid);
  }

  @override
  void initState() {
    super.initState();
    setpuid();
  }

  // dynamic setData() async{
  //   // print(IncomeStatus);
  //   final docUser = FirebaseFirestore.instance
  //       .collection('user_data')
  //       .doc(uid);
  //   final prefs = await SharedPreferences.getInstance();
  //   final json = {
  //     'About_Me': aboutMe.text,
  //     'Partner_Prefs': partnerPref.text,
  //     // 'dob': dob
  //   };
  //   await prefs.setString('aboutme', aboutMe.text);
  //   await docUser.update(json).catchError((error) => print(error));
  // }
  dynamic setData() async {
    SharedPref sharedPref = SharedPref();
    final json2 = await sharedPref.read("uid");
    var uid = json2?['uid'];

    // print(Kundali_Dosh);
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
    try {
      User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
      print(userSave.toString());
      userSave.puid = await createPuid(userSave.gender);
      userSave.About_Me = aboutMe.text;
      userSave.Partner_Prefs = partnerPref.text;
      print(userSave.toJson().toString());
      final json = userSave.toJson();
      await sharedPref.save("user", userSave);
      setState(() {
        glb.userSave = userSave;
      });
      await docUser.update(json).catchError((error) => print(error));
    } catch (Excepetion) {
      print(Excepetion);
    }
  }

  UserService userService = Get.put(UserService());
  createPuid(gender) {
    int time = DateTime.now().millisecondsSinceEpoch - 1640975400000;
    String res = "";
    while (time > 0) {
      int temp = time % 36;
      if (temp < 10) {
        res = temp.toString() + res;
      } else {
        res = String.fromCharCode('A'.codeUnitAt(0) + temp - 10) + res;
      }
      time = time ~/ 36;
    }

    if (gender == 'male') {
      return 'FRWM$res';
    } else {
      return 'FRWF$res';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: "Detail In Brief",
            iconImage: 'images/icons/user_rounded.png'),
        body: Material(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  /*crossAxisAlignment: CrossAxisAlignment.start,*/
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About Me",
                              style: TextStyle(
                                  fontFamily: 'Sans-serif',
                                  color: main_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              controller: aboutMe,
                              maxLength: 300,
                              // maxLengthEnforcement: MaxLengthEnforcement
                              // .enforced, // show error message
                              // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                              minLines: 5,
                              maxLines: 7,
                              cursorColor: main_color,
                              cursorWidth: 2,
                              style: TextStyle(
                                  fontFamily: 'Sans-serif', fontSize: 14),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: glb.main_color)),
                                // hintText: 'User Name',
                                focusColor: main_color,
                                floatingLabelStyle:
                                    TextStyle(color: main_color),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                label: Text(
                                  'Please Describe in Brief about yourself like \nOccupation,Education,Hobby,Interest,Family \nBackground Etc.\n(Note: Do Not Share Contact Detail Here)',
                                  //  style: TextStyle(color: newtextColor),
                                ),
                              ),
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //       borderSide: new BorderSide(color: glb.main_color)),
                              //   focusedBorder: OutlineInputBorder(
                              //       borderSide: new BorderSide(color: glb.main_color)),
                              //   // labelText: 'Write Here',
                              // ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Partner Preference",
                              style: TextStyle(
                                  fontFamily: 'Sans-serif',
                                  color: main_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              minLines: 5,
                              maxLines: 7,

                              maxLength: 300,
                              cursorColor: main_color,
                              cursorWidth: 2,
                              // maxLengthEnforcement: MaxLengthEnforcement.enforced, // show error message
                              // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                              style: TextStyle(
                                  fontFamily: 'Sans-serif', fontSize: 14),
                              controller: partnerPref,

                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: glb.main_color)),
                                border: OutlineInputBorder(),
                                // hintText: 'Partner preference',r
                                //  labelStyle: TextStyle(color: main_color),
                                focusColor: main_color,
                                floatingLabelStyle:
                                    TextStyle(color: main_color),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                label: Text(
                                  'Please Describe in Brief about Partner Preference \nLike Occupation,Education,Hobby,Interest,Family \nBackground, Location Etc. \n(Note: Do Not Share Contact Detail Here).',
                                  //  style: TextStyle(color: newtextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.28,
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.32,
                        // ),
                      ],
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 15),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 17)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: (color_done2 == false)
                                            ? Colors.white
                                            : glb.main_color,
                                      ))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            setState(() {
                              color_done2 = true;
                            });
                            // setData();
                            userService.userdata.addAll({
                              "aboutme": aboutMe.text,
                              "patnerpref": partnerPref.text,
                              "puid": puid
                            });
                            print(userService.userdata);
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 0),
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 0),
                                    pageBuilder: (_, __, ___) => AddPics()));
                          },
                          child: Text(
                            "Continue",
                            style: (color_done2 == false)
                                ? TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Serif',
                                    fontWeight: FontWeight.w700)
                                : TextStyle(
                                    color: glb.main_color,
                                    fontSize: 20,
                                    fontFamily: 'Serif',
                                    fontWeight: FontWeight.w700),
                          )),
                    ),
                  ])),
        ),
      ),
    );
  }

  bool color_done2 = false;
}
