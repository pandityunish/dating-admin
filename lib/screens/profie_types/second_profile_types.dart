import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/new_profile_type.dart';
import 'package:matrimony_admin/screens/profie_types/profiles.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../service/home_service.dart';

//import '../../notification/navHome.dart';
//import '../notification/navHome.dart';

class SecondProfileTypes extends StatefulWidget {
  final String title;
  const SecondProfileTypes({super.key, required this.title});

  @override
  State<SecondProfileTypes> createState() => _ReligionState();
}

class _ReligionState extends State<SecondProfileTypes> {
  int value = 0;
  String dropdownvalue = 'Profile View';
  List<dynamic> searchfeture = [];
  TextEditingController controller = TextEditingController();

  List<dynamic> allfeatures = [
    {"name": "Block Profiles", "value": "blockProfiles"},
    {"name": "Block Profiles by admin", "value": "blockProfiles"},
    {"name": "Unblock by admin", "value": "all"},
    {"name": "Report Profiles by users", "value": "reportProfilesByUsers"},
    {"name": "Report Profiles by admin", "value": "reportProfilesByUsers"},
    {"name": "Sortlisted profile", "value": ""},
    {
      "name": "verified profile approved users",
      "value": "verifiedProfileApprovedUsers"
    },
    {"name": "verified profile declined users", "value": ""},
    {
      "name": "maximum send interest Profiles",
      "value": "maximumSendInterestProfiles"
    },
    {"name": "maximum profile viewer", "value": "maximumProfileViewer"},
    {"name": "maximum profile viewed", "value": "maximumProfileViewed"},
    {"name": "delete profile mobile no. profiles", "value": ""},
    {"name": "Same Mobile No. Profiles", "value": "usersWithSamePhone"},
    {"name": "screenshot try profiles", "value": ""},
    {"name": "screen recording  try profiles", "value": ""},
    {"name": "support seeking profiles", "value": "supportSeekingProfiles"},
    {"name": "audio call by admin", "value": ""},
    {"name": "video call by admin", "value": ""},
    {"name": "conference audio call done profiles", "value": ""},
    {"name": "notifications blocked profiles", "value": ""},
    {"name": "authentication pending profiles", "value": ""},
    {"name": "authentication success profiles", "value": ""},
    {"name": "authentication failed profiles", "value": ""},
    {"name": "differ location profiles", "value": ""},
    {"name": "change location profiles", "value": ""},
    {"name": "delete Profiles by users", "value": "delete"},
    {"name": "delete Profiles by admin", "value": "delete"},
    {"name": "recover profile by admin", "value": ""},
    {"name": "Terms & Conditions Read Profiles", "value": ""},
    {"name": "delete app Profiles", "value": ""},
    {"name": "Saved Preference  Profiles", "value": ""},
    {"name": "Pending Preference Profiles", "value": ""},
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
      
          title: isSearch == false
              ? Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Sans-serif',
                    color: main_color,
                    fontWeight: FontWeight.bold,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      newProfileType = "All Profiles";
                      //  List<NewUserModel> allprofiles=await HomeService(). getallusers(page: "1");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileType1(
                                    types: "All",
                                  )));
                    },
                    //icon: Icon(Icons.home),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: const Text(
                        "All Profiles",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      newProfileType = "Pending Profiles";
      
                      if (listofadminpermissions!
                              .contains("Can See male profiles") ||
                          listofadminpermissions!.contains("All")) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileType1(
                                      types: "Pending",
                                    )));
                        SearchProfile().addtoadminnotification(
                            userid: userSave!.puid!,
                            useremail: userSave.email!,
                            userimage: userSave.imageUrls!.isEmpty
                                ? ""
                                : userSave.imageUrls![0],
                            title:
                                "${userSave.displayName} SEEN MALE PROFILE SUCCESSFULLY BY FILTER",
                            email: userSave.email!,
                            subtitle: "");
                      }
                    },
                    //icon: Icon(Icons.home),
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: const Text(
                        "Pending Profiles ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      newProfileType = "Approved Profiles";
      
                      if (listofadminpermissions!
                              .contains("Can See female profiles") ||
                          listofadminpermissions!.contains("All")) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileType1(
                                      types: "Approved",
                                    )));
                      }
                    },
                    //icon: Icon(Icons.home),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: const Text(
                        "Approved Profiles ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
