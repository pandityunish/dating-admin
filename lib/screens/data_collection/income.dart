import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/location.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/G_Sign.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';

String? IncomeStatus;

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _ReligionState();
}

class _ReligionState extends State<Income> {
  int value = 0;
  UserService userService = Get.put(UserService());
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          IncomeStatus = text;
          value = index;
        });
        // setData();
        userService.userdata.addAll({"incomestatus": IncomeStatus});
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Location()));
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(horizontal: 65, vertical: 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? main_color : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBar(title: "Income", iconImage: 'images/icons/hand_rupee.png'), 
          body: SingleChildScrollView(
            child: Column(
              children: [
               
                Center(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("No Income", 1)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("0-1 Lakh", 2)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("1-3 Lakh", 3)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("3-6 Lakh", 4)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("6-9 Lakh", 5)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("9-12 Lakh", 6)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("12-15 Lakh", 7)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("15-20 Lakh", 8)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("20-25 Lakh", 9)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("25-30 Lakh", 10)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("30-35 Lakh", 11)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("35-40 Lakh", 12)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("40-45Lakh", 13)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("45-50 Lakh", 14)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("50-60 Lakh", 15)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("60-70 Lakh", 16)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("70-80 Lakh", 17)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("80-90 Lakh", 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Above 90 Lakh", 19)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Ask Directly", 20)),
                        SizedBox(
                          height: 10,
                        ),
                        /*ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => KundliDosh()));
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(fontSize: 40),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: main_color))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(main_color))),*/
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

// dynamic setData() async{
//   print(IncomeStatus);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid);

//   final json = {
//     'Income': IncomeStatus,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }
dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2?['uid'];
  print(IncomeStatus);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
  try {
    User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
    print(userSave.toString());

    userSave.Income = IncomeStatus;
    print(userSave.toJson().toString());
    final json = userSave.toJson();

    await sharedPref.save("user", userSave);
    await docUser.update(json).catchError((error) => print(error));
  } catch (Excepetion) {
    print(Excepetion);
  }
}
