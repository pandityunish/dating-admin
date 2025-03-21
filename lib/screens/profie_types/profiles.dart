// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:matrimony_admin/screens/profile/profileTypes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/models/delete_profile.dart';

import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/sendLink.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip.dart';
import 'package:matrimony_admin/screens/profie_types/delete_profiles.dart';
import 'package:matrimony_admin/screens/profie_types/profile_type_scroll.dart';
import 'package:matrimony_admin/screens/profie_types/send_all_notifictaion.dart';
import 'package:matrimony_admin/screens/profie_types/send_link_selected.dart';
import 'package:matrimony_admin/screens/profie_types/sortby.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/search.dart';

import '../../globalVars.dart';
import '../service/search_profile.dart';

class Profiles extends StatefulWidget {
  final String? searchText;
  final String? title;
  const Profiles({
    Key? key,
    this.searchText,
    this.title,
  }) : super(key: key);

  @override
  State<Profiles> createState() => _ReligionState();
}

class _ReligionState extends State<Profiles> {
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
    try {
      if (widget.searchText == "Delete") {
        print("delete");
        allusers =
            await SearchProfile().deleteProfiles(page: 1, searchText: "");
      } else {
        allusers = await SearchProfile().profiletypesSearch(
            page: 1, searchText: widget.searchText!, gender: "");
        for (var i = 0; i < allusers.length; i++) {
          userids.add(allusers[i].id);
        }
      }

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
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
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: main_color,
                size: 25,
              ),
            ),
            middle:
                Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
              TextSpan(
                  text: "Free",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Showg")),
              TextSpan(
                  text: "rishteywala",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: main_color,
                      fontFamily: "Showg")),
            ])),
            previousPageTitle: "",
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProfileType()));
                      },
                      child: Text(
                        widget.title!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  width: 15,
                ),
                // Center(
                //     child: DropdownButton(
                //   hint: Text("Gender",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w800, color: Colors.black)),
                //   onChanged: (val) {
                //     setState(() {
                //       // this. = val;
                //     });
                //   },

                //   icon: const Icon(Icons.keyboard_arrow_down),
                //   items: [
                //     DropdownMenuItem(
                //         value: '2',
                //         child: GestureDetector(
                //           onTap: () async {
                //             setState(() {
                //               allusers.clear();
                //             });
                //             allusers = await SearchProfile().profiletypesSearch(
                //                 page: 1,
                //                 searchText: widget.searchText!,
                //                 gender: "");
                //             for (var i = 0; i < allusers.length; i++) {
                //               userids.add(allusers[i].id);
                //             }
                //             setState(() {});
                //           },
                //           child: const Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [Text("All")],
                //           ),
                //         )),
                //     DropdownMenuItem(
                //         value: '7',
                //         child: GestureDetector(
                //           onTap: () async {
                //             setState(() {
                //               allusers.clear();
                //             });
                //             allusers = await SearchProfile().profiletypesSearch(
                //                 page: 1,
                //                 searchText: widget.searchText!,
                //                 gender: "male");
                //             for (var i = 0; i < allusers.length; i++) {
                //               userids.add(allusers[i].id);
                //             }
                //             setState(() {});
                //           },
                //           child: const Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [Text("Male")],
                //           ),
                //         )),
                //     DropdownMenuItem(
                //         value: '3',
                //         child: GestureDetector(
                //           onTap: () async {
                //             setState(() {
                //               allusers.clear();
                //             });
                //             allusers = await SearchProfile().profiletypesSearch(
                //                 page: 1,
                //                 searchText: widget.searchText!,
                //                 gender: "female");
                //             for (var i = 0; i < allusers.length; i++) {
                //               userids.add(allusers[i].id);
                //             }
                //             setState(() {});
                //           },
                //           child: const Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [Text("Female")],
                //           ),
                //         )),
                //   ],
                //   // items.map((String items) {
                //   //   return DropdownMenuItem(
                //   //     value: items,
                //   //     child: Text(items),
                //   //   );
                //   // }).toList(),
                // )),
                SizedBox(
                  height: 50,
                ),
                allusers.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          color: main_color,
                        ),
                      )
                    : Center(
                        child: DropdownButton(
                        hint: Text("Actions",
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
                                  if (widget.searchText == "Delete") {
                                    SearchProfile().addtoadminnotification(
                                        userid: "",
                                        useremail: "",
                                        userimage: "",
                                        title:
                                            '${userSave.displayName} SEEN ${widget.title} PROFILES ',
                                        email: "",
                                        subtitle: "");
                                    print("ok");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DeleteProfile(
                                                  searchText: widget.searchText,
                                                  user_list: allusers,
                                                )));
                                  } else {
                                    SearchProfile().addtoadminnotification(
                                        userid: "",
                                        useremail: "",
                                        userimage: "",
                                        title:
                                            '${userSave.displayName} SEEN ${widget.title} BY PROFILES TYPES ',
                                        email: "",
                                        subtitle: "");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PofileTypeSlideProfile(
                                                  searchText: widget.searchText,
                                                  user_list: allusers,
                                                )));
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Profile View")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '7',
                              child: GestureDetector(
                                onTap: () {
                                  if (listofadminpermissions!
                                          .contains("Can Download excel/PDF") ||
                                      listofadminpermissions!.contains("All")) {
                                    isloading = true;
                                    setState(() {});
                                    SearchProfile().addtoadminnotification(
                                        userid: "",
                                        useremail: "",
                                        userimage: "",
                                        title:
                                            '${userSave.displayName} DOWNLOAD EXCEL ${widget.title} ',
                                        email: "",
                                        subtitle: "");
                                    SearchProfile()
                                        .downloadExcel(widget.searchText!)
                                        .whenComplete(() {
                                      isloading = false;
                                      setState(() {});
                                    });
                                    Navigator.pop(context);
                                  }
                                  print(widget.searchText!);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Download Excel")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '3',
                              child: GestureDetector(
                                onTap: () {
                                  SearchProfile().addtoadminnotification(
                                      userid: "",
                                      useremail: "",
                                      userimage: "",
                                      title:
                                          '${userSave.displayName} DOWNLOAD BIODATA ${widget.title} ',
                                      email: "",
                                      subtitle: "");
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Download Biodata")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '4',
                              child: GestureDetector(
                                onTap: () {
                                  SearchProfile().addtoadminnotification(
                                      userid: "",
                                      useremail: "",
                                      userimage: "",
                                      title:
                                          '${userSave.displayName} SEND OTP ${widget.title} ',
                                      email: "",
                                      subtitle: "");
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Send OTP")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '5',
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SendLinkToAll(
                                            searchtext: widget.searchText!,
                                            allusers: allusers,
                                            userids: userids,
                                          )));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Send Link")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '10',
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SendAllNotification(
                                            searchtext: widget.searchText!,
                                            title: widget.title!,
                                            users: allusers,
                                          )));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text("Send notification")],
                                ),
                              )),
                          DropdownMenuItem(
                              value: '12',
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AudioClipScreen(isBulk: "true",)));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                      )),
                isloading == false
                    ? Container()
                    : Center(child: Text("Downloading")),
                SizedBox(
                  height: 300,
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
                                MaterialStateProperty.all<Color>(Colors.white)),
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
