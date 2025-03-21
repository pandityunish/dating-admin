// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:matrimony_admin/screens/profile/profileTypes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/sendLink.dart';
import 'package:matrimony_admin/screens/profie_types/delete_profiles.dart';
import 'package:matrimony_admin/screens/profie_types/option_types.dart';
import 'package:matrimony_admin/screens/profie_types/profile_type_scroll.dart';
import 'package:matrimony_admin/screens/profie_types/send_all_notifictaion.dart';
import 'package:matrimony_admin/screens/profie_types/send_link_selected.dart';
import 'package:matrimony_admin/screens/profie_types/sortby.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/search.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../navigation/audio_clip/audio_clip.dart';
import '../service/search_profile.dart';

class MainProfilesTypes extends StatefulWidget {
  const MainProfilesTypes({
    super.key,
  });

  @override
  State<MainProfilesTypes> createState() => _ReligionState();
}

class _ReligionState extends State<MainProfilesTypes> {
  int value = 0;
  String dropdownvalue = 'Action';
  var items = [
    'Action',
    'Profile View',
    'Download Excel',
    'Download Biodata',
    'Send OTP',
    'Send Link'
  ];
  List<NewUserModel> allusers = [];
  List<dynamic> userids = [];
  void getsearchusers() async {
    if (newProfileType == "Delete") {
      print("delete");
      allusers = await SearchProfile().deleteProfiles(page: 1, searchText: "");
    } else {
      allusers = await SearchProfile().profiletypesSearch(
          page: 1, searchText: newProfileType, gender: secondProfileType);
      for (var i = 0; i < allusers.length; i++) {
        userids.add(allusers[i].id);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getsearchusers();
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    bool borderColor = false;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (!isloading) {
                Navigator.of(context).pop();
              }
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: main_color,
              size: 25,
            ),
          ),
          title: Text(
              "Manage Profiles",
              style: TextStyle(color: main_color, fontSize: 23,fontWeight: FontWeight.bold),
            
          ), 
          
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
         
           Expanded(
             child: Column(children: [
                 Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (!isloading) {
                        if (listofadminpermissions!
                                .contains("Profile Types") ||
                            listofadminpermissions!.contains("All")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileType()));
                        }
                      }
                    },
                    child:const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child:  Text(
                        "Profile Types",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
                         
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (!isloading) {
                        if (listofadminpermissions!
                                .contains("Option Types") ||
                            listofadminpermissions!.contains("All")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OptionTypesProfiles()));
                        }
                      }
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child:  Text(
                        "Option Types",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              
              const SizedBox(
                height: 10,
              ),
             
              profileType == ""
                  ? const Center()
                  : Center(
                      child: SizedBox(
                          width: Get.width * 0.87,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                  "($thirdProfileType,$secondProfileType,$newProfileType,$profileType)")))),
              const SizedBox(
                height: 50,
              ),
               Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape: MaterialStateProperty
                              .all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: borderColor
                                            ? main_color
                                            : Colors.white,
                                      ))),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.white)),
                      child: const Text(
                        "Upload Excel",
                        style: TextStyle(
                         
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333),
                        ),
                      ),
                      onPressed: () async {
                      
                      },
                    ),
                  ),
                ),
              ),
              Center(
                  child: isloading
                      ? LoadingAnimationWidget.beat(
                          color: main_color,
                          size: 40,
                        )
                      : SizedBox(
                        width: 80,
                        child: DropdownButton(
                         isExpanded: true,
                         menuWidth: 200,
                          underline: Container(color: Colors.white,),
                            hint: const Text("Actions",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black)),
                            onChanged: (val) {
                              setState(() {
                                // this. = val;
                              });
                            },
                              
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: [
                              DropdownMenuItem(
                                  value: '2',
                                  child: GestureDetector(
                                    onTap: () {
                                      if (listofadminpermissions!
                                              .contains("Profile View") ||
                                          listofadminpermissions!
                                              .contains("All")) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PofileTypeSlideProfile(
                                                      searchText:
                                                          newProfileType,
                                                      user_list: allusers,
                                                    )));
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Profile View")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '7',
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isloading = true;
                                      });
                              
                                      if (listofadminpermissions!
                                              .contains("Download Excel") ||
                                          listofadminpermissions!
                                              .contains("All")) {
                                        SearchProfile()
                                            .downloadExcel(newProfileType)
                                            .whenComplete(() {
                                          isloading = false;
                                          setState(() {});
                                        });
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Download Excel")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '3',
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Download Biodata")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '4',
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Send OTP")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '5',
                                  child: GestureDetector(
                                    onTap: () {
                                      if (listofadminpermissions!
                                              .contains("Send Link") ||
                                          listofadminpermissions!
                                              .contains("All")) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SendLinkToAll(
                                                      searchtext: "",
                                                      allusers: allusers,
                                                      userids: userids,
                                                    )));
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Send Link")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '10',
                                  child: GestureDetector(
                                    onTap: () {
                                      if (listofadminpermissions!
                                              .contains("Send Notification") ||
                                          listofadminpermissions!
                                              .contains("All")) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SendAllNotification(
                                                      searchtext: "",
                                                      title: "",
                                                      users: allusers,
                                                    )));
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Send notification")],
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: '12',
                                  child: GestureDetector(
                                    onTap: () {
                                      if (listofadminpermissions!
                                              .contains("Send Audio Clip") ||
                                          listofadminpermissions!
                                              .contains("All")) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AudioClipScreen(
                                                      isBulk: "true",
                                                    )));
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text("Send Audio Clip")],
                                    ),
                                  )),
                            ],
                            // items.map((String items) {\
                            //   return DropdownMenuItem(
                            //     value: items,
                            //     child: Text(items),
                            //   );
                            // }).toList(),
                          ),
                      )),
             ],),
           ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(60.0),
                                    side: BorderSide(
                                      color: borderColor
                                          ? main_color
                                          : Colors.white,
                                    ))),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white)),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      if (!isloading) {
                        SearchProfile().addtoadminnotification(
                            userid: "212",
                            useremail: userSave.email!,
                            userimage: userSave.imageUrls!.isEmpty
                                ? ""
                                : userSave.imageUrls![0],
                            title:
                                "${userSave.displayName} RESET PROFILE TYPES ",
                            email: userSave.email!,
                            subtitle: "");
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
