// import 'package:matrimony_admin/screens/profile/filter/profiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/profie_types/manage_admin.dart';
import 'package:matrimony_admin/screens/profie_types/manage_advertisiment.dart';
import 'package:matrimony_admin/screens/profie_types/manage_bubbles.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/profile/profile_service.dart';

import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import 'package:matrimony_admin/sendUtils/notiFunction.dart';
import '../../Assets/ImageDart/images.dart';
import '../../common/widgets/logotext.dart';
import '../../globalVars.dart';
import '../../models/admin_model.dart';
import '../../models/shared_pref.dart';
import '../navigation/admin_options/Charts/charts_screen.dart';
import '../profie_types/create_admin_service.dart';
import '../profie_types/main_profile_types.dart';

class FilterC extends StatefulWidget {
  const FilterC({super.key});

  @override
  State<FilterC> createState() => _ReligionState();
}

class _ReligionState extends State<FilterC> {
  int value = 0;
  var data;
  Future<void> logout({required BuildContext context}) async {
    SharedPref sharedpref = SharedPref();
    await NotificationFunction.setonlineStatus(userSave.uid!, "Offline");

    sharedpref.remove("user");
    sharedpref.remove("uid");
    sharedpref.remove("savedPref");
    isLogin = false;
    uid = "";
    ImageUrls().clear();

    SearchProfile().addtoadminnotification(
        userid: userSave.uid!,
        useremail: userSave.email!,
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title: "${userSave.displayName} LOGOUT SUCCESSFULLY BY OWNSELF",
        email: userSave.email!,
        subtitle: "");
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) => const FirstScreen()),
        (route) => false);
  }

  int total = 0;
  void getnumberuser() async {
    total = await HomeService().gettotaluser();
    int deletetotla = await HomeService().getdeletetotaluser();
    total += deletetotla;
    setState(() {});
  }

  int daily = 0;
  bool ison = true;
  DateTime? selectedDate = DateTime.now();
  void getuser(String year, String month, String day) async {
    daily = await NotiService().getdailyuser(year, month, day);

    setState(() {});
  }

  void getmendata() async {
    data = await AdminService().getmaintenance();

    print("***********************");
    print(data);
    ison = data[0]["isUnder"];
    setState(() {});
  }

  List<AdminModel> alladmins = [];
  void getalladmins() async {
    alladmins = await CreateAdminService().getalladmins();
    setState(() {});
  }

  @override
  void initState() {
    getalladmins();
    getmendata();
    getnumberuser();
    getuser(selectedDate!.year.toString(), selectedDate!.month.toString(),
        selectedDate!.day.toString());
    print(userSave.email);
    super.initState();
  }

  DateTime nowdate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }

    String formattedDate =
        DateFormat('yyyy-MM-dd 00:00:00.000').format(nowdate);
    getuser(picked!.year.toString(), picked.month.toString(),
        picked.day.toString());

    if (formattedDate == picked.toString()) {
      getnumberuser();
    } else {
      total = total - daily;
    }
    SearchProfile().addtoadminnotification(
        userid: "212",
        useremail: userSave.email!,
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title:
            "${userSave.displayName} SEEN TOTAL USERs DATED  ${DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(picked.toString()).toLocal())} USERS $total",
        email: userSave.email!,
        subtitle: "");
    // getdailyuser()
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          actions: [
            userSave.email == "s9728401234@gmail.com" ||
                    userSave.email == "s9053622222@gmail.com" ||
                    userSave.email == "pandityunish1228@gmail.com" ||
                    userSave.email == "yunishpandit98@gmail.com"
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      height: 35,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Track
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: ison ? Colors.black12 : main_color,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            width: 55,
                            height: 28,
                          ),
                          // Thumb with text
                          Align(
                            alignment: ison
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ison = !ison;
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 244,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // SizedBox(
                                            //   height: 26,
                                            // ),
                                            Text.rich(TextSpan(
                                                style: TextStyle(fontSize: 20),
                                                children: [
                                                  TextSpan(
                                                      text: "Free ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  TextSpan(
                                                      text: "Rishtey Wala",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: main_color,
                                                      )),
                                                  // TextSpan(
                                                  //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
                                                ])),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Are You Sure You Want ${ison == true ? "Stop" : "Start"} Platform?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 23,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 6),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shadowColor:
                                                          MaterialStateColor.resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                      padding:
                                                          MaterialStateProperty.all<
                                                              EdgeInsetsGeometry?>(
                                                        EdgeInsets.symmetric(
                                                          vertical: 15,
                                                        ),
                                                      ),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      60.0),
                                                              side: BorderSide(
                                                                color:
                                                                    main_color,
                                                              ))),
                                                      backgroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              Colors.white)),
                                                  onPressed: () async {
                                                    NotiService()
                                                        .updatemaintenance(
                                                            ison);
                                                    SearchProfile()
                                                        .addtoadminnotification(
                                                            userid:
                                                                userSave.puid!,
                                                            useremail:
                                                                userSave.email!,
                                                            userimage: userSave
                                                                    .imageUrls!
                                                                    .isEmpty
                                                                ? ""
                                                                : userSave
                                                                        .imageUrls![
                                                                    0],
                                                            title:
                                                                "${userSave.displayName} ${value == true ? "START" : "STOP"} PLATFORM SUCCESSFULLY ",
                                                            email:
                                                                userSave.email!,
                                                            subtitle: "");
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                    // logout(context: context);
                                                  },
                                                  child: Text("Yes",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Serif',
                                                          fontWeight: FontWeight.w700))),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // InkWell(
                                            //     onTap: () {
                                            //       Navigator.pop(context);
                                            //     },
                                            //     child: const SpecialButtom(text: "Cancel"))
                                            Container(
                                              margin: EdgeInsets.only(left: 6),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shadowColor:
                                                          MaterialStateColor.resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                      padding: MaterialStateProperty.all<
                                                              EdgeInsetsGeometry?>(
                                                          EdgeInsets.symmetric(
                                                              vertical: 15)),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(60.0),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("No", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Serif', fontWeight: FontWeight.w700))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 20,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ison ? "Off" : "On",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                //               Material(
                //                   child: Switch(
                //                     value: ison,
                //                     onChanged: (value) {
                //                       ison = value;
                //                         showDialog(
                //                   context: context,
                //                   builder: (context) {
                //                     return AlertDialog(
                //                       content: SizedBox(
                //                         height: 244,
                //                         child: Column(
                //                           mainAxisAlignment: MainAxisAlignment.center,
                //                           children: [
                //                             // SizedBox(
                //                             //   height: 26,
                //                             // ),
                //                             LogoText(),
                //                             SizedBox(
                //                               height: 5,
                //                             ),
                //                             Text("Are You Sure You Want Stop Platform?",
                //                                 textAlign: TextAlign.center),
                //                             SizedBox(
                //                               height: 23,
                //                             ),
                //                             Container(
                //                               margin: EdgeInsets.only(left: 6),
                //                               width: MediaQuery.of(context).size.width * 0.8,
                //                               child: ElevatedButton(
                //                                   style: ButtonStyle(
                //                                       shadowColor:
                //                                           MaterialStateColor.resolveWith(
                //                                               (states) => Colors.black),
                //                                       padding: MaterialStateProperty.all<
                //                                           EdgeInsetsGeometry?>(
                //                                         EdgeInsets.symmetric(
                //                                           vertical: 17,
                //                                         ),
                //                                       ),
                //                                       shape: MaterialStateProperty.all<
                //                                               RoundedRectangleBorder>(
                //                                           RoundedRectangleBorder(
                //                                               borderRadius:
                //                                                   BorderRadius.circular(60.0),
                //                                               side: BorderSide(
                //                                                 color:
                //                                                      main_color,
                //                                               ))),
                //                                       backgroundColor:
                //                                           MaterialStateProperty.all<Color>(
                //                                               Colors.white)),
                //                                   onPressed: () async {

                // NotiService().updatemaintenance(value);
                //                       SearchProfile().addtoadminnotification(
                //                           userid: userSave.puid!,
                //                           useremail: userSave.email!,
                //                           userimage: userSave.imageUrls!.isEmpty
                //                               ? ""
                //                               : userSave.imageUrls![0],
                //                           title:
                //                               "${userSave.displayName} ${value == true ? "START" : "STOP"} PLATFORM SUCCESSFULLY ",
                //                           email: userSave.email!,
                //                           subtitle: "");
                //                       setState(() {});
                //                                     Navigator.pop(context);
                //                                     // logout(context: context);
                //                                   },
                //                                   child: Text(
                //                                     "Yes",
                //                                     style:  TextStyle(
                //                                             color: Colors.black,
                //                                             fontSize: 16,
                //                                             fontFamily: 'Serif',
                //                                             fontWeight: FontWeight.w700)

                //                                   )),
                //                             ),
                //                             SizedBox(
                //                               height: 10,
                //                             ),
                //                             // InkWell(
                //                             //     onTap: () {
                //                             //       Navigator.pop(context);
                //                             //     },
                //                             //     child: const SpecialButtom(text: "Cancel"))
                //                             Container(
                //                               margin: EdgeInsets.only(left: 6),
                //                               width: MediaQuery.of(context).size.width * 0.8,
                //                               child: ElevatedButton(
                //                                   style: ButtonStyle(
                //                                       shadowColor:
                //                                           MaterialStateColor.resolveWith(
                //                                               (states) => Colors.black),
                //                                       padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                //                                           EdgeInsets.symmetric(vertical: 17)),
                //                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //                                           RoundedRectangleBorder(
                //                                               borderRadius:
                //                                                   BorderRadius.circular(60.0),
                //                                               side: BorderSide(
                //                                                 color: Colors.white,
                //                                               ))),
                //                                       backgroundColor:
                //                                           MaterialStateProperty.all<Color>(
                //                                               Colors.white)),
                //                                   onPressed: () {
                //                                     Navigator.of(context).pop();
                //                                   },
                //                                   child: Text("Cancel",
                //                                       style: TextStyle(
                //                                           color: Colors.black,
                //                                           fontSize: 16,
                //                                           fontFamily: 'Serif',
                //                                           fontWeight: FontWeight.w700))),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 );

                //                     },
                //                   ),
                //                 )
                : const SizedBox(
                    height: 10,
                    width: 20,
                  ),
          ],
          title: Text.rich(
              TextSpan(style: const TextStyle(fontSize: 20), children: [
            const TextSpan(
                text: "Free",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            TextSpan(
                text: " Rishtey Wala",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: main_color,
                )),
          ])),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (builder) => SlideProfile()),
                                  (route) => false);
                            },
                            child: const Text(
                              "Home",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              if (listofadminpermissions!
                                      .contains("Can See right menu") ||
                                  listofadminpermissions!.contains("All")) {
                                // Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainProfilesTypes()));
                              }
                            },
                            //icon: Icon(Icons.home),
                            child: Text(
                              "Manage Profiles ($total)",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          listofadminpermissions!.contains("All") ||
                                  listofadminpermissions!
                                      .contains("Manage Admins")
                              ? InkWell(
                                  onTap: () {
                                    SearchProfile().addtoadminnotification(
                                        userid: userSave.puid!,
                                        useremail: userSave.email!,
                                        userimage: userSave.imageUrls!.isEmpty
                                            ? ""
                                            : userSave.imageUrls![0],
                                        title:
                                            "${userSave.displayName} CLICK MANAGE ADMIN ",
                                        email: userSave.email!,
                                        subtitle: "");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ManageAdmin(),
                                        ));

                                    //Navigator.of(context).pop();
                                  },
                                  //icon: Icon(Icons.home),
                                  child: Text(
                                    "Manage Admins (${alladmins.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          listofadminpermissions!.contains("All") ||
                                  listofadminpermissions!
                                      .contains("Manage Advertisements")
                              ? InkWell(
                                  onTap: () {
                                    if (listofadminpermissions!.contains(
                                            "Can Change Advetisements") ||
                                        listofadminpermissions!
                                            .contains("All")) {
                                      SearchProfile().addtoadminnotification(
                                          userid: userSave.puid!,
                                          useremail: userSave.email!,
                                          userimage: userSave.imageUrls!.isEmpty
                                              ? ""
                                              : userSave.imageUrls![0],
                                          title:
                                              "${userSave.displayName} CLICK MANAGE ADVERTISIMENTS IN RIGHT MENU ",
                                          email: userSave.email!,
                                          subtitle: "");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ManageAdvertisiment(),
                                          ));
                                    }

                                    //Navigator.of(context).pop();
                                  },
                                  //icon: Icon(Icons.home),
                                  child: const Text(
                                    "Manage Advertisements (106)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          listofadminpermissions!.contains("All") ||
                                  listofadminpermissions!
                                      .contains("Manage Bubble Pictures")
                              ? InkWell(
                                  onTap: () {
                                    SearchProfile().addtoadminnotification(
                                        userid: "212",
                                        useremail: userSave.email!,
                                        userimage: userSave.imageUrls!.isEmpty
                                            ? ""
                                            : userSave.imageUrls![0],
                                        title:
                                            "${userSave.displayName} CLICK ON MANAGE BUBBLE PICS  ",
                                        email: userSave.email!,
                                        subtitle: "");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ManageBubbles(),
                                        ));

                                    //Navigator.of(context).pop();
                                  },
                                  //icon: Icon(Icons.home),
                                  child: const Text(
                                    "Manage Bubble Pictures",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          listofadminpermissions!.contains("All") ||
                                  listofadminpermissions!
                                      .contains("Manage Charts")
                              ? InkWell(
                                  onTap: () {
                                    SearchProfile().addtoadminnotification(
                                        userid: "212",
                                        useremail: userSave.email!,
                                        userimage: userSave.imageUrls!.isEmpty
                                            ? ""
                                            : userSave.imageUrls![0],
                                        title:
                                            "${userSave.displayName} CLICK ON CHARTS  ",
                                        email: userSave.email!,
                                        subtitle: "");
                                    //Navigator.of(context).pop();
                                    Get.to(const ChartsScreen());
                                  },
                                  //icon: Icon(Icons.home),
                                  child: const Text(
                                    "Manage Charts",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      //color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              //Navigator.of(context).pop();
                              logout(context: context);
                            },
                            //icon: Icon(Icons.home),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              listofadminpermissions!.contains("All") ||
                      listofadminpermissions!.contains("Can See Total Users")
                  ? Center(
                      child: Column(
                      children: [
                        Text(
                          "Total Users $total",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 60,
                            ),
                            Text(
                              "According to ${selectedDate!.day} - ${selectedDate!.month} - ${selectedDate!.year}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: main_color,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: main_color),
                            ),
                            child: Column(
                              children: [
                                // Header Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        "Visitors",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Daily",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                        textAlign: TextAlign
                                            .center, // Centering the "Daily" column
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Desktop Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text("Desktop",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),

                                // Browser Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text("Browser",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),

                                // Downloads Header
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text("Downloads",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ),
                                    Expanded(
                                        child: Text("",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15))),
                                    Expanded(
                                        child: Text("",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15))),
                                  ],
                                ),

                                // Android Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text("Android",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ),
                                    Expanded(
                                      child: Text(
                                        daily.toString(),
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign
                                            .center, // Center aligning the value
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "$total",
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),

                                // iOS Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text("IOS",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text("0",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                        /*ListTile(
                  
                            title:Text("Total Users "),
                            subtitle: Text("According to 15 Feb 2023"),
                            trailing: Icon(
                              Icons.calendar_month
                  
                            ),
                          )*/
                      ],
                    ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
