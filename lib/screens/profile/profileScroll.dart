import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:matrimony_admin/screens/service/home_service.dart';

import '../../models/user_model.dart';
import '../ERRORs/save_pref_errors.dart';
import '../maintinance_screen.dart';
import '../profie_types/sortprofile.dart';
import '../service/search_profile.dart';
import 'ProfilePage.dart';
import 'filter.dart';

User? profiledata;

class SlideProfile extends StatefulWidget {
  SlideProfile(
      {super.key,
      this.type = "",
      this.user_data,
      this.user_list,
      this.isdelete = false});
  String type;
  var user_data;
  var user_list;
  bool isdelete = false;
  @override
  State<SlideProfile> createState() => _SlideProfileState();
}

class _SlideProfileState extends State<SlideProfile> {
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

  void getConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types

      showDialogBox(); // Make sure this is implemented
      if (!mounted) return; // Ensure this is within a StatefulWidget
      setState(() => isAlertSet = true);
    }
    // subscription = Connectivity().onConnectivityChanged.listen(
    //   (ConnectivityResult result) async {
    //     print("Shivam is Connected");
    //     isDeviceConnected = await InternetConnectionChecker().hasConnection;
    //     if (!isDeviceConnected && !isAlertSet) {
    //       showDialogBox(); // Make sure this is implemented
    //       if (!mounted) return; // Ensure this is within a StatefulWidget
    //       setState(() => isAlertSet = true);
    //     }
    //   },
    // );
  }

  @override
  void initState() {
    print("Page is Running");
    super.initState();
    setuserData();

    // HomeService().getusersaveprefdata();
    getConnectivity();
    getallnumofunreadnoti();
    HomeService().getuserdata().whenComplete(() {
      //  AuthService().getadmin(userSave.email!);
    });
    getUserList();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      profiledata = User.fromdoc(await FirebaseFirestore.instance
          .collection("user_data")
          .doc(message.data["uid"])
          .get());
      print(message.data['click_action']);
      print(profiledata.toString());
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            load == true
                ? const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Color(0xFF38B9F4),
                        ),
                        // Text(
                        //     "No data available according to preference \nKindly change your preference"),
                      ],
                    ),
                  )
                : allusers.isEmpty
                    ? const SavePreferencesError()
                    : PageView.builder(
                        controller: controller,
                        onPageChanged: (i) async {
                          if (i == allusers.length - 4) {
                            List<NewUserModel> getdata = await HomeService()
                                .getallusers(page: pagecount.toString());
                            pagecount++;
                            allusers.addAll(getdata);
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Expanded(
                              child: ProfilePage(
                                isDelete: "false",
                                // list: newuserlists,
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
                top: 90.0,
                child: GestureDetector(
                  onTap: () {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "lksjflajk",
                        userimage: "",
                        title: "${userSave.displayName} CLICK ON RIGHT MENU",
                        email: userSave.email!,
                        subtitle: "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterC()));
                  },
                  child: const Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 220,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!.contains("Can See Sort") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title: "${userSave.displayName} CLICK ON SORT",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SortProfileScreen()));
                    }
                  },
                  child: const Icon(
                    FontAwesomeIcons.sort,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 130.0,
                child: GestureDetector(
                  onTap: () {
                    print(listofadminpermissions);
                    if (listofadminpermissions!
                            .contains("Can See Search Bar") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title:
                              "${userSave.displayName} CLICK ON ADMIN SEARCH BAR ",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()));
                    }

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: const Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 30.0,
                top: 170.0,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!
                            .contains("Can Create Profile") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title:
                              "${userSave.displayName} CLICK ON PROFILE CREATE BY ADMIN",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LetsStart()));
                    }
                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: const Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.white,
                    size: 18,
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
