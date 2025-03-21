import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/G_Sign.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'custom_app_bar.dart';

String? SmokeStatus;

class Smoke extends StatefulWidget {
  const Smoke({Key? key}) : super(key: key);

  @override
  State<Smoke> createState() => _ReligionState();
}

class _ReligionState extends State<Smoke> {
  UserService userService = Get.put(UserService());
  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          SmokeStatus = text;
          value = index;
        });
        // setData();
        userService.userdata.addAll({"smoke": SmokeStatus});
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Disability()));
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 15)),
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
          appBar:CustomAppBar(title: "Smoke", iconImage: 'images/icons/smoke.png'),
          body: SingleChildScrollView(
            child: Column(
              children: [
             
                Center(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Yes", 1)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("No", 2)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Occasionally", 3)),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => Disability()));
                        //     },
                        //     child: Text(
                        //       "Continue",
                        //       style: TextStyle(fontSize: 40),
                        //     ),
                        //     style: ButtonStyle(
                        //         shape: MaterialStateProperty.all<
                        //                 RoundedRectangleBorder>(
                        //             RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(18.0),
                        //                 side: BorderSide(color: main_color))),
                        //         backgroundColor:
                        //             MaterialStateProperty.all<Color>(main_color))),
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
//   print(SmokeStatus);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid);

//   final json = {
//     'Smoke': SmokeStatus,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }
dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2?['uid'];
  print(SmokeStatus);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
  try {
    User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
    print(userSave.toString());

    userSave.Smoke = SmokeStatus;
    print(userSave.toJson().toString());
    final json = userSave.toJson();
    await sharedPref.save("user", userSave);
    await docUser.update(json).catchError((error) => print(error));
  } catch (Excepetion) {
    print(Excepetion);
  }
}
