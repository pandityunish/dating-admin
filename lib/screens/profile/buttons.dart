// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';

import '../../Assets/Error.dart';
import '../../Assets/sendMessage.dart';
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import '../service/search_profile.dart';
import 'package:http/http.dart' as http;

class Pbuttons extends StatefulWidget {
  Pbuttons({
    super.key,
    required this.profileData,
    this.type = "",
  });
  NewUserModel? profileData;
  String type;

  @override
  State<Pbuttons> createState() => _PbuttonsState();
}

class _PbuttonsState extends State<Pbuttons> {
  // User? userSave;
  var uid;
  SharedPref sharedPref = SharedPref();
  initState() {
    setData();
  }

  bool buttonclicked = false;
  bool reporting = false;
  bool connectNow = false;

  setData() async {
    // final json2 = await sharedPref.read("uid");
    // final json3 = await sharedPref.read("user");
    // setState(() {
    //   uid = json2['uid'];
    //   // print("uid : $uid");
    //   userSave = User.fromJson(json3);
    // });
  }

  SendMessage sendMessage = SendMessage();

  Future<void> connect_now() async {
    // print(userSave.uid);
    // print(uid);
    Friend friend = Friend(
        date: DateTime.now().toString(),
        fromUid: userSave!.uid,
        toUid: widget.profileData!.id);
    // print("friend id : ${widget.profileData!.uid}");
    // print(friend.toJson().toString());
    final docUser = await FirebaseFirestore.instance
        .collection('friend_list')
        .doc(uid)
        .get();
    final docReceiver = await FirebaseFirestore.instance
        .collection('friend_list')
        .doc(friend.toUid)
        .get();

    // print("fl.sent : ${fl!.sent!.toString()}");
    if (docUser.exists) {
      FirebaseFirestore.instance.collection("friend_list").doc("$uid").update({
        "sent": FieldValue.arrayUnion([friend.toJson()])
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: SnackBarContent(
                error_text: "Intrest Sent Successfully",
                appreciation: "Congratulations",
                icon: Icons.check,
                sec: 2,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.06),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ));
    } else {
      FirebaseFirestore.instance.collection("friend_list").doc("$uid").set({
        "sent": FieldValue.arrayUnion([friend.toJson()])
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: SnackBarContent(
                error_text: "Intrest Sent Successfully",
                appreciation: "Congratulations",
                icon: Icons.check,
                sec: 2,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.06),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ));
    }
    if (docReceiver.exists) {
      FirebaseFirestore.instance
          .collection("friend_list")
          .doc("${friend.toUid}")
          .update({
        "received": FieldValue.arrayUnion([friend.toJson()])
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: SnackBarContent(
                    error_text: "Intrest Sent Successfully",
                    appreciation: "Congratulations",
                    icon: Icons.check,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ));

      // setState(() {
      //   connectNow = (!connectNow) ?  true :  false;
      // });
    } else {
      FirebaseFirestore.instance
          .collection("friend_list")
          .doc("${friend.toUid}")
          .set({
        "received": FieldValue.arrayUnion([friend.toJson()])
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: SnackBarContent(
                    error_text: "Intrest Sent Successfully",
                    appreciation: "Congratulations",
                    icon: Icons.check,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ));
      // setState(() {
      //   connectNow = (!connectNow) ? true : false;
      // });
    }
    friends!.add("${friend.toUid}");
    // fl!.sent!.add(friend);
    fl!.sent!.add(friend.toJson());
    print("${userSave!.name}");
    sendMessage.sendPushMessage(
        "${userSave!.name} has requested to connect with you",
        "Connect Request",
        userSave!.uid!,
        "profilepage",
        widget.profileData!.token!);
    await sharedPref.save("friendList", fl);
    setState(() {
      connectNow = (!connectNow) ? true : false;
    });
  }

  Future<void> block() async {
    // final docUser = FirebaseFirestore.instance
    //     .collection('user_data')
    //     .doc(widget.profileData!.id);
    // try {
    if (listofadminpermissions!.contains("Can block profiles") ||
        listofadminpermissions!.contains("All")) {
      setState(() {
        widget.profileData!.status = "block";
      });
      HomeService().addtoblock(email: widget.profileData!.email);
      SearchProfile().addtoadminnotification(
          userid: widget.profileData!.id!,
          useremail: widget.profileData!.email!,
          userimage: widget.profileData!.imageurls!.isEmpty
              ? ""
              : widget.profileData!.imageurls![0],
          title:
              "${userSave.displayName} BLOCK ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
          email: userSave.email!,
          subtitle: "");
    }
  }

  Future<void> report() async {
    // final docUser = FirebaseFirestore.instance
    //     .collection('user_data')
    //     .doc(widget.profileData!.uid);
    // try {
    setState(() {
      widget.profileData!.status = "report";
    });
    HomeService().addtoreportlist(email: widget.profileData!.email);
    SearchProfile().addtoadminnotification(
        userid: widget.profileData!.id!,
        useremail: widget.profileData!.email!,
        userimage: widget.profileData!.imageurls!.isEmpty
            ? ""
            : widget.profileData!.imageurls![0],
        title:
            "${userSave.displayName} REPORTED ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
        email: userSave.email!,
        subtitle: "");
         showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SnackBarContent(
              error_text: "Profile Report Successfully",
              appreciation: "",
              icon: Icons.check_circle,
              sec: 2,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        });

  }

  Future<void> shortList() async {
    if (listofadminpermissions!.contains("Can shortlist profiles") ||
        listofadminpermissions!.contains("All")) {
      print(userSave!.email);
      shortFriend!.add(widget.profileData!.id);
      HomeService()
          .addtosortlist(
              email: userSave!.email!, profileid: widget.profileData!.id)
          .whenComplete(() {
        HomeService().getuserdata();
      });
      setState(() {});
    }
  }

  getFriendData() {}

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Center(
        child: Container(
          width: Get.width,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.05),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 5,),
            Container(
              // padding: const EdgeInsets.only(left: 28, right: 28),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // minimumSize: Size(200, 50),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.95, 48),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: (widget.profileData!.status == "approved")
                            ? main_color
                            : Colors.black12,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
                child: widget.type == "true"
                    ? Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )
                    : Text(
                        (widget.profileData!.status == "approved")
                            ? "Chat Now"
                            : (widget.profileData!.editstatus == "" &&
                                    widget.profileData!.status == "")
                                ? "Approve"
                                : (widget.profileData!.editstatus ==
                                        "unapprove")
                                    ? "Edit Approve"
                                    : "Approve",
                        style: TextStyle(
                            color: (widget.profileData!.status == "approved")
                                ? main_color
                                : Colors.black,
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                onPressed: () {
                  if (widget.profileData!.status == "approved") {
                    // cancel_req();
                  } else {
                    if (listofadminpermissions!
                            .contains("Can Approve Profile") ||
                        listofadminpermissions!.contains("All")) {
                      approveProfile();
                    }
                    if (widget.profileData!.editstatus == "unapprove") {
                      editApproveProfile();
                    }

                    // connect_now();
                  }
                },
              ),
            ),
           SizedBox(height: 3,),
            Container(
                width: MediaQuery.of(context).size.width*.95,
                // padding: EdgeInsets.only(left: 34, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width / 4,
                                  48),
                              // minimumSize: Size(150, 50),
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: (widget.profileData!.status == "block")
                                    ? BorderSide(width: 1, color: Colors.red)
                                    : BorderSide(
                                        width: 1, color: Colors.black12),
                                // side: BorderSide(width: 1, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              )),
                          child: Text(
                              (widget.profileData!.status == "block")
                                  ? "Block"
                                  : "Block",
                              style: TextStyle(
                                fontSize: 15,
                                color: (widget.profileData!.status == "block")
                                    ? Colors.red
                                    : Colors.black,
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.w700,
                              )),
                          onPressed: () {
                            if (listofadminpermissions!
                                    .contains("Can Block Profile") ||
                                listofadminpermissions!.contains("All") ||
                                listofadminpermissions!
                                    .contains("Can Unblock Profile")) {
                              (widget.profileData!.status == "block")
                                  ? unblock()
                                  : block();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 4, 48),
                            // minimumSize: Size(150, 50),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: (widget.profileData!.status == "report")
                                  ? BorderSide(width: 1, color: Colors.red)
                                  : BorderSide(width: 1, color: Colors.black12),
                              // side: BorderSide(width: 1, color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            )),
                        onPressed: () {
                          if (listofadminpermissions!
                                  .contains("Can Report Profile") ||
                              listofadminpermissions!.contains("All") ||
                              listofadminpermissions!
                                  .contains("Can Unblock Profile")) {
                            (widget.profileData!.status == "report")
                                ? unreport()
                                : report();
                          }
                        },
                        child: Text(
                          (widget.profileData!.status == "report")
                              ? "Report"
                              : "Report",
                          style: TextStyle(
                            fontSize: 15,
                            color: (widget.profileData!.status == "report")
                                ? Colors.red
                                : Colors.black,
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 4, 48),
                            // minimumSize: Size(150, 50),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: (shortFriend!
                                      .contains(widget.profileData!.id))
                                  ? BorderSide(width: 1, color: main_color)
                                  : BorderSide(width: 1, color: Colors.black12),
                              // side: BorderSide(width: 1, color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            )),
                        child: Text(
                            (shortFriend!.contains(widget.profileData!.id))
                                ? "Shortlist"
                                : "Shortlist",
                            style: TextStyle(
                              fontSize: 15,
                              color: (shortFriend!
                                      .contains(widget.profileData!.id))
                                  ? main_color
                                  : Colors.black,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w700,
                            )),
                        onPressed: () {
                          if (listofadminpermissions!
                                  .contains("Can Sortlist Profile") ||
                              listofadminpermissions!.contains("All") ||
                              listofadminpermissions!
                                  .contains("Can Unsortlist Profile")) {
                            (shortFriend!.contains(widget.profileData!.id))
                                ? unshortList()
                                : shortList();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  void sendPushMessagetoallusers(String body, String title, String uid,
      String username, String token) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAARNDuqEs:APA91bFMhCmAO8olPfJxG868C9czilKHzNIk_pYuXBJ7iFrGiK6bPl6K_O5Uqkq607hZFu_ScIfyCRq7ZBnHTtz_vl6HvrIvdDwxu_nxP4P4E-pDpGvIeGhP5Z3CQoxgwq6sZTlFLtYa',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'icon': 'ic_launcher'
            },
            "android": {"priority": "high"},
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'uid': uid,
              'route': "",
              'id': uid,
              'userName': username,
              'status': 'done',
              'sound': ""
            },
            "to": token,
          },
        ),
      );

      print(res.body);
    } catch (e) {
      print("error push notification");
    }
  }

  // functions to remove from list
  Future<void> editApproveProfile() async {
    print("edit approve clicked");
  }

  Future<void> approveProfile() async {
    if (listofadminpermissions!.contains("Can approve profiles") ||
        listofadminpermissions!.contains("All")) {
      if (widget.profileData!.status == "report") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            content: const SnackBarContent(
              error_text: "Please unreport profile First to Approve",
              appreciation: "",
              icon: Icons.check,
              sec: 2,
            ),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: MediaQuery.of(context).size.width * 0.06),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } else if (widget.profileData!.status == "block") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            content: const SnackBarContent(
              error_text: "Please unblock profile First to Approve",
              appreciation: "",
              icon: Icons.check,
              sec: 2,
            ),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: MediaQuery.of(context).size.width * 0.06),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } else {
        HomeService().approveuser(widget.profileData!.email);
        for (var i = 0;
            i < widget.profileData!.unapproveActivites.length;
            i++) {
          HomeService().addtoactivities(
              email: widget.profileData!.unapproveActivites[i].email,
              title: widget.profileData!.unapproveActivites[i].title,
              username: widget.profileData!.name,
              userid: widget.profileData!.id);
          if (widget.profileData!.unapproveActivites[i].title
              .contains("SENT")) {
            HomeService().sendrequest(
                email: widget.profileData!.email,
                sendemail: widget.profileData!.unapproveActivites[i].email,
                senduid: widget.profileData!.unapproveActivites[i].reciveuserid,
                profileid: widget.profileData!.id);
          }
          sendPushMessagetoallusers(
              widget.profileData!.unapproveActivites[i].title,
              "Free rishtey wala",
              widget.profileData!.id,
              widget.profileData!.name,
              widget.profileData!.unapproveActivites[i].token);
        }
        HomeService().updateunapproveactivites(widget.profileData!.email);
        setState(() {
          widget.profileData!.status = "approved";
        });
        if (widget.profileData!.editstatus == "unapprove") {
          SearchProfile().addtoadminnotification(
              userid: widget.profileData!.id!,
              useremail: widget.profileData!.email!,
              userimage: widget.profileData!.imageurls!.isEmpty
                  ? ""
                  : widget.profileData!.imageurls![0],
              title:
                  "${userSave.displayName} EDIT APPROVED PROFILE ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
              email: userSave.email!,
              subtitle: "");
        } else {
          SearchProfile().addtoadminnotification(
              userid: widget.profileData!.id!,
              useremail: widget.profileData!.email!,
              userimage: widget.profileData!.imageurls!.isEmpty
                  ? ""
                  : widget.profileData!.imageurls![0],
              title:
                  "${userSave.displayName} APPROVED PROFILE ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
              email: userSave.email!,
              subtitle: "");
        }

        HomeService().editapproveuser(widget.profileData!.email);
      }

      // else {
      //   final docUser = FirebaseFirestore.instance
      //       .collection('user_data')
      //       .doc(widget.profileData!.id);
      //   try {
      //     setState(() {
      //       widget.profileData!.status = "approved";
      //     });
      //     final json = widget.profileData!.toJson();
      //     await docUser
      //         .update(json)
      //         .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 duration: Duration(seconds: 1),
      //                 content: const SnackBarContent(
      //                   error_text: "Profile Approved",
      //                   appreciation: "",
      //                   icon: Icons.check,
      //                   sec: 2,
      //                 ),
      //                 margin: EdgeInsets.only(
      //                     bottom: MediaQuery.of(context).size.height * 0.25,
      //                     left: MediaQuery.of(context).size.width * 0.06),
      //                 behavior: SnackBarBehavior.floating,
      //                 backgroundColor: Colors.transparent,
      //                 elevation: 0,
      //               ),
      //             ))
      //         .catchError((error) => print(error));
      //   } catch (Excepetion) {
      //     print(Excepetion);
      //   }
      // }
    }
  }

  Future<void> unblock() async {
    if (listofadminpermissions!.contains("Can unblock profiles") ||
        listofadminpermissions!.contains("All")) {
      setState(() {
        widget.profileData!.status = "";
      });

      HomeService().unblock(email: widget.profileData!.email);
      SearchProfile().addtoadminnotification(
          userid: widget.profileData!.id!,
          useremail: widget.profileData!.email!,
          userimage: widget.profileData!.imageurls!.isEmpty
              ? ""
              : widget.profileData!.imageurls![0],
          title:
              "${userSave.displayName} UNBLOCKED ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
          email: userSave.email!,
          subtitle: "");
      // ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             duration: Duration(seconds: 1),
      //             content: const SnackBarContent(
      //               error_text: "Profile Unblocked",
      //               appreciation: "",
      //               icon: Icons.check,
      //               sec: 2,
      //             ),
      //             margin: EdgeInsets.only(
      //                 bottom: MediaQuery.of(context).size.height * 0.25,
      //                 left: MediaQuery.of(context).size.width * 0.06),
      //             behavior: SnackBarBehavior.floating,
      //             backgroundColor: Colors.transparent,
      //             elevation: 0,
      //           ),
      //         );
      // final docUser = FirebaseFirestore.instance
      //     .collection('user_data')
      //     .doc(widget.profileData!.uid);
      // try {
      //   setState(() {
      //     widget.profileData!.status = "";
      //   });
      //   final json = widget.profileData!.toJson();
      //   await docUser
      //       .update(json)
      //       .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(
      //               duration: Duration(seconds: 1),
      //               content: const SnackBarContent(
      //                 error_text: "Profile Unblocked",
      //                 appreciation: "",
      //                 icon: Icons.check,
      //                 sec: 2,
      //               ),
      //               margin: EdgeInsets.only(
      //                   bottom: MediaQuery.of(context).size.height * 0.25,
      //                   left: MediaQuery.of(context).size.width * 0.06),
      //               behavior: SnackBarBehavior.floating,
      //               backgroundColor: Colors.transparent,
      //               elevation: 0,
      //             ),
      //           ))
      //       .catchError((error) => print(error));
      // } catch (Excepetion) {
      //   print(Excepetion);
      // }
    }
  }

  Future<void> unreport() async {
    // final docUser = FirebaseFirestore.instance
    //     .collection('user_data')
    //     .doc(widget.profileData!.uid);
    // try {
    setState(() {
      widget.profileData!.status = "";
    });
    SearchProfile().addtoadminnotification(
        userid: widget.profileData!.id!,
        useremail: widget.profileData!.email!,
        userimage: widget.profileData!.imageurls!.isEmpty
            ? ""
            : widget.profileData!.imageurls![0],
        title:
            "${userSave.displayName} UNREPORTED ${widget.profileData!.name.substring(0, 1).toUpperCase()} ${widget.profileData!.surname..toLowerCase()} ${widget.profileData!.puid}",
        email: userSave.email!,
        subtitle: "");
         showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SnackBarContent(
              error_text: "Profile Unreport Successfully",
              appreciation: "",
              icon: Icons.check_circle,
              sec: 2,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        });
    // ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             duration: Duration(seconds: 1),
    //             content: const SnackBarContent(
    //               error_text: "Profile Unreported",
    //               appreciation: "",
    //               icon: Icons.check,
    //               sec: 2,
    //             ),
    //             margin: EdgeInsets.only(
    //                 bottom: MediaQuery.of(context).size.height * 0.25,
    //                 left: MediaQuery.of(context).size.width * 0.06),
    //             behavior: SnackBarBehavior.floating,
    //             backgroundColor: Colors.transparent,
    //             elevation: 0,
    //           ),
    //         );
    //   final json = widget.profileData!.toJson();
    //   await docUser
    //       .update(json)
    //       .then((value) => ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               duration: Duration(seconds: 1),
    //               content: const SnackBarContent(
    //                 error_text: "Profile Unreported",
    //                 appreciation: "",
    //                 icon: Icons.check,
    //                 sec: 2,
    //               ),
    //               margin: EdgeInsets.only(
    //                   bottom: MediaQuery.of(context).size.height * 0.25,
    //                   left: MediaQuery.of(context).size.width * 0.06),
    //               behavior: SnackBarBehavior.floating,
    //               backgroundColor: Colors.transparent,
    //               elevation: 0,
    //             ),
    //           ))
    //       .catchError((error) => print(error));
    // } catch (Excepetion) {
    //   print(Excepetion);
    // }
  }

  Future<void> unshortList() async {
    shortFriend!.remove(widget.profileData!.id);
    HomeService()
        .unshortlistuser(
            email: userSave!.email!, profileid: widget.profileData!.id)
        .whenComplete(() {
      HomeService().getuserdata();
    });
    setState(() {});
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 1),
    //   content: SnackBarContent(
    //     error_text: "Remove Shortlisted Successfully",
    //     appreciation: "",
    //     icon: Icons.check,
    //     sec: 2,
    //   ),
    //   margin: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).size.height * 0.25,
    //       left: MediaQuery.of(context).size.width * 0.06),
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    // ));

    // ShortL friend = ShortL(
    //     date: DateTime.now().toString(),
    //     fromUid: userSave!.uid,
    //     toUid: widget.profileData!.uid);
    // final docUser = await FirebaseFirestore.instance
    //     .collection('short_list')
    //     .doc(uid)
    //     .get();
    // sl!.users!.removeAt(sl!.users!.indexWhere(
    //     (oldvalue) => oldvalue["toUid"] == (widget.profileData!.uid)));
    // // (oldvalue) => oldvalue.toUid == (widget.profileData!.uid)));
    // var json = sl!.toJson();
    // FirebaseFirestore.instance
    //     .collection("short_list")
    //     .doc("$uid")
    //     .update(json)
    //     .then((value) {
    //   print("object");
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     duration: Duration(seconds: 1),
    //     content: SnackBarContent(
    //       error_text: "Remove Shortlisted Successfully",
    //       appreciation: "",
    //       icon: Icons.check,
    //       sec: 2,
    //     ),
    //     margin: EdgeInsets.only(
    //         bottom: MediaQuery.of(context).size.height * 0.25,
    //         left: MediaQuery.of(context).size.width * 0.06),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //   ));
    // });

    // sl!.users!.add(friend.toJson());
    // await sharedPref.save("shortlist", sl);
    // setState(() {
    //   shortFriend!.remove("${friend.toUid}");
    // });
  }
}
