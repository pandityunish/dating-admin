import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/screens/data_collection/height.dart';

import '../../Assets/Error.dart';
import '../../globalVars.dart';
import '../service/auth_service.dart';
import 'custom_app_bar.dart';
import 'profession.dart';

class MannualDisabiligy extends StatefulWidget {
  const MannualDisabiligy({super.key});

  @override
  State<MannualDisabiligy> createState() => _MannualEducationState();
}

class _MannualEducationState extends State<MannualDisabiligy> {
  TextEditingController name = TextEditingController();
  final _focusNode1 = FocusNode();
  UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBar(
              title: "Disability With Person",
              iconImage: 'images/icons/disability.png'),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Center(
                        child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: SizedBox(
                                height: 65,
                                child: TextField(
                                  cursorColor: main_color,
                                  cursorWidth: 2,
                                  maxLength: 30,
                                  maxLines: 1,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  focusNode: _focusNode1,
                                  controller: name,
                                  decoration: InputDecoration(
                                    hintText: "Enter Disability",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Colors.grey), // Normal border
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: main_color,
                                          width: 1.5), // Focused border
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  onChanged: (name) => {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                Container(
                  // margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 15)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        // if(key.currentState!.validate()){

                        // if(landmarkssug.contains(birthPlaceController.text)){
                        //   print(birthPlaceController.text);
                        // }
                        // if(key.currentState!.validate()){
                        // print(phone_num.length);
                        // onpressed();
                        // }

                        // print(phone_num.length);
                        //              selectedhours="Hours";
                        //  selectedminutes="Minutes";
                        if (name.text.isEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Please Enter Disability",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 1,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        } else {
                          userService.userdata
                              .addAll({"disability": name.text});
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 0),
                                  reverseTransitionDuration:
                                      Duration(milliseconds: 0),
                                  pageBuilder: (_, __, ___) => Height()));
                        }

                        // }

                        // print(birthPlaceController.text);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Serif'),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
