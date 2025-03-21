import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';
import 'package:matrimony_admin/screens/profie_types/main_profile_types.dart';
import 'package:matrimony_admin/screens/profie_types/profiles.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../globalVars.dart';
import '../service/home_service.dart';

//import '../../notification/navHome.dart';
//import '../notification/navHome.dart';

class DetailProfileType1 extends StatefulWidget {
  final String profiletypes;
  final List<dynamic>? features;
  const DetailProfileType1(
      {Key? key, required this.profiletypes, this.features})
      : super(key: key);

  @override
  State<DetailProfileType1> createState() => _ReligionState();
}

class _ReligionState extends State<DetailProfileType1> {
  int value = 0;
  String dropdownvalue = 'Profile View';
  List<dynamic> searchfeture = [];
  TextEditingController controller = TextEditingController();

  List<dynamic> allfeatures = [
    {"name": "Pending Profiles", "value": "blockProfiles"},
    {"name": "Approved Profiles ", "value": "blockProfiles"},
    {"name": "Block Profiles", "value": "all"},
    {"name": "Report Profiles", "value": "reportProfilesByUsers"},
    {"name": "Search Profiles", "value": "reportProfilesByUsers"},
    {"name": "Save Preference", "value": ""},
    {"name": "Online users", "value": "verifiedProfileApprovedUsers"},
    {"name": "Profile verified ", "value": ""},
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
    getallnumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
            // middle: Icon(
            //   Icons.supervised_user_circle_outlined,
            //   // color: ma/
            //   size: 30,
            // ),
            trailing: Material(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: const Icon(Icons.search)),
            ),
            middle: isSearch == false
                ? Text.rich(
                    TextSpan(style: const TextStyle(fontSize: 20), children: [
                    const TextSpan(
                        text: "Free",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: "Showg")),
                    TextSpan(
                        text: "rishteywala",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: main_color,
                            fontFamily: "Showg")),
                    // TextSpan(
                    //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
                  ]))
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
            previousPageTitle: "",
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      widget.features != null || widget.features!.isNotEmpty
                          ? widget.features!.length
                          : allfeatures.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data =
                        widget.features != null || widget.features!.isNotEmpty
                            ? widget.features![index]!
                            : allfeatures[index];

                    return Column(
                      children: [
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                thirdProfileType = data['name'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainProfilesTypes()));
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    "${data['name']}  (${(data['value'] == null || data['value'] == "") ? "0" : data['value']})",
                                    // "${data['name']} (${data['value'] != "" ? data['value'] : "0"})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
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
      ),
    );
  }
}
