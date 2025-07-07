import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/matchprofile/match_scroll.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/custom_spButton.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../data_collection/custom_app_bar.dart';



class MatchPerticularProfile extends StatefulWidget {
  final NewUserModel newUserModel;
  const MatchPerticularProfile({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<MatchPerticularProfile> createState() => _ReligionState();
}

class _ReligionState extends State<MatchPerticularProfile> {
  int value = 0;
  bool color = false;
  final TextEditingController controller = TextEditingController();
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          //SmokeStatus = text;
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.blue : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? Colors.blue : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar:CustomAppBar(title: "Match Profile", iconImage: "images/person.png",height: 80,),
      
body: Column(
          children: [
          
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.height * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  )),
                              child: TextFormField(
                                controller: controller,
                                textAlign: TextAlign.start,
                                cursorColor: main_color,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
                                    border: InputBorder.none,
                                    hintText: "Enter Profile ID",
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                  CustomSpecialButtom(
                    text: "Match Profile",
                    onTap: () async {
                      if (controller.text.isEmpty) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: SnackBarContent(
                                  error_text: "Please Enter Profile ID",
                                  appreciation: "",
                                  icon: Icons.error,
                                  sec: 3,
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                            });
                      } else {
                        int status;
                        status = await AdminService()
                            .findprofile(controller.text);
                        if (status == 200) {
                          NewUserModel newUserModel =
                              await SearchProfile().searchuserdatabyid(
                                  puid: controller.text);
                          if (newUserModel.gender ==
                              widget.newUserModel.gender) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: SnackBarContent(
                                      error_text:
                                          "Please Enter Valid Gender",
                                      appreciation: "",
                                      icon: Icons.error,
                                      sec: 3,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } else if (widget.newUserModel.puid == controller.text) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: SnackBarContent(
                                      error_text:
                                          "Please Enter Different ID",
                                      appreciation: "",
                                      icon: Icons.error,
                                      sec: 3,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } 
                          else {
                            Get.to(MatchSlideProfile(
                                  userSave: widget.newUserModel,
                                  user_list: [newUserModel],
                                  notiPage: true));
                          }
                        } else {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: SnackBarContent(
                                    error_text:
                                        "Please Enter Valid Profile ID",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        }
                      }
                    },
                    bordercolor:
                        color == false ? Colors.black : Colors.blue,
                  ),
                
                ],
              ),
            ))
          ],
        ));
  }
}
