
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/screens/data_collection/income.dart';

import '../../globalVars.dart';
import '../service/auth_service.dart';
import 'custom_app_bar.dart';

class MannulProfession extends StatefulWidget {
  const MannulProfession({super.key});

  @override
  State<MannulProfession> createState() => _MannulProfessionState();
}

class _MannulProfessionState extends State<MannulProfession> {
      TextEditingController name = TextEditingController();
  final _focusNode1 = FocusNode();
  UserService userService=Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar:CustomAppBar(title: "Other Profession", iconImage: 'images/icons/profession_suitcase.png'),

         
          body: Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                     
                     Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: TextField(
                                  // height: 20.0,
                                  
                                  maxLength: 15,
                                maxLines: 1,
                                                                
                                  maxLengthEnforcement: MaxLengthEnforcement
                                      .enforced, // show error message
                                  // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                                  
                                  focusNode: _focusNode1,
                                  controller: name,
                                  decoration: InputDecoration(
                                    hintText: "Enter Profession",
                                    border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _focusNode1.hasFocus
                                          ? main_color
                                          : Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  onChanged: (name) => {
                                   
                                  },
                                ),
                              ),
                              
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
                                          EdgeInsets.symmetric(vertical: 15)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              side: BorderSide(
                                                color:  Colors.white
                                                    ,
                                              ))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
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
                 if(name.text.isEmpty){
 showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Profession",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
              }else{
                 userService.userdata.addAll({"profession":name.text});
                      Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 0),
                    reverseTransitionDuration: Duration(milliseconds: 0),
                    pageBuilder: (_, __, ___) => Income()));
                                    // }
              }
                                    // print(birthPlaceController.text);
                                  },
                                  child: Text(
                                    "Save",
                                    style:  TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Serif')
                                        ,
                                  )),
                            ),
                ],
              ),
            ),
          )),
    );
  }
}