import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/models/history_save_pref.dart';
import 'package:matrimony_admin/models/new_save_pref.dart';
import 'package:matrimony_admin/models/user_model.dart' as usr;
import 'package:matrimony_admin/models/user_search.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';
import 'package:matrimony_admin/screens/matchprofile/match_scroll.dart';
import 'package:matrimony_admin/screens/matchprofile/new_match_profile.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip.dart';
import 'package:matrimony_admin/screens/navigation/freematch.dart';
import 'package:matrimony_admin/screens/navigation/support.dart';
import 'package:matrimony_admin/screens/profile/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import 'package:share_plus/share_plus.dart';
import '../../Assets/Error.dart';
import '../../Assets/ImageDart/images.dart';
import '../../Assets/ayushWidget/big_text.dart';
import '../../Assets/defaultAlgo/profileComplete.dart';
import '../../Chat/main.dart';
import '../../common/widgets/logotext.dart';
import '../../globalVars.dart';
import '../../main.dart';
import '../../models/chat_model.dart';
import '../../models/kundli_model_history.dart';
import '../../models/new_user_model.dart';
import '../../models/shared_pref.dart';
import '../../sendUtils/notiFunction.dart';
import '../data_collection/congo.dart';
import '../delete confirmation/delete_confirmation.dart';
import '../profile/edit_profile.dart';
import '../profile/profileScroll.dart';
import '../profile2/pVerify.dart';
import '../search_preferences/saved_preferences.dart';
import '../search.dart';
import 'FreePersonalizeMatchmaking/free_personalize_match.dart';
import 'admin_options/boost.dart';
import 'admin_options/invisible.dart';
import 'admin_options/sendLink.dart';
import 'admin_options/sendNotification.dart';
import 'admin_options/sharePr.dart';
import 'admin_options/showAd.dart';
import 'admin_options/user_search/usersearch.dart';
import 'biodata.dart';
import 'kundli_match.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  final int profilecomp;
  MyProfile(
      {super.key,
      required this.userSave,
      required this.profilecomp,
      this.isDelete});
  NewUserModel userSave;
  bool? isDelete;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Color newColor = main_color;
  // usr.User ruserSave = usr.User();
  String uid = "";
  var type;
  var numonline = 0;
  bool isReviewclicked = false;
  ProfileCompletion profile = ProfileCompletion();
  // var profilePercentage = 50;
  late DatabaseReference _dbref;
  var res = [];
  bool color_done2 = false;
  List<UserSearchModel> searchhistory = [];
  List<HistorySavePref> history_save_pref = [];
  List<KundliMatchHistoryModel> kundalidoshhistory = [];
  void sendPushMessage(
      String body, String title, String userid, String route, String token,
      {String userName = "", String sound = "navnot"}) async {
    try {
      print(token);
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
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'uid': userid,
              'route': route,
              'id': widget.userSave.id,
              'userName': userName,
              'status': 'done',
              'sound': sound
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
  // Future<int> profileComplete() async {
  //   NewSavePrefModel? newSavePrefModel =
  //       await HomeService().getusersaveprefdata1(widget.userSave.email);

  //   if (widget.userSave.About_Me != null || widget.userSave.About_Me != "") {
  //     profilePercentage += 5;
  //   }
  //   if (widget.userSave.Partner_Prefs != null ||
  //       widget.userSave.Partner_Prefs != "") {
  //     profilePercentage += 5;
  //   }
  //   if (widget.userSave.imageurls != null &&
  //       widget.userSave.imageurls!.isNotEmpty) {
  //     profilePercentage += 10;
  //   }
  //   if (widget.userSave.status == "approved") {
  //     profilePercentage += 10;
  //   }
  //   if (newSavePrefModel != null) {
  //     profilePercentage += 5;
  //   }
  //   if (widget.userSave.verifiedstatus == "verified") {
  //     profilePercentage += 12;
  //   }
  //   setState(() {});
  //   return profilePercentage;
  // }

  void getallsearchhistory() async {
    searchhistory = await AdminService().getsearchuser(id: widget.userSave.id);

    kundalidoshhistory =
        await AdminService().getkundlimatch(id: widget.userSave.id);
    history_save_pref =
        await AdminService().getsavepref(id: widget.userSave.id);
    setState(() {});
  }

  var supprotdata;
  void getallsupprot() async {
    supprotdata = await SearchProfile().getsupports(widget!.userSave.id);
    setState(() {});
  }

  var reviewdata;
  int _rating = 0;
  void getreviewdata() async {
    reviewdata = await AdminService().getreview(email: widget!.userSave.id);
    if (reviewdata != null && reviewdata.isNotEmpty) {
      _rating = reviewdata[0]["ratingnumber"];
    }

    setState(() {});
  }

  Widget buildStar(int starRating) {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.star,
        size: 40,
        color: _rating >= starRating ? main_color : Colors.grey,
      ),
    );
  }

  @override
  initState() {
    super.initState();
    getallsupprot();
    // _dbref = FirebaseDatabase.instance.ref();
    getallsearchhistory();
    getreviewdata();
    // setData();
    // profileComplete();
    setState(() {});
  }

  setData() async {
    SharedPref sharedPref = SharedPref();

    // final json2 = await sharedPref.read("uid");
    var json3;
    try {
      json3 = await sharedPref.read("user");
    } catch (e) {
      print(e);
    }
    // print(json3.toString());
    // setState(() {
    //   userSave = widget.userSave ?? usr.User.fromJson(json3);
    //   // uid = json2['uid'];
    //   // print("uid : ${uid}");
    // });
    // var online = await FirebaseFirestore.instance
    //     .collection("user_data")
    //     .where("connectivity", isEqualTo: "Online")
    //     .get();
    _dbref = _dbref.child("onlineStatus");
    _dbref.orderByChild('status').equalTo('Online').onValue.listen((event) {
      try {
        var values = event.snapshot.value as Map<dynamic, dynamic>;
        res.clear();
        values.forEach((key, value) {
          setState(() {
            res.add(value['uid'].toString());
          });
        });
        // connectivity = values[0]['status'];
        // List<Map<dynamic, dynamic>> updatedList = [];
        // connectivity = snapshot.ValueKey('status');
        // print(res.toString());
      } catch (e) {
        print(e);
      }
    });

    setState(() {
      // numonline = online.docs.length;
    });
  }

  deleteAccount() {
    if (widget.isDelete == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeleteConfirm(
                    userSave: widget.userSave,
                    delete: widget.isDelete == false ? "false" : "true",
                    newusermode: widget.userSave,
                  )));
    }
  }

  List<NewUserModel> allonlineusers = [];

  void getuseronlineusers() async {
    var gen;
    if (userSave.gender == "male") {
      gen = "female";
    } else {
      gen = "male";
    }
    List<NewUserModel> allusers = await HomeService().getalluserdata(
        gender: gen,
        email: userSave.email!,
        religion: "",
        page: 1,
        ages: [],
        religionList: [],
        kundaliDoshList: [],
        citylocation: [],
        statelocation: [],
        maritalStatusList: [],
        dietList: [],
        drinkList: [],
        smokeList: [],
        disabilityList: [],
        heightList: [],
        educationList: [],
        professionList: [],
        incomeList: [],
        location: []);
    print(allusers);
    allonlineusers =
        allusers.where((element) => res.contains(element.id)).toList();
    setState(() {});
  }

  onlineUser() async {
    try {
      // print("onpressed clicked");

      if (allonlineusers.isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (builder) => SlideProfile(user_data: allonlineusers)));
      } else {
        Future(() => customAlertBox1(context, Icons.error,
            "No Online Profile \n According \n Your Preference", "", () {}));
        // await showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         content: SnackBarContent3(
        //             error_text: "No Online Profile",
        //             appreciation: "",
        //             icon: Icons.error),
        //         backgroundColor: Colors.transparent,
        //         elevation: 0,
        //       );
        //     });
      }
    } catch (e) {
      print(e);
    }
  }

  bool isEmailInUserList(String email, List<ChatsModel> userList) {
    for (var user in userList) {
      if (user.email == email) {
        return true; // Email found in the list
      }
    }
    return false; // Email not found in the list
  }

  var userprofile;
  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: "ABCDEFGHIJK",
        style: TextStyle(fontSize: 14),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    final textWidth = textPainter.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: supprotdata == null
            ? SizedBox(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: main_color,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 15),
                    padding: const EdgeInsets.only(left: 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: IconButton(
                                      padding: EdgeInsets.only(left: 5),
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: main_color,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: (widget.userSave.imageurls ==
                                                  null ||
                                              widget.userSave.imageurls.isEmpty)
                                          ? Border.all(
                                              width: 1,
                                              color: main_color,
                                            )
                                          : Border.all(
                                              width: 2,
                                              color: Colors.white,
                                            ),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: (widget.userSave.imageurls ==
                                                    null ||
                                                widget.userSave.imageurls!
                                                    .isEmpty)
                                            ? const NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2FnavImageError.png?alt=media&token=49f90276-0a97-4f1f-910f-28e95f1ac29c",
                                              )
                                            // "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/Images%2F70.png?alt=media&token=05816459-b75e-44ee-8ca6-a6b9b4d9cbf8")
                                            : NetworkImage(
                                                widget.userSave.imageurls[0],
                                              ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  left: 5,
                                                ),

                                                // width: textWidth,
                                                child: SizedBox(
                                                  width: Get.width * 0.33,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: BigText(
                                                      text: (widget.userSave
                                                                  .name ==
                                                              null)
                                                          ? "Ghanshyam Ramayiyavasta"
                                                          : "${widget.userSave.name![0].toUpperCase() + widget.userSave.name!.substring(1)} ${widget.userSave.surname![0].toUpperCase() + widget.userSave.surname!.substring(1)}",
                                                      size: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Clipboard.setData(
                                                          ClipboardData(
                                                              text: widget
                                                                      .userSave
                                                                      .puid ??
                                                                  ""))
                                                      .then((value) {
                                                    //only if ->
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Copied successfully")));
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: BigText(
                                                    // text: uid.toString().substring(uid.length()-5),
                                                    text: (widget.userSave
                                                                .puid !=
                                                            null)
                                                        ? widget.userSave.puid!
                                                        : "",
                                                    color: main_color,
                                                    size: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              (widget.userSave.verifiedstatus ==
                                                          "verified" &&
                                                      widget.userSave.imageurls!
                                                          .isNotEmpty)
                                                  ? Icon(
                                                      Icons.verified_user,
                                                      color: main_color,
                                                      size: 25,
                                                    )
                                                  : const Text(""),
                                              const SizedBox(height: 4),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2.0, color: main_color),
                                    backgroundColor: Colors.white,
                                    minimumSize: const Size(40, 35),
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                  child: BigText(
                                    text: "Edit Profile",
                                    size: 15,
                                    color: main_color,
                                  ),
                                  onPressed: () async {
                                    if (listofadminpermissions!
                                            .contains("Can Edit menu") ||
                                        listofadminpermissions!
                                            .contains("Can See Full Name") ||
                                        listofadminpermissions!
                                            .contains("Can See Email") ||
                                        listofadminpermissions!
                                            .contains("Can See Phone") ||
                                        listofadminpermissions!
                                            .contains("All")) {
                                      SearchProfile().addtoadminnotification(
                                          userid: widget.userSave!.id!,
                                          useremail: widget.userSave!.email!,
                                          userimage: widget
                                                  .userSave!.imageurls!.isEmpty
                                              ? ""
                                              : widget.userSave!.imageurls![0],
                                          title:
                                              "${userSave.displayName} CLICK ON EDIT PROFILE  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} LEFT MENU",
                                          email: userSave.email!,
                                          subtitle: "");
                                      final data = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditProfile(
                                                    userSave: widget.userSave,
                                                  )));
                                      //                                if (data != null ) {
                                      setState(() {
                                        userprofile = data;
                                      });
                                      // }
                                      print(data);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18, top: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 8,
                              width: MediaQuery.of(context).size.width * 0.82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: main_color),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 8,
                                      width: MediaQuery.of(context).size.width *
                                          0.82 *
                                          widget.profilecomp /
                                          100,
                                      decoration: BoxDecoration(
                                        color: main_color,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Profile Completion ${widget.profilecomp}%"),
                        const Divider(color: Colors.grey, thickness: 1),
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsetsDirectional.only(
                      end: MediaQuery.of(context).size.width * 0.1,
                    ),

                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(userSave.token);
                                // sendPushMessage("Hello", "HI", "12", "/",widget. userSave.token!);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (builder) => SlideProfile()),
                                    (route) => false);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/home.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (listofadminpermissions!
                                        .contains("Can Search Profile") ||
                                    listofadminpermissions!.contains("All")) {
                                  if (searchhistory.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserSearch(
                                                  userSave: widget.userSave,
                                                  searchs: searchhistory,
                                                )));
                                    SearchProfile().addtoadminnotification(
                                        userid: widget.userSave!.id!,
                                        useremail: widget.userSave!.email!,
                                        userimage: widget
                                                .userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                        title:
                                            "${userSave.displayName} SEEN  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} SEARCH HISTORY",
                                        email: userSave.email!,
                                        subtitle: "");
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/search.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Search Profile",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  searchhistory.isEmpty ||
                                          searchhistory
                                              .where((element) =>
                                                  element.name ==
                                                  widget.userSave.name)
                                              .isEmpty
                                      ? Text(
                                          "Not Use",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Use (${searchhistory.where((element) => element.name == widget.userSave.name).isEmpty ? "" : searchhistory.where((element) => element.name == widget.userSave.name).length})",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (listofadminpermissions!
                                        .contains("Can Saved Preference") ||
                                    listofadminpermissions!.contains("All")) {
                                  HistorySavePref historysave = HistorySavePref(
                                      createdAt: DateTime.now().toString(),
                                      ageList: [1],
                                      location: [],
                                      citylocation: [],
                                      name: '',
                                      religionList: [],
                                      kundaliDoshList: [],
                                      drinkList: [],
                                      maritalStatusList: [],
                                      dietList: [],
                                      smokeList: [],
                                      disabilityList: [],
                                      heightList: [],
                                      educationList: [],
                                      professionList: [],
                                      incomeList: [],
                                      statelocation: []);

                                  history_save_pref.sort((a, b) =>
                                      b.createdAt.compareTo(a.createdAt));
                                  List<HistorySavePref> newhistorysef = [
                                    historysave,
                                    ...history_save_pref
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchPreferences(
                                                history_save_pref:
                                                    newhistorysef,
                                                newUserModel: widget.userSave,
                                              )));
                                  SearchProfile().addtoadminnotification(
                                      userid: widget.userSave!.id!,
                                      useremail: widget.userSave!.email!,
                                      userimage:
                                          widget.userSave!.imageurls!.isEmpty
                                              ? ""
                                              : widget.userSave!.imageurls![0],
                                      title:
                                          "${userSave.displayName} SEEN ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} SAVE PREFERENCE HISTORY",
                                      email: userSave.email!,
                                      subtitle: "");
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/filter.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Saved Preference",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  history_save_pref.isEmpty
                                      ? Text("Not Saved",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold))
                                      : Row(
                                          children: [
                                            Text(
                                              "Use (${history_save_pref.length})",
                                              style: TextStyle(
                                                  color: main_color,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Saved",
                                              style: TextStyle(
                                                  color: main_color,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // onlineUser();
                                SearchProfile().addtoadminnotification(
                                    userid: widget.userSave!.id!,
                                    useremail: widget.userSave!.email!,
                                    userimage:
                                        widget.userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                    title:
                                        "${userSave.displayName} SEEN ONLINE USERS BY ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} LEFT MENU ",
                                    email: userSave.email!,
                                    subtitle: "");
                                // NotificationFunction.setNotification(
                                //   "admin",
                                //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave.uid!.length - 5)} SEEN ONLINE PROFILES",
                                //   'onlineuser',
                                // );
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/user_dot_green.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Online",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  // ClipOval(
                                  //   child: Container(
                                  //     width: 9,
                                  //     height: 9,
                                  //     decoration: const BoxDecoration(
                                  //         color: Color(0xFF33D374)),
                                  //   ),
                                  // ),

                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.onlineuser == false
                                      ? Text("")
                                      : Text(
                                          "Use (${widget.userSave.onlinenumbers})",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (listofadminpermissions!
                                        .contains("Can Profile Verified") ||
                                    listofadminpermissions!.contains("All")) {
                                  print(widget.userSave.videolink);
                                  if (widget.userSave.videolink.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Verify(
                                                  userSave: widget.userSave,
                                                )));
                                    SearchProfile().addtoadminnotification(
                                        userid: widget.userSave.id,
                                        useremail: widget.userSave.email,
                                        userimage:
                                            widget.userSave.imageurls.isEmpty
                                                ? ""
                                                : widget.userSave.imageurls![0],
                                        title:
                                            "${userSave.displayName} TRIED TO SEEN UPLOADED VIDEO BY ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} (PHOTO NOT UPLOADED)",
                                        email: userSave.email!,
                                        subtitle: "");
                                  } else {
                                  log("ok");
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: SnackBarContent(
                                            error_text: "Video Not Uploaded",
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
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/verified.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Profile Verification",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.verifiedstatus == "verified"
                                      ? Text(
                                          "Verified",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : widget.userSave.videolink != ""
                                          ? Text("Pending",
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold))
                                          : Text(""),
                                  widget.userSave.profileverified == 0
                                      ? Text(
                                          "Not uploaded",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : widget.userSave.profileverified == null
                                          ? Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "(${widget.userSave.profileverified})",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FreeMatchmakingScreen(
                                              profileDetail: widget.userSave,
                                            )));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/shake_heart.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Free Personalized Matchmaking",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.freepersonmatch == 0
                                      ? Text("")
                                      : Text(
                                          "Use ${widget.userSave.freepersonmatch}",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (listofadminpermissions!
                                        .contains("Can See Chat") ||
                                    listofadminpermissions!.contains("All")) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) => ChatPageHome(
                                            newusermodel: widget.userSave,
                                          )));
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/chat.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Chat Now",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.chats!.length == 0
                                      ? Text("")
                                      : Text(
                                          "Use",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (userSave.religion == "Hindu")
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (listofadminpermissions!.contains(
                                                  "Can See Free Kundli Match") ||
                                              listofadminpermissions!
                                                  .contains("All")) {
                                            KundliMatchHistoryModel newmodel =
                                                KundliMatchHistoryModel(
                                              gname: "",
                                              gday: "",
                                              gmonth: "",
                                              gyear: "",
                                              ghour: "",
                                              gsec: "",
                                              bname: "",
                                              bday: "",
                                              bam: "",
                                              gam: "",
                                              bkundli: "",
                                              gkundli: "",
                                              bmonth: "",
                                              byear: "",
                                              bhour: "",
                                              bsec: "",
                                              name: "",
                                              totalgun: "",
                                              createdAt:
                                                  DateTime.now().toString(),
                                              bplace: "",
                                              userid: "12345",
                                              gplace: "",
                                            );
                                            kundalidoshhistory.sort((a, b) => b
                                                .createdAt
                                                .compareTo(a.createdAt));
                                            List<KundliMatchHistoryModel>
                                                newkundali = [
                                              newmodel,
                                              ...kundalidoshhistory
                                            ];
                                            SearchProfile().addtoadminnotification(
                                                userid: widget.userSave!.id!,
                                                useremail:
                                                    widget.userSave!.email!,
                                                userimage: widget.userSave!
                                                        .imageurls!.isEmpty
                                                    ? ""
                                                    : widget.userSave!
                                                        .imageurls![0],
                                                title:
                                                    "${userSave.displayName} CLICK ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} FREE KUNDLI MATCH  LEFT MENU ",
                                                email: userSave.email!,
                                                subtitle: "");
                                            SearchProfile().addtoadminnotification(
                                                userid: widget.userSave!.id!,
                                                useremail:
                                                    widget.userSave!.email!,
                                                userimage: widget.userSave!
                                                        .imageurls!.isEmpty
                                                    ? ""
                                                    : widget.userSave!
                                                        .imageurls![0],
                                                title:
                                                    "${userSave.displayName} SEEN ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} KUNDLI MATCH HISTORY  ",
                                                email: userSave.email!,
                                                subtitle: "");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KundliMatch(
                                                          newusermode:
                                                              widget.userSave,
                                                          allkundali:
                                                              newkundali,
                                                        )));
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              child: Image.asset(
                                                'images/icons/kundli.png',
                                                width: 23,
                                                height: 23,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Free Kundli Match",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            kundalidoshhistory.isEmpty ||
                                                    kundalidoshhistory
                                                        .where((element) =>
                                                            element.name ==
                                                            widget
                                                                .userSave.name)
                                                        .isEmpty
                                                ? Text("")
                                                : Text(
                                                    "Use (${kundalidoshhistory.where((element) => element.name == widget.userSave.name).isEmpty ? "" : kundalidoshhistory.where((element) => element.name == widget.userSave.name).length})",
                                                    style: TextStyle(
                                                        color: main_color,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (listofadminpermissions!.contains(
                                        "Can Download Matrimonial Biodata") ||
                                    listofadminpermissions!.contains("All")) {
                                  if (widget.userSave.imageurls.isEmpty) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              child: SnackBarContent(
                                                error_text:
                                                    "Profile Verification Required\nTo\nDownload Matrimonial BioData",
                                                appreciation: "",
                                                icon: Icons.error,
                                                sec: 3,
                                              ),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          );
                                        });
                                    SearchProfile().addtoadminnotification(
                                        userid: widget.userSave!.id!,
                                        useremail: widget.userSave!.email!,
                                        userimage: widget
                                                .userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                        title:
                                            "${userSave.displayName} TRIED TO SEE ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} MATRIMONIAL BIODATA (ERROR)",
                                        email: userSave.email!,
                                        subtitle: "");
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BioData(
                                                  newUserModel: widget.userSave,
                                                )));
                                    SearchProfile().addtoadminnotification(
                                        userid: widget.userSave!.id!,
                                        useremail: widget.userSave!.email!,
                                        userimage: widget
                                                .userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                        title:
                                            "${userSave.displayName} CLICKS DOWNLOAD MATRIMONIAL BIODATA BY ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} LEFT MENU",
                                        email: userSave.email!,
                                        subtitle: "");
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/download.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Download Matrimonial Biodata",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Column(
                                    children: [
                                      widget.userSave.downloadbiodata == false
                                          ? Text("")
                                          : Text(
                                              "Download",
                                              style: TextStyle(
                                                  color: main_color,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      widget.userSave.support == 0
                                          ? Text("")
                                          : Text(
                                              "Share",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  ),
                                  widget.userSave.numberdownloadbiodata == 0
                                      ? Text("")
                                      : Text(
                                          "Use(${widget.userSave.numberdownloadbiodata})",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                SearchProfile().addtoadminnotification(
                                    userid: widget.userSave!.id!,
                                    useremail: widget.userSave!.email!,
                                    userimage:
                                        widget.userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                    title:
                                        "${userSave.displayName} CLICK ON MARRIAGE LOAN",
                                    email: userSave.email!,
                                    subtitle: "");
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/income.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Marriage Loan (0% Interest)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.marriageloan == 0
                                      ? Text("")
                                      : Text(
                                          "Use (${widget.userSave.marriageloan})",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // TextButton.icon(
                        //   onPressed: () async {
                        //     await Share.share('com.example.matrimony_admin');
                        //   },
                        //   icon: ImageIcon(
                        //     const AssetImage('images/icons/share.png'),
                        //     size: 20,
                        //     color: main_color,
                        //   ),
                        //   label: const Text(
                        //     "Share App",
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.normal,
                        //         fontSize: 18),
                        //   ),
                        // ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (listofadminpermissions!
                                        .contains("Can Share App") ||
                                    listofadminpermissions!.contains("All")) {
                                  //await Share.share('com.example.matrimony_admin');
                                  SearchProfile().addtoadminnotification(
                                      userid: widget.userSave!.id!,
                                      useremail: widget.userSave!.email!,
                                      userimage:
                                          widget.userSave!.imageurls!.isEmpty
                                              ? ""
                                              : widget.userSave!.imageurls![0],
                                      title:
                                          "${userSave.displayName} CLICKS ON SHARE APP  ",
                                      email: userSave.email!,
                                      subtitle: "");

                                  await Share.share(
                                      'https://play.google.com/store/apps/details?id=com.freerishtey.android');
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/share.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Share App",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  widget.userSave.share == 0
                                      ? Text("")
                                      : Text(
                                          "Use(${widget.userSave.share})",
                                          style: TextStyle(
                                              color: main_color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (supprotdata.length > 0) {
                                  if (listofadminpermissions!
                                          .contains("Can See Support") ||
                                      listofadminpermissions!.contains("All")) {
                                    SearchProfile().addtoadminnotification(
                                        userid: widget.userSave!.id!,
                                        useremail: widget.userSave!.email!,
                                        userimage: widget
                                                .userSave!.imageurls!.isEmpty
                                            ? ""
                                            : widget.userSave!.imageurls![0],
                                        title:
                                            "${userSave.displayName} CLICKS ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} LEFT MENU SUPPORT  ",
                                        email: userSave.email!,
                                        subtitle: "");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Support(
                                                  newUserModel: widget.userSave,
                                                )));
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      'images/icons/community.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Support",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  supprotdata == null
                                      ? Center()
                                      : supprotdata.length == 0
                                          ? Text("")
                                          : supprotdata[0]["isAdmin"]
                                              ? Text(
                                                  "Replied (${(supprotdata.length / 2).ceil()})",
                                                  style: TextStyle(
                                                      color: main_color,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  "Pending (${(supprotdata.length / 2).ceil()})",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: DropdownButton(
                              icon: Icon(Icons.keyboard_arrow_down_sharp,
                                  size: 20),
                              underline: Container(
                                color: Colors.white,
                              ),
                              hint: Text("Admin Options",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                              onChanged: (val) {
                                setState(() {
                                  this.type = val;
                                });
                              },
                              //  menuMaxHeight: 200,
                              value: this.type,
                              items: [
                                DropdownMenuItem(
                                    value: 'Earth1',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.userSave.status ==
                                            "approved") {
                                          if (listofadminpermissions!.contains(
                                                  "Can See Match Profile") ||
                                              listofadminpermissions!
                                                  .contains("All")) {
                                            SearchProfile().addtoadminnotification(
                                                userid: widget.userSave!.id!,
                                                useremail:
                                                    widget.userSave!.email!,
                                                userimage: widget.userSave!
                                                        .imageurls!.isEmpty
                                                    ? ""
                                                    : widget.userSave!
                                                        .imageurls![0],
                                                title:
                                                    "${userSave.displayName} MATCH PROFILES WITH ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid}",
                                                email: userSave.email!,
                                                subtitle: "");
                                            Navigator.pop(context);
                                            Get.to(NewMatchProfile(
                                                newUserModel: widget.userSave));
                                          }
                                        } else {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  content: SnackBarContent(
                                                    error_text:
                                                        "Please Approve User First",
                                                    appreciation: "",
                                                    icon: Icons.error,
                                                    sec: 3,
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                );
                                              });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.person_2_outlined,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Match Profile")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '2',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        SearchProfile().addtoadminnotification(
                                            userid: widget.userSave!.id!,
                                            useremail: widget.userSave!.email!,
                                            userimage: widget.userSave!
                                                    .imageurls!.isEmpty
                                                ? ""
                                                : widget
                                                    .userSave!.imageurls![0],
                                            title:
                                                "${userSave.displayName} CLICK SHOW ADVERTISEMENT  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} LEFT MENU",
                                            email: userSave.email!,
                                            subtitle: "");
                                        if (listofadminpermissions!.contains(
                                                "Can Show Advertisement") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => ShowAd(
                                                        newUserModel:
                                                            widget.userSave,
                                                      )));
                                        }
                                        print(widget.userSave.showads);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "images/announcement.png",
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text("Show Advertisement")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '3',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (listofadminpermissions!.contains(
                                                "Can Boost Profile") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          if (widget.userSave.status ==
                                              "approved") {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) => Boost(
                                                          newUserModel:
                                                              widget.userSave,
                                                        )));
                                          } else {
                                            SearchProfile().addtoadminnotification(
                                                userid: widget.userSave!.id!,
                                                useremail:
                                                    widget.userSave!.email!,
                                                userimage: widget.userSave!
                                                        .imageurls!.isEmpty
                                                    ? ""
                                                    : widget.userSave!
                                                        .imageurls![0],
                                                title:
                                                    "${userSave.displayName} TRIED TO BOOST  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} ",
                                                email: userSave.email!,
                                                subtitle: "");

                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: SnackBarContent(
                                                      error_text:
                                                          "Please Approve User First",
                                                      appreciation: "",
                                                      icon: Icons.error,
                                                      sec: 3,
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  );
                                                });
                                          }
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            //FontAwesomeIcons.bolt,
                                            Icons.offline_bolt_outlined,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Boost Profile")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '4',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (listofadminpermissions!.contains(
                                                "Can Invisible Profile") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          if (widget.userSave.status ==
                                              "approved") {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Invisible(
                                                          newUserModel:
                                                              widget.userSave,
                                                        )));
                                          } else {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: SnackBarContent(
                                                      error_text:
                                                          "Please Approve The User First",
                                                      appreciation: "",
                                                      icon: Icons.error,
                                                      sec: 3,
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  );
                                                });
                                          }
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.person_off_outlined,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Invisible Profile")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '8',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (listofadminpermissions!.contains(
                                                "Can share profiles") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShareProfile(
                                                        userSave:
                                                            widget.userSave,
                                                      )));
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.ios_share_outlined,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Share Profile")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '5',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (listofadminpermissions!
                                                .contains("Can send OTP") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: SizedBox(
                                                  height: 244,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // SizedBox(
                                                      //   height: 26,
                                                      // ),
                                                      Text(
                                                        "Send OTP",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "Are You Sure about Send OTP?",
                                                          textAlign:
                                                              TextAlign.center),
                                                      SizedBox(
                                                        height: 23,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 6),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                shadowColor: MaterialStateColor.resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .black),
                                                                padding:
                                                                    MaterialStateProperty.all<
                                                                        EdgeInsetsGeometry?>(
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                    vertical:
                                                                        17,
                                                                  ),
                                                                ),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            60.0),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .white))),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<Color>(
                                                                        Colors.white)),
                                                            onPressed: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              AdminService().addtosendlink(
                                                                  email: widget
                                                                      .userSave
                                                                      .email,
                                                                  value:
                                                                      "OTP Verify");
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return const AlertDialog(
                                                                      content:
                                                                          SnackBarContent(
                                                                        appreciation:
                                                                            "",
                                                                        error_text:
                                                                            "OTP sent successfully",
                                                                        icon: Icons
                                                                            .check_circle,
                                                                        sec: 2,
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0,
                                                                    );
                                                                  });
                                                              // logout(context: context);
                                                            },
                                                            child: Text("Yes", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Serif', fontWeight: FontWeight.w700))),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 6),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                shadowColor: MaterialStateColor.resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .black),
                                                                padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            17)),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                60.0),
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<Color>(
                                                                        Colors.white)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Serif', fontWeight: FontWeight.w700))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.message,
                                            // FontAwesomeIcons.facebookMessenger,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Send OTP")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '6',
                                    child: GestureDetector(
                                      onTap: () {
                                        // if (listofadminpermissions!
                                        //         .contains("Can Send Link") ||
                                        //     listofadminpermissions!
                                        //         .contains("All")) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => SendLink(
                                                      newUserModel:
                                                          widget.userSave,
                                                    )));
                                        // }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.link,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Send Link")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '7',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (listofadminpermissions!.contains(
                                                "Can Send Notification") ||
                                            listofadminpermissions!
                                                .contains("All")) {
                                          SearchProfile().addtoadminnotification(
                                              userid: widget.userSave!.id!,
                                              useremail:
                                                  widget.userSave!.email!,
                                              userimage: widget.userSave!
                                                      .imageurls!.isEmpty
                                                  ? ""
                                                  : widget
                                                      .userSave!.imageurls![0],
                                              title:
                                                  "${userSave.displayName} CLICK ON SEND NOTIFICATION  LEFT NOW",
                                              email: userSave.email!,
                                              subtitle: "");
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SendNotification(
                                                        userSave:
                                                            widget.userSave,
                                                        users: [],
                                                      )));
                                        } else {}
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.notification_add,
                                            color: main_color,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Send Notification")
                                        ],
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: '7',
                                    enabled: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AudioClipScreen(
                                                isBulk: "false",
                                                newUserModel: widget.userSave,
                                                uid: widget.userSave.id,
                                              ),
                                            ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "images/icons/music.png",
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Send Audio Clip")
                                        ],
                                      ),
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  reviewdata == null
                      ? Center()
                      : reviewdata.isEmpty
                          ? Center()
                          : isReviewclicked == false
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      buildStar(1),
                                      buildStar(2),
                                      buildStar(3),
                                      buildStar(4),
                                      buildStar(5),
                                    ],
                                  ),
                                )
                              : reviewdata.isEmpty
                                  ? Center()
                                  : Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: const [
                                              BoxShadow(blurRadius: 0.05)
                                            ]),
                                        margin: const EdgeInsets.only(
                                          left: 28,
                                          right: 0,
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 7,
                                            right: 7,
                                            top: 7,
                                            bottom: 7),
                                        child: ExpandableText(
                                          reviewdata[0]["description"],
                                          collapseText: 'Less',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016),
                                          linkColor: main_color,
                                          onExpandedChanged: (value) {},
                                          // linkEllipsis:false,
                                          expandText: 'More',
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                  reviewdata == null
                      ? Center()
                      : reviewdata.isEmpty
                          ? Center()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: reviewdata[0]["description"] == ""
                                  ? Center()
                                  : Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isReviewclicked =
                                                  !isReviewclicked;
                                              SearchProfile()
                                                  .addtoadminnotification(
                                                      userid:
                                                          widget.userSave!.id!,
                                                      useremail: widget
                                                          .userSave!.email!,
                                                      userimage: widget
                                                              .userSave!
                                                              .imageurls!
                                                              .isEmpty
                                                          ? ""
                                                          : widget.userSave!
                                                              .imageurls![0],
                                                      title:
                                                          "${userSave.displayName} SEEN  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} FEEDBACK",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                            });
                                          },
                                          child: Text(
                                            isReviewclicked
                                                ? "Close"
                                                : "Read Review",
                                            style: TextStyle(color: main_color),
                                          ))),
                            ),
                  Text(
                    (widget.userSave!.status == "approved")
                        ? "Approved Profile"
                        : (widget.userSave!.editstatus == "" &&
                                widget.userSave!.status == "")
                            ? "Unapprove Profile"
                            : (widget.userSave!.editstatus == "unapprove")
                                ? "Edit Approve"
                                : "Approve",
                    style: TextStyle(
                        color: (widget.userSave!.status == "approved")
                            ? main_color
                            : Colors.red,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: main_color,
        selectedItemColor: main_color,
        onTap: (int index) {
          switch (index) {
            case 0:
              if (listofadminpermissions!.contains("Can Delete Profile") ||
                  listofadminpermissions!.contains("All") ||
                  widget.isDelete == true) {
                deleteAccount();
              }
              break;
            case 1:
              // logout(context: context);
              if ((listofadminpermissions!.contains("Can logout Profile") ||
                      listofadminpermissions!.contains("All")) &&
                  widget.userSave.isLogOut == "true") {
                {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: SizedBox(
                            height: 180,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 26,
                                // ),
                                // const LogoText(),

                                const Text(
                                    "Log Out \n You Want to Log Out User?",
                                    textAlign: TextAlign.center),
                                const SizedBox(
                                  height: 23,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.black),
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry?>(
                                            const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  side: BorderSide(
                                                    color:
                                                        (color_done2 == false)
                                                            ? Colors.white
                                                            : main_color,
                                                  ))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white)),
                                      onPressed: () async {
                                        setState(() {
                                          widget.userSave.isLogOut = "false";
                                          color_done2 = true;
                                        });
                                        SearchProfile().addtoadminnotification(
                                            userid: widget.userSave!.id!,
                                            useremail: widget.userSave!.email!,
                                            userimage: widget.userSave!
                                                    .imageurls!.isEmpty
                                                ? ""
                                                : widget
                                                    .userSave!.imageurls![0],
                                            title:
                                                "${userSave.displayName} LOGOUT PROFILE OF ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} ",
                                            email: userSave.email!,
                                            subtitle: "");
                                        HomeService().updatelogin(
                                            email: widget.userSave.email!,
                                            mes: "false");
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                content: SnackBarContent(
                                                  appreciation: "",
                                                  error_text:
                                                      "User Log Out Successfully",
                                                  icon: Icons.check_circle,
                                                  sec: 2,
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              );
                                            });

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Yes",
                                        style: (color_done2 == false)
                                            ? const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Serif',
                                                fontWeight: FontWeight.w700)
                                            : TextStyle(
                                                color: main_color,
                                                fontSize: 16,
                                                fontFamily: 'Serif',
                                                fontWeight: FontWeight.w700),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shadowColor: MaterialStateColor.resolveWith(
                                              (states) => Colors.black),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 12)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel",
                                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Serif', fontWeight: FontWeight.w700))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              break;
          }
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24, // Set width explicitly
              height: 24, // Set height explicitly
              child: ImageIcon(
                AssetImage('images/icons/delete_bin.png'),
                size: 22, // Ensure size consistency
                color: widget.isDelete == true ? Colors.red : main_color,
              ),
            ),
            label: 'Delete Profile',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24, // Ensure width consistency
              height: 24, // Ensure height consistency
              child: Icon(
                Icons.logout,
                size: 22, // Same as ImageIcon
                color: widget.userSave.isLogOut == "false"
                    ? Colors.red
                    : main_color,
              ),
            ),
            label: 'Log Out',
          ),
        ],
        selectedFontSize: 12, // Adjust label size if needed
        unselectedFontSize: 12,
      ),
    );
  }
}

Future<void> logout({required BuildContext context}) async {
  SharedPref sharedpref = SharedPref();
  await NotificationFunction.setonlineStatus(userSave.uid!, "Offline");
  sharedpref.remove("user");
  sharedpref.remove("uid");
  sharedpref.remove("savedPref");
  isLogin = false;
  uid = "";
  ImageUrls().clear();

  friends = []; //sent requests
  friendr = []; //received requests
  frienda = []; //accepted requests
  friendrej = []; //rejected requests
  blocFriend = []; //blocked users
  reportFriend = []; //blocked users
  shortFriend = [];
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    if (!kIsWeb) {
      await googleSignIn.signOut();
    }
    // await FirebaseFirestore.instance
    //     .collection("deleted_account")
    //     .doc(uid)
    //     .update({'connectivity': "Offline"});

    await FirebaseAuth.instance.signOut();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: SnackBarContent(
          error_text: "Error Logout",
          appreciation: "",
          icon: Icons.error,
          sec: 2,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  // NotificationFunction.setNotification(
  //   "admin",
  //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} LOGOUT PROFILE ",
  //   'logout',
  // );
  // NotificationFunction.setNotification(
  //   "user1",
  //   "LOGOUT SUCCESSFULLY ",
  //   'logout',
  // );
  userSave = usr.User();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (builder) => FirstScreen()), (route) => false);
}
