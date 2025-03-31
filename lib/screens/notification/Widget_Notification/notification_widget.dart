import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/activity_model.dart';
import 'package:matrimony_admin/models/admin_notification_model.dart';
import 'package:matrimony_admin/screens/profie_types/delete_profiles.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';

import '../../../Assets/Error.dart';
import '../../../Chat/screens/mobile_chat_screen.dart';
import '../../../globalVars.dart';
import '../../../models/new_user_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/user_model.dart';
import '../../../sendUtils/notiModel.dart';
import '../../navigation/howToUse.dart';
import '../../profile/ProfilePage.dart';
import '../../profile/profileScroll.dart';
import '../../service/search_profile.dart';

class NotificationWidget1 extends StatefulWidget {
  const NotificationWidget1({super.key});

  @override
  State<NotificationWidget1> createState() => _NotificationWidget1State();
}

class _NotificationWidget1State extends State<NotificationWidget1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          // print("hello");
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Great1()));
        },
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: 80,
            width: 350,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 37,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/65/200/300'),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                    Text.rich(TextSpan(
                        //style: TextStyle(color: Colors.redAccent), //apply style to all
                        children: [
                          TextSpan(
                              text: 'A Sharma CMF10451',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(text: ' Viewed your profile.')
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    Text("🕙 22 Nov 2021   14:36")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationWidget2 extends StatefulWidget {
  NotificationWidget2(
      {super.key,
      // required this.name,
      // required this.action,
      required this.notiData});
  // final name;
  // final action;
  AdminNotificationModel notiData;

  @override
  State<NotificationWidget2> createState() => _NotificationWidget2State();
}

class _NotificationWidget2State extends State<NotificationWidget2> {
  var time;
    late DatabaseReference _dbref;
  late DatabaseReference _dbref5;
  SavedPref defaultSp = SavedPref();

  var connectivity = '';
   setconnection() {
    _dbref = _dbref.child("onlineStatus");
    _dbref5 = _dbref5.child("token");
    _dbref.child(widget.notiData.userid).onValue.listen((event) {
      try {
        var res = event.snapshot.child('status').value;
        setState(() {
          connectivity = res.toString();
        });
      } catch (e) {
        print(e);
      }
    });
   
  }
  Future<void> _loadFormattedDateTime() async {
    DateTime timestamp = DateTime.parse(widget.notiData.createdAt);
    // String timeZone = await FlutterNativeTimezone.getLocalTimezone();

    // Convert the timestamp to the user's timezone
    DateTime userDateTime = timestamp.toLocal();

    // Format the DateTime using the intl package with the specified timezone
    time = DateFormat("yyyy-MM-dd HH:mm").format(
      userDateTime,
    );
    print(time);
    setState(() {});
  }

  var imgurl =
      "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2";
  @override
  void initState() {
    _loadFormattedDateTime();

    super.initState();
    // TZDateTime timestampInNewYork =
    //     TZDateTime.from(timestamp, getLocation("Asia/Kolkata"));

    // Format the DateTime as a real-time string
    // time = DateFormat("yyyy-MM-dd HH:mm").format(timestampInNewYork);
    // setState(() {
    //   // time = DateTime.fromMillisecondsSinceEpoch(widget.notiData.createdAt);
    // });

    setImgUrl();
  }

  NewUserModel? newUserModel;

  setImgUrl() async {
    newUserModel = await HomeService().getuserdatabyid(widget.notiData.userid);
    if (widget.notiData.userimage == null || widget.notiData.userimage == "") {
    } else {
      imgurl = widget.notiData.userimage;
      setState(() {});
    }
    // if (widget.notiData.userid != userSave.uid) {
    //   User? profile = User.fromdoc(await FirebaseFirestore.instance
    //       .collection("user_data")
    //       .doc(widget.notiData.userid)
    //       .get());
    //   if (profile.imageUrls != null && profile.imageUrls!.isNotEmpty) {
    //     setState(() {
    //       imgurl = profile.imageUrls![0];
    //     });
    //   }
    // }
  }

  pushChatPage(
    var roomid,
    var profiledata,
    var profilepic,
  ) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //       builder: (maincontext) => Scaffold(
    //             body: MobileChatScreen(
    //                 roomid: roomid,
    //                 profileDetail: profiledata
    //                 profilepic: profilepic),
    //           )),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 10, left: 5),
      child: GestureDetector(
        onTap: () async {
          
          SearchProfile().addtoadminnotification(
              userid: "2345",
              useremail: "lksjflajk",
              userimage: "",
              title:
                  "${userSave.displayName} SEEN ${widget.notiData.title} IN ACTIVITIES",
              email: userSave.email!,
              subtitle: "");
          print(widget.notiData.title.contains("CRITERIA"));
          if (widget.notiData.title.contains("CRITERIA")) {
          } else if (widget.notiData.title.contains("DELETE PROFILE") ||
              widget.notiData.title.contains("DELETED")) {
            NewUserModel usermodel = await HomeService()
                .getdeleteuserdatabyid(widget.notiData.userid);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeleteProfile(
                          searchText: "Delete",
                          user_list: [usermodel],
                        )));
            // Navigator.push(
            // context,
            // MaterialPageRoute(
            //     builder: (context) => SlideProfile(

            //          user_data: [usermodel],
            //          user_list: [usermodel],
            //           // pushchat: pushChatPage,
            //           type: "other",
            //         )));
          } else {
            List<NewUserModel> allusers = [];
            allusers.add(newUserModel!);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SlideProfile(
                          user_data: allusers,
                          user_list: allusers,
                          // pushchat: pushChatPage,
                          type: "other",
                        )));
          }

          //   if (!res.exists && userSave1.docs.isNotEmpty) {
          //     // ignore: use_build_context_synchronously
          //     // Navigator.of(context).push(MaterialPageRoute(
          //     //     builder: (context) => MainAppContainer(
          //     //           notiPage: true,
          //     //           user_data: userSave1,
          //     //         )));
          //   } else if (widget.notiData.type == "knowHow") {
          //     // ignore: use_build_context_synchronously
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const Use()));
          //   } else {
          //     // ignore: use_build_context_synchronously
          //     showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (context) {
          //           return const AlertDialog(
          //             content: SnackBarContent(
          //               error_text: "User doesn't exist",
          //               appreciation: "",
          //               icon: Icons.error,
          //               sec: 2,
          //             ),
          //             backgroundColor: Colors.transparent,
          //             elevation: 0,
          //           );
          //         });
          //   }
          // }
        },
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: 80,
            width: 350,
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.network(
                        imgurl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        width: 42,
                        height: 42,
                      ),
                    ),
                     Positioned(
                      bottom: 0,
                      right: 0,
                       child: ClipOval(
                                                  child: Container(
                                                    // padding: EdgeInsets.all(30),
                                                    width: 9,
                                                    height: 9,
                                                    decoration: BoxDecoration(
                                                        color: (connectivity ==
                                                                "Online")
                                                            ? const Color(
                                                                0xFF00FF19)
                                                            : (connectivity ==
                                                                    "Resumed")
                                                                ? const Color
                                                                    .fromARGB(255,
                                                                    255, 208, 0)
                                                                : const Color(
                                                                    0xFFBDBDBD)
                                                        // color: Color(0xFF33D374)),
                                                        // color: if(userSave.connectivity == "Online"){Color(0xFF00FF19)}else if(userSave.connectivity == "Offline"){Color(0xFFBDBDBD)} else{Color(0xFFDBFF00)}
                                                        ),
                                                  ),
                                                ),
                     ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width:
                          (userSave.uid == widget.notiData.userid) ? 350 : 300,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: widget.notiData.title.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Sans-serif',
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "🕙 ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(widget.notiData.createdAt).toLocal())}",
                        style: const TextStyle(
                            fontSize: 8,
                            fontFamily: 'Sans-serif',
                            fontWeight: FontWeight.w400))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationWidget3 extends StatefulWidget {
  NotificationWidget3(
      {super.key,
      // required this.name,
      // required this.action,
      required this.notiData});
  // final name;
  // final action;
  ActivitiesModel notiData;

  @override
  State<NotificationWidget3> createState() => _NotificationWidget3State();
}

class _NotificationWidget3State extends State<NotificationWidget3> {
  var time;
  Future<void> _loadFormattedDateTime() async {
    DateTime timestamp = DateTime.parse(widget.notiData.createdAt);
    // String timeZone = await FlutterNativeTimezone.getLocalTimezone();

    // Convert the timestamp to the user's timezone
    DateTime userDateTime = timestamp.toLocal();

    // Format the DateTime using the intl package with the specified timezone
    time = DateFormat("yyyy-MM-dd HH:mm").format(
      userDateTime,
    );
    print(time);
    setState(() {});
  }

  var imgurl =
      "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2";
  @override
  void initState() {
    _loadFormattedDateTime();

    super.initState();
    // TZDateTime timestampInNewYork =
    //     TZDateTime.from(timestamp, getLocation("Asia/Kolkata"));

    // Format the DateTime as a real-time string
    // time = DateFormat("yyyy-MM-dd HH:mm").format(timestampInNewYork);
    // setState(() {
    //   // time = DateTime.fromMillisecondsSinceEpoch(widget.notiData.createdAt);
    // });

    setImgUrl();
  }

  NewUserModel? newUserModel;

  setImgUrl() async {
    newUserModel = await HomeService().getuserdatabyid(widget.notiData.userid);
    if (widget.notiData.userimage == null || widget.notiData.userimage == "") {
    } else {
      imgurl = widget.notiData.userimage;
      setState(() {});
    }
    // if (widget.notiData.userid != userSave.uid) {
    //   User? profile = User.fromdoc(await FirebaseFirestore.instance
    //       .collection("user_data")
    //       .doc(widget.notiData.userid)
    //       .get());
    //   if (profile.imageUrls != null && profile.imageUrls!.isNotEmpty) {
    //     setState(() {
    //       imgurl = profile.imageUrls![0];
    //     });
    //   }
    // }
  }

  pushChatPage(
    var roomid,
    var profiledata,
    var profilepic,
  ) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //       builder: (maincontext) => Scaffold(
    //             body: MobileChatScreen(
    //                 roomid: roomid,
    //                 profileDetail: profiledata
    //                 profilepic: profilepic),
    //           )),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 10, left: 5),
      child: GestureDetector(
        onTap: () async {
          // if (widget.notiData.uid != userSave.uid) {
          //   var userSave1 = await FirebaseFirestore.instance
          //       .collection("user_data")
          //       .where('uid', isEqualTo: widget.notiData.uid)
          //       .get();
          //   print('noti click check agin');
          //   var doc = FirebaseDatabase.instance.ref().child('block_list');
          //   doc = doc.child(widget.notiData.uid);
          //   var res = await doc.child(userSave.uid!).get();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        userSave: newUserModel,
                        // pushchat: pushChatPage,
                        type: "other",
                      )));
          //   if (!res.exists && userSave1.docs.isNotEmpty) {
          //     // ignore: use_build_context_synchronously
          //     // Navigator.of(context).push(MaterialPageRoute(
          //     //     builder: (context) => MainAppContainer(
          //     //           notiPage: true,
          //     //           user_data: userSave1,
          //     //         )));
          //   } else if (widget.notiData.type == "knowHow") {
          //     // ignore: use_build_context_synchronously
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const Use()));
          //   } else {
          //     // ignore: use_build_context_synchronously
          //     showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (context) {
          //           return const AlertDialog(
          //             content: SnackBarContent(
          //               error_text: "User doesn't exist",
          //               appreciation: "",
          //               icon: Icons.error,
          //               sec: 2,
          //             ),
          //             backgroundColor: Colors.transparent,
          //             elevation: 0,
          //           );
          //         });
          //   }
          // }
        },
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: 80,
            width: 350,
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    imgurl,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                    width: 42,
                    height: 42,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 290,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Text(widget.notiData.title.trim(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Sans-serif',
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "🕙 ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(widget.notiData.createdAt).toLocal())}",
                        style: const TextStyle(
                            fontSize: 8,
                            fontFamily: 'Sans-serif',
                            fontWeight: FontWeight.w400))
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: widget.notiData.delete == false
                                ? main_color
                                : Colors.red,
                            width: 5)),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
