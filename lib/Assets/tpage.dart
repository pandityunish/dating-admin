import 'dart:convert';
// import 'dart:js';

import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';
import 'package:matrimony_admin/screens/data_collection/Kundali%20Dosh.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/addPhotos.dart';
import 'package:matrimony_admin/screens/data_collection/diet.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/data_collection/drink.dart';
import 'package:matrimony_admin/screens/data_collection/education.dart';
import 'package:matrimony_admin/screens/data_collection/height.dart';
import 'package:matrimony_admin/screens/data_collection/income.dart';
import 'package:matrimony_admin/screens/data_collection/location.dart' as lcn;
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';
import 'package:matrimony_admin/screens/data_collection/profession.dart';
import 'package:matrimony_admin/screens/data_collection/religion.dart';
import 'package:matrimony_admin/screens/data_collection/smoke.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../models/shared_pref.dart';
import '../models/user_model.dart';
// import '../screens/profile/ProfilePage.dart';
import '../screens/profile/profileScroll.dart';

class Tpage {
  static Future<void> transferPage(context, var pname) async {
    SharedPref sharedPref = SharedPref();

    print("transfer Page running ......");
    try {
      User userSave = User.fromJson(await sharedPref.read("user") ?? {});
      print("userSave : ${userSave}");
      if (userSave.name != "") {
        if (userSave.religion != "") {
          if (userSave.religion == "Hindu" && userSave.KundaliDosh == "") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Kundali_Dosh()));
          } else if ((userSave.religion == "Hindu" &&
                  userSave.KundaliDosh != "") ||
              (userSave.religion != "Hindu")) {
            if (userSave.MartialStatus != "") {
              if (userSave.Diet != "") {
                if (userSave.Drink != "") {
                  if (userSave.Smoke != "") {
                    if (userSave.Disability != "") {
                      if (userSave.Height != "") {
                        if (userSave.Education != "") {
                          if (userSave.Profession != "") {
                            if (userSave.Income != "") {
                              if (userSave.Location != "") {
                                if (userSave.About_Me != "" &&
                                    userSave.Partner_Prefs != "" &&
                                    userSave.imageUrls != null &&
                                    userSave.imageUrls!.isNotEmpty) {
                                  // if () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (builder) => SlideProfile()),
                                      (route) => false);
                                  // } else {
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) => AddPics()));
                                  // }
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AboutMe()));
                                }
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => lcn.Location()));
                              }
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Income()));
                            }
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Profession()));
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Education()));
                        }
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Height()));
                      }
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Disability()));
                    }
                  } else {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Smoke()));
                  }
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Drink()));
                }
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Diet()));
              }
            } else {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MStatus()));
            }
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MStatus()));
          }
        } else {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Religion()));
        }
      }
      if (userSave.name != null && pname != "main") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LetsStart()));
      }
    } catch (Excepetion) {
      print(Excepetion);
    }
  }
}
