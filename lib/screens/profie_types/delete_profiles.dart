import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/models/delete_profile.dart';
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
import 'package:matrimony_admin/screens/service/search_profile.dart';
import '../../Chat/screens/mobile_chat_screen.dart';
import '../../models/searchFunctions.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';
import '../ERRORs/save_pref_errors.dart';
import '../navigation/navigator.dart';
import '../profie_types/sortprofile.dart';
import '../profile/filter.dart';

User? profiledata;

class DeleteProfile extends StatefulWidget {
  DeleteProfile(
      {super.key,
      this.type = "",
      this.user_data,
      this.user_list,
      this.searchText,
      this.isdelete = false});
  String type;
  String? searchText;
  var user_data;
  var user_list;
  bool isdelete = false;
  @override
  State<DeleteProfile> createState() => _SlideProfileState();
}

class _SlideProfileState extends State<DeleteProfile> {
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
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (List<ConnectivityResult> results) async {
              print("Connected to: $results");
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected && isAlertSet == false) {
                showDialogBox();
                if (!mounted) return;
                setState(() => isAlertSet = true);
              }
            },
          );
  getUserList() async {
    load = true;
    setState(() {});

    allusers.clear();
    allusers.addAll(widget.user_list);
    setState(() {});
    load = false;
    setState(() {});
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
  ) {}

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
                          if (i == allusers.length - 5) {
                            List<NewUserModel> getdata = await SearchProfile()
                                .deleteProfiles(
                                    page: pagecount,
                                    searchText: widget.searchText!);
                            pagecount++;
                            allusers.addAll(getdata);
                            setState(() {});
                          }
                        },

                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Expanded(
                              child: 
                              ProfilePage(
                                // list: newuserlists,
                                index: "true",
                                isDelete: "true",
                                type: "true",

                                userSave: allusers[index],
                                controller: controller,

                                // pushchat: pushChatPage
                              ),
                            ),
                          ]);
                        },
                        // itemCount: allusers.length,
                      ),
        
          Positioned(
                right: 5.0,
                top: 75.0,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Icon(
                      FontAwesomeIcons.filter,
                      color: Colors.white,
                      size: 18,
                      shadows: <Shadow>[
                        Shadow(color: Colors.black, blurRadius: 10.0)
                      ],
                    ),
                  ),
                )),
            Positioned(
                right: 15.0,
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
                right: 15.0,
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
                right: 15.0,
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
