import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/disability_manual.dart';
import 'package:matrimony_admin/screens/data_collection/height.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/G_Sign.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'custom_app_bar.dart';

String? DisabilityStatus;

class Disability extends StatefulWidget {
  const Disability({Key? key}) : super(key: key);

  @override
  State<Disability> createState() => _ReligionState();
}

class _ReligionState extends State<Disability> {
  UserService userService = Get.put(UserService());
  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        if(text=="Other"){
            Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => const MannualDisabiligy()));
        }else{
            setState(() {
          DisabilityStatus = text;
          value = index;
        });
        // setData();
        userService.userdata.addAll({"disability": DisabilityStatus});
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Height()));
        }
      
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
          appBar: CustomAppBar(title: "Disability With Person", iconImage: 'images/icons/disability.png'),
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
                            child: CustomRadioButton("Normal", 1)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Physically Challenged", 2)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Mentally Challenged", 3)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Other", 4)),
                        SizedBox(
                          height: 10,
                        ),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => Height()));
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
//   print(DisabilityStatus);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid);

//   final json = {
//     'Disability': DisabilityStatus,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }
dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2?['uid'];
  print(DisabilityStatus);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
  try {
    User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
    print(userSave.toString());

    userSave.Disability = DisabilityStatus;
    print(userSave.toJson().toString());
    final json = userSave.toJson();
    await sharedPref.save("user", userSave);
    await docUser.update(json).catchError((error) => print(error));
  } catch (Excepetion) {
    print(Excepetion);
  }
}
