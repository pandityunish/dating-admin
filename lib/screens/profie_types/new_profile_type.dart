import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';
import 'package:matrimony_admin/screens/profie_types/detail_profile_types.dart';
import 'package:matrimony_admin/screens/profie_types/profiles.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../service/home_service.dart';

//import '../../notification/navHome.dart';
//import '../notification/navHome.dart';

class ProfileType1 extends StatefulWidget {
  final String types;
  const ProfileType1({super.key, required this.types});

  @override
  State<ProfileType1> createState() => _ReligionState();
}

class _ReligionState extends State<ProfileType1> {
  int value = 0;
  String dropdownvalue = 'Profile View';
  List<dynamic> searchfeture = [];
  TextEditingController controller = TextEditingController();

  List<dynamic> allfeatures = [
    {"name": "Pending Profiles", "value": "blockProfiles"},
    {"name": "Approved Profiles", "value": "blockProfiles"},
    {"name": "Block Profiles", "value": "all"},
    {"name": "Report Profiles", "value": "reportProfilesByUsers"},
    {"name": "Sortlist Profiles", "value": "reportProfilesByUsers"},
    {"name": "Search Profiles", "value": ""},
    {"name": "Save Preference", "value": ""},
    {"name": "Online users", "value": "verifiedProfileApprovedUsers"},
    {"name": "Profile Verified", "value": ""},
    {
      "name": "Free personalized Matchmaking",
      "value": "maximumSendInterestProfiles"
    },
    {"name": "Chat now", "value": "maximumProfileViewer"},
    {"name": "Kundli Match Use Profile", "value": "maximumProfileViewed"},
    {"name": "Download Matrimonial Biodata", "value": ""},
    {"name": "Share Matrimonial Biodata", "value": "usersWithSamePhone"},
    {"name": "Support", "value": ""},
    {"name": "Match Profiles", "value": ""},
    {"name": "Boost profiles", "value": "supportSeekingProfiles"},
    {"name": "Invisible Profile", "value": ""},
    {"name": "Send OTP", "value": ""},
    {"name": "Send Link", "value": ""},
    {"name": "Send notifications profiles", "value": ""},
    {"name": "Share Profiles", "value": ""},
    {"name": "Send Audio Clip profiles", "value": ""},
    {"name": "Delete Profiles", "value": ""},
    {"name": "Logout Profiles", "value": ""},
    {"name": "Login Profiles", "value": ""},
    {"name": "PROFILE COMPLETION/  PERCENTAGE", "value": "delete"},
    {"name": "PROFILE PHOTO", "value": "delete"},
    {"name": "EDIT PROFILES", "value": ""},
    {"name": "ABOUT ME PROFILES", "value": ""},
    {"name": "ABOUT PARTNER PREFERENCE PROFILES", "value": ""},
    {"name": "FEEDBACK PROFILES", "value": ""},
    {"name": "PROFILE VIEWER", "value": ""},
    {"name": "INTEREST SEND USERS ", "value": ""},
    {"name": "ACTIVE USERS ", "value": ""},
    {"name": "NOTIFICATION/ACTIVITIES", "value": ""},
    {"name": "CLICK PROFILES ", "value": ""},
    {"name": "ADMIN SEEN PROFILES ", "value": ""},
    {"name": "ASCREENSHOT TRIED PROFILES", "value": ""},
    {"name": "SCREEN RECORDING TRIED PROFILES", "value": ""},
    {"name": "DELETED PROFILE SAME EMAIL PROFILES", "value": ""},
    {"name": "DELETE PROFILE MOBILE NO. PROFILES", "value": ""},
    {"name": "SAME MOBILE NO. PROFILES", "value": ""},
    {"name": "SINGLE DEVICE MULTIPLE PROFILES", "value": ""},
    {"name": "DIFFER LOCATION PROFILES", "value": ""},
    {"name": "TERMS & CONDITIONS ", "value": ""},
    {"name": "DEVICE NOTIFICATION BLOCKED PROFILES", "value": ""},
    {"name": "SIGN UP BY GMAIL USERS", "value": ""},
    {"name": "SIGN UP BY FACEBOOK USERS", "value": ""},
    {"name": "SIGN UP BY INSTAGRAM USERS", "value": ""},
    {"name": "SIGN UP BY TWITTER USERS", "value": ""},
    {"name": "SIGN UP BY LINKEDIN USERS", "value": ""},
    {"name": "IOS USERS", "value": ""},
    {"name": "ANDROID USERS", "value": ""},
    {"name": "WEB USERS", "value": ""},
    {"name": "DUAL APP DEVICE PROFILES", "value": ""},
    {"name": "DELETE APP PROFILES", "value": ""},
    {"name": "UNINSTALL APP PROFILES ", "value": ""},
    {"name": "INSTALL APP AGAIN PROFILES ", "value": ""},
    {"name": "INSTALL APP & LOGIN APP SAME EMAIL PROFILES ", "value": ""},
    {"name": "TRIED TO SIGN UP EMAILS ", "value": ""},
  ];
  List<NewUserModel> allonlineusers = [];
  var res = [];
  late DatabaseReference _dbref;
  var profiledata;
  int deletetotla = 0;
  getallnumbers() async {
    profiledata = await SearchProfile().getnumberofsearchusers("male");
    deletetotla = await HomeService().getdeletetotaluser();
    setState(() {});
  }

  bool isSearch = false;
  setData() async {
    SharedPref sharedPref = SharedPref();

    // final json2 = await sharedPref.read("uid");
    var json3;
    try {
      json3 = await sharedPref.read("user");
    } catch (e) {
      print(e);
    }

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

  void getuseronlineusers(var gen) async {
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Profiles(
                  searchText: "",
                  title: "Online Profiles",
                )));
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
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (widget.types == "Pending") {
      allfeatures.removeAt(1);
    } else if (widget.types == "Approved") {
      allfeatures.removeAt(0);
    }
    setState(() {});
    getallnumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
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
          // middle: Icon(
          //   Icons.supervised_user_circle_outlined,
          //   // color: ma/
          //   size: 30,
          // ),
          // trailing: Material(
          //   child: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           isSearch = !isSearch;
          //         });
          //       },
          //       icon: const Icon(Icons.search)),
          // ),
          title: isSearch == false
              ? DefaultTextStyle(
                  style: GoogleFonts.poppins(color: main_color, fontSize: 20),
                  child: Text(
                    "${widget.types} Profiles",
                    style: TextStyle(color: main_color),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        searchfeture = allfeatures
                            .where((object) => object["name"]
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
      
        ),
        body: profiledata == null
            ? Center(
                child: CircularProgressIndicator(
                  color: main_color,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: allfeatures.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final numberofusers =
                            profiledata[allfeatures[index]["value"]];
                        return Column(
                          children: [
                            // const Divider(
                            //   thickness: 1,
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    secondProfileType =
                                        allfeatures[index]["name"];
                                    print(allfeatures[index]["name"] ==
                                        "Profile Verified");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailProfileType1(
                                                  profiletypes:
                                                      allfeatures[index]
                                                          ["name"],
                                                  features: allfeatures[index]
                                                              ["name"] ==
                                                          "Pending Profiles"
                                                      ? pendingprofiles
                                                      : allfeatures[index]
                                                                  ["name"] ==
                                                              "Approved Profiles"
                                                          ? approvedprofiles
                                                          : allfeatures[index]
                                                                      [
                                                                      "name"] ==
                                                                  "Block Profiles"
                                                              ? profileBlocks
                                                              : allfeatures[index]
                                                                          [
                                                                          "name"] ==
                                                                      "Report Profiles"
                                                                  ? reportProfiles
                                                                  : allfeatures[index]["name"] ==
                                                                          "Sortlist Profiles"
                                                                      ? shortlistProfiles
                                                                      : allfeatures[index]["name"] ==
                                                                              "Search Profiles"
                                                                          ? searchProfiles
                                                                          : allfeatures[index]["name"] == "Save Preference"
                                                                              ? savePreferences
                                                                              : allfeatures[index]["name"] == "Online users"
                                                                                  ? onlinetypes
                                                                                  : allfeatures[index]["name"] == "Profile Verified"
                                                                                      ? profileverified
                                                                                      : allfeatures[index]["name"] == "Free personalized Matchmaking"
                                                                                          ? matchmakingtypes
                                                                                          : allfeatures[index]["name"] == "Chat now"
                                                                                              ? chatAndCallStats
                                                                                              : allfeatures[index]["name"] == "Kundli Match Use Profile"
                                                                                                  ? downloadBiodataStats
                                                                                                  : allfeatures[index]["name"] == "Download Matrimonial Biodata"
                                                                                                      ? downloadBiodataStats
                                                                                                      : allfeatures[index]["name"] == "Share Matrimonial Biodata"
                                                                                                          ? shareBiodataStats
                                                                                                          : allfeatures[index]["name"] == "Support"
                                                                                                              ? querySendProfilesStats
                                                                                                              : allfeatures[index]["name"] == "Match Profiles"
                                                                                                                  ? matchProfileStats
                                                                                                                  : allfeatures[index]["name"] == "Boost profiles"
                                                                                                                      ? boostProfileStats
                                                                                                                      : [],
                                                )));
                                    SearchProfile().addtoadminnotification(
                                        userid: userSave!.puid!,
                                        useremail: userSave.email!,
                                        userimage: userSave.imageUrls!.isEmpty
                                            ? ""
                                            : userSave.imageUrls![0],
                                        title:
                                            "${userSave.displayName} SEEN DELETE PROFILES BY FILTER",
                                        email: userSave.email!,
                                        subtitle: "");
                                    //Navigator.of(context).pop();
                                  },
                                  //icon: Icon(Icons.home),
                                  child: allfeatures[index]["value"] ==
                                          "delete"
                                      ? Padding(
                                        padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                        child: Text(
                                            "${allfeatures[index]["name"]} ($deletetotla)",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          ),
                                      )
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                        child: Text(
                                            "${allfeatures[index]["name"]} (${numberofusers ?? 0})",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          ),
                                      ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
