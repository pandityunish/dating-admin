import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/Kundali%20Dosh.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/G_Sign.dart';
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'martial_status.dart';

String? religion_text;

class Religion extends StatefulWidget {
  final String User_Name;
  final String User_SurName;
  final String age;
  final String timeofbirth;
  final String phone_num;
  final String placeofbirth;
  final String gender;
  final int dob;
  final String email;
  const Religion(
      {Key? key,
      required this.User_Name,
      required this.User_SurName,
      required this.age,
      required this.timeofbirth,
      required this.phone_num,
      required this.placeofbirth,
      required this.gender,
      required this.dob,
      required this.email})
      : super(key: key);

  @override
  State<Religion> createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  int value = 0;
  UserService userService = Get.put(UserService());
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          religion_text = text;
          value = index;
          setData();
          userService.userdata.addAll({
            "religion": religion_text,
            "email": widget.email,
            "name": widget.User_Name,
            "surname": widget.User_SurName,
            "age": widget.age,
            "phone": widget.phone_num,
            "dob": widget.dob,
            "gender": widget.gender,
            "timeofbirth": widget.timeofbirth,
            "placeofbirth": widget.placeofbirth
          });

          // print(text);
        });

        if (text == "Hindu") {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 0),
                  reverseTransitionDuration: Duration(milliseconds: 0),
                  pageBuilder: (_, __, ___) => Kundali_Dosh()));
        } else {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 0),
                  reverseTransitionDuration: Duration(milliseconds: 0),
                  pageBuilder: (_, __, ___) => MStatus()));
        }
        selectedhours = "Hours";
        selectedminutes = "Minutes";
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
          appBar:CustomAppBar(title: "Religion", iconImage: 'images/icons/religion.png'),
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
                            child: CustomRadioButton("Hindu", 1)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Muslim", 2)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Sikh", 3)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Christian", 4)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Buddhist", 5)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Jewish", 6)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Parsi", 7)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Atheist", 8)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Non Religious", 9)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CustomRadioButton("Other", 10)),
                        SizedBox(
                          height: 10,
                        ),
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

dynamic Run(text) {
  if (text == "Hindu") {
    // Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Kundali_Dosh()));
  }
}

dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2?['uid'];

  print(religion_text);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);

  // final json = {
  //   'religion': religion_text,
  //   // 'dob': dob
  // };
  // User? userSave;
  try {
    User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
    print(userSave.toString());

    userSave.religion = religion_text;
    print(userSave.toJson().toString());
    final json = userSave.toJson();
    userSave = userSave;
    await sharedPref.save("user", userSave);
    await docUser.update(json).catchError((error) => print(error));
  } catch (Excepetion) {
    print(Excepetion);
  }
}
