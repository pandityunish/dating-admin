import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/diet.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/G_Sign.dart';
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';

String? Martial_Status;

class MStatus extends StatefulWidget {
  const MStatus({Key? key}) : super(key: key);

  @override
  State<MStatus> createState() => _ReligionState();
}

class _ReligionState extends State<MStatus> {
  int value = 0;
  UserService userService = Get.put(UserService());
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          Martial_Status = text;
          value = index;
        });
        // setData();
        userService.userdata.addAll({"maritalstatus": Martial_Status});
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Diet()));
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
          appBar:CustomAppBar(title: "Marital Status", iconImage: 'images/icons/marital_status.png'),
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
                            child: CustomRadioButton("Unmarried", 1)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Divorced", 2)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child:
                                CustomRadioButton("Divorced With Children", 3)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Widowed", 4)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Widowed With Children", 5)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Separated", 6)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Annulled", 7)),
                        SizedBox(
                          height: 10,
                        ),
                        (userSave.religion == "Muslim")
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: CustomRadioButton("Married", 8))
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Awaiting Divorce", 9)),
                        SizedBox(
                          height: 10,
                        ),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       Navigator.of(context).push(
                        //           MaterialPageRoute(builder: (context) => Diet()));
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
//   print(Martial_Status);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid_value);

//   final json = {
//     'MartialStatus': Martial_Status,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }
dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2?['uid'];
  print(Martial_Status);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
  try {
    User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
    print(userSave.toString());

    userSave.MartialStatus = Martial_Status;
    print(userSave.toJson().toString());
    final json = userSave.toJson();

    await sharedPref.save("user", userSave);
    await docUser.update(json).catchError((error) => print(error));
  } catch (Excepetion) {
    print(Excepetion);
  }
}
