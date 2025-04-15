import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/profile/ProfilePage.dart';
import 'package:matrimony_admin/screens/profile/profile_service.dart';
import 'package:matrimony_admin/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/notification/navHome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../../Chat/screens/mobile_chat_screen.dart';
import '../../models/searchFunctions.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';
import '../ERRORs/save_pref_errors.dart';
import '../navigation/navigator.dart';
import '../profie_types/sortprofile.dart';
import '../profile/filter.dart';
import '../service/search_profile.dart';

User? profiledata;

class SearchSlideProfile extends StatefulWidget {
  SearchSlideProfile(
      {super.key,
      this.type = "",
      this.user_data,
      this.user_list,
      this.forIos,
      this.currentSliderValue,
      this.isdelete = false,
      required this.ages,
      required this.religionList,
      required this.kundaliDoshList,
      required this.maritalStatusList,
      required this.dietList,
      required this.drinkList,
      required this.smokeList,
      required this.disabilityList,
      required this.heightList,
      required this.educationList,
      required this.professionList,
      required this.incomeList,
      required this.statelocation,
      required this.citylocation,
      required this.lat,
      required this.lng,
      required this.location});
  String type;
  var user_data;
  var user_list;
  bool isdelete = false;
  bool? forIos;
  int? currentSliderValue;
  final List<String> ages;

  final List<dynamic> religionList;
  final List<dynamic> kundaliDoshList;
  final List<dynamic> maritalStatusList;
  final List<dynamic> dietList;
  final List<dynamic> drinkList;
  final List<dynamic> smokeList;
  final List<dynamic> disabilityList;
  final List<dynamic> heightList;
  final List<dynamic> educationList;
  final List<dynamic> professionList;
  final List<dynamic> incomeList;
  final double lat;
  final double lng;
  final List<dynamic> statelocation;
  final List<dynamic> citylocation;
  final List<dynamic> location;
  @override
  State<SearchSlideProfile> createState() => _SlideProfileState();
}

class _SlideProfileState extends State<SearchSlideProfile> {
  int num = 6;
  int pagecount = 2;
  bool load = false;
  DatabaseReference? _notificationsRef;
  int _unreadCount = 0;
  // User userSave = User();
  List<User> userlist = [];
  List<User> largeuserlist = [];
  bool nodata = false;
  cloud.QueryDocumentSnapshot? lastDocument;
  int numofnoti = 0;
  void getallnumofunreadnoti() async {
    numofnoti = await HomeService().getthenumberofunread();
    setState(() {});
  }

  SearchDataList sdl = SearchDataList();

  @override
  void initState() {
    print("Page is Running");
    super.initState();
    setuserData();

    // HomeService().getusersaveprefdata();
    // getConnectivity();
    getallnumofunreadnoti();
    HomeService().getuserdata().whenComplete(() {
      //  AuthService().getadmin(userSave.email!);
      userSave.latitude = widget.lat;
      userSave.longitude = widget.lng;
      setState(() {});
    });
    getUserList();
    // setdata();
    // _notificationsRef =
    //     FirebaseDatabase.instance.ref().child('user1').child(userSave.uid!);
    // _notificationsRef!.onValue.listen((event) {
    //   int count = 0;
 
    //   // Map<dynamic, dynamic> notifications =
    //   //     event.snapshot.value as Map<dynamic, dynamic>;
    //   // if (notifications != null) {
    //   //   notifications.forEach((key, value) {
    //   //     if (!value['seen']) {
    //   //       count++;
    //   //     }
    //   //   });
    //   // }
    //   setState(() {
    //     _unreadCount = count;
    //   });
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      profiledata = User.fromdoc(await FirebaseFirestore.instance
          .collection("user_data")
          .doc(message.data["uid"])
          .get());
      print(message.data['click_action']);
      print(profiledata.toString());
      // if (message.data["route"] == "profilepage");
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (builder) => ProfilePage(
      //           userSave: profiledata,
      //           isdelete: widget.isdelete,
      //         )));
    });
  }

  setuserData() async {
    print("uid out if ${uid}");
    // if (uid == null || uid == "") {
    //   print("uid under if ${uid}");
    //   final json2 = await sharedPref.read("uid");
    //   final json3 = await sharedPref.read("user");
    //   setState(() {
    //     uid = json2['uid'];
    //     userSave = User.fromJson(json3);
    //   });
    // }
    // await setsavedpref();
    getUserList();
  }

  setsavedpref() async {
    try {
      // final doc = await cloud.FirebaseFirestore.instance
      //     .collection('saved_pref')
      //     .doc(uid)
      //     .get();
      // savedPref = SavedPref.fromdoc(doc);
      // await sharedPref.save("savedPref", savedPref);
    } catch (e) {
      print(e);
    }
  }

  // setdata() async {
  //   try {
  //     final doc = await cloud.FirebaseFirestore.instance
  //         .collection('friend_list')
  //         .doc(uid)
  //         .get();

  //     FriendList? fl2;
  //     fl2 = (doc.exists)
  //         ? FriendList.fromdoc(doc)
  //         : FriendList(sent: [], received: []);
  //     if (fl != fl2) {
  //       fl = fl2;
  //       friends!.clear();
  //       frienda!.clear();
  //       for (var i = 0; i < fl!.sent!.length; i++) {
  //         setState(() {
  //           friends!.add(fl!.sent![i]["toUid"]);
  //           if (fl!.sent![i]["status"] == "accepted") {
  //             frienda!.add(fl!.sent![i]["toUid"]);
  //           } else if (fl!.sent![i]["status"] == "rejected") {
  //             friendrej!.add(fl!.sent![i]["toUid"]);
  //           }
  //         });
  //       }
  //       friendr!.clear();
  //       for (var i = 0; i < fl!.received!.length; i++) {
  //         setState(() {
  //           friendr!.add(fl!.received![i]["fromUid"]);
  //           if (fl!.received![i]["status"] == "accepted") {
  //             frienda!.add(fl!.received![i]["fromUid"]);
  //           }
  //         });
  //       }
  //       final blocquery = await cloud.FirebaseFirestore.instance
  //           .collection('block_list')
  //           .doc(uid)
  //           .get();
  //       bl = (blocquery.exists)
  //           ? Blocklist.fromdoc(blocquery)
  //           : Blocklist(users: []);
  //       blocFriend!.clear();
  //       for (var i = 0; i < bl!.users!.length; i++) {
  //         setState(() {
  //           blocFriend!.add(bl!.users![i]["toUid"]);
  //         });
  //       }
  //       final reportquery = await cloud.FirebaseFirestore.instance
  //           .collection('report_list')
  //           .doc(uid)
  //           .get();
  //       rl = (reportquery.exists)
  //           ? ReportList.fromdoc(reportquery)
  //           : ReportList(users: []);
  //       reportFriend!.clear();
  //       for (var i = 0; i < rl!.users!.length; i++) {
  //         setState(() {
  //           reportFriend!.add(rl!.users![i]["toUid"]);
  //         });
  //       }
  //       final shortquery = await cloud.FirebaseFirestore.instance
  //           .collection('short_list')
  //           .doc(uid)
  //           .get();
  //       sl = (shortquery.exists)
  //           ? ReportList.fromdoc(shortquery)
  //           : ReportList(users: []);
  //       shortFriend!.clear();
  //       for (var i = 0; i < sl!.users!.length; i++) {
  //         setState(() {
  //           shortFriend!.add(sl!.users![i]["toUid"]);
  //         });
  //       }
  //       await sharedPref.save("friendList", fl);
  //       await sharedPref.save("blocklist", bl);
  //       await sharedPref.save("reportlist", rl);
  //       await sharedPref.save("shortlist", sl);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Icon(
            Icons.error,
            color: main_color,
          ),
          content: const Text('No Internet Connection'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                if (!mounted) return;
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  if (!mounted) return;
                  setState(() => isAlertSet = true);
                }
              },
              child: Text(
                'OK',
                style: TextStyle(color: main_color),
              ),
            )
          ],
        ),
      );
  List<NewUserModel> allusers = [];
  final int initialPage = 0;
  final int itemsPerPage = 10;
  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //           (ConnectivityResult result) async {
  //             print("Shivam is Connected");
  //             isDeviceConnected =
  //                 await InternetConnectionChecker().hasConnection;
  //             if (!isDeviceConnected && isAlertSet == false) {
  //               showDialogBox();
  //               if (!mounted) return;
  //               setState(() => isAlertSet = true);
  //             }
  //           } as void Function(List<ConnectivityResult> event)?,
  //         );
  getUserList() async {
    load = true;
    setState(() {});

    if (widget.user_data == null && widget.user_list == null) {
      print("*F(((********)))");
      allusers = await HomeService().getallusers(page: "1");
      setState(() {});
      load = false;
      setState(() {});
    } else if (widget.user_data != null) {
      allusers.clear();
      allusers.addAll(widget.user_data);
      setState(() {});
      load = false;
      setState(() {});
    }
  }

  setuserlist() {
    if (largeuserlist.isEmpty) {
      getUserList();
    } else {
      Random random = Random();
      int count = 6;
      if (largeuserlist.length < 6) {
        count = largeuserlist.length;
      }
      for (var i = 0; i < count; i++) {
        int randomIndex = random.nextInt(largeuserlist.length);
        setState(() {
          userlist.add(largeuserlist[randomIndex]);
          num = userlist.length;
          load = true;
        });
        largeuserlist.removeAt(randomIndex);
        // randomData.removeAt(randomIndex);
      }
    }
  }

  SavedPref svp = SavedPref();

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
    //                 newUserModel: ,
    //                 profileDetail: profiledata,
    //                 profilepic: profilepic),
    //           )),
    // );
  }

  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scrollKey,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            load == true
                ? Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(),
                        // Text(
                        //     "No data available according to preference \nKindly change your preference"),
                      ],
                    ),
                  )
                : allusers.isEmpty
                    ? SavePreferencesError()
                    : PageView.builder(
                        controller: controller,
                        onPageChanged: (i) async {
                          if (i == allusers.length - 4) {
                            List<NewUserModel> alldata = await SearchProfile()
                                .searchuserdata(
                                    lat: widget.lat,
                                    lng: widget.lng,
                                    maxDistanceKm:
                                        widget.currentSliderValue!.toInt(),
                                    gender: widget.forIos == false
                                        ? "male"
                                        : "female",
                                    email: userSave.email!,
                                    religion: userSave.email!,
                                    page: pagecount,
                                    ages: widget.ages,
                                    religionList: widget.religionList,
                                    kundaliDoshList: widget.kundaliDoshList,
                                    maritalStatusList: widget.maritalStatusList,
                                    dietList: widget.dietList,
                                    drinkList: widget.drinkList,
                                    smokeList: widget.smokeList,
                                    disabilityList: svp.DisabilityList,
                                    heightList: widget.heightList,
                                    educationList: widget.educationList,
                                    professionList: widget.professionList,
                                    incomeList: widget.incomeList,
                                    citylocation: widget.citylocation,
                                    statelocation: widget.statelocation,
                                    location: widget.location);
                            pagecount++;
                            allusers.addAll(alldata);
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Expanded(
                              child: ProfilePage(
                                // list: newuserlists,
                                isDelete:
                                    widget.isdelete == true ? "true" : "false",
                                index: index,
                                userSave: allusers[index],
                                controller: controller,
                                // pushchat: pushChatPage
                              ),
                            ),
                          ]);
                        },
                        itemCount: allusers.length,
                      ),
            Positioned(
                right: 30.0,
                top: 100.0,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!
                            .contains("Can See right menu") ||
                        listofadminpermissions!.contains("All")) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterC()));
                    }

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 250,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SortProfileScreen()));

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: Icon(
                    FontAwesomeIcons.sort,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 150.0,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!
                            .contains("Can search profiles") ||
                        listofadminpermissions!.contains("All")) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()));
                    }

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 200.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LetsStart()));

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
