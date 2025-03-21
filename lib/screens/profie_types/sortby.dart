import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/common/global.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/new_profile_type.dart';
import 'package:matrimony_admin/screens/profie_types/profiles.dart';
import 'package:matrimony_admin/screens/profie_types/second_profile_types.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../service/home_service.dart';

//import '../../notification/navHome.dart';
//import '../notification/navHome.dart';

class ProfileType extends StatefulWidget {
  const ProfileType({super.key});

  @override
  State<ProfileType> createState() => _ReligionState();
}

class _ReligionState extends State<ProfileType> {
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
      
          title:Text(
              "Profile Types ",
              style: TextStyle(color: main_color, fontSize: 23,fontWeight: FontWeight.bold),
            
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
                   
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            profileType = "All Profiles";
                            //  List<NewUserModel> allprofiles=await HomeService(). getallusers(page: "1");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SecondProfileTypes(
                                          title: "All Profiles",
                                        )));
                          },
                          //icon: Icon(Icons.home),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                            child: Text(
                              "All Profiles  (${profiledata["all"]})",
                              style: const TextStyle(
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
                            profileType = "Male Profiles";
      
                            if (listofadminpermissions!
                                    .contains("Can See male profiles") ||
                                listofadminpermissions!.contains("All")) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SecondProfileTypes(
                                            title: "Male Profiles",
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
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                            child: Text(
                              "Male Profiles (${profiledata["male"]})",
                              style: const TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => SlideProfile(
                            //           user_data: femaleusers,
                            //         )));
                            profileType = "Female Profiles";
      
                            if (listofadminpermissions!
                                    .contains("Can See female profiles") ||
                                listofadminpermissions!.contains("All")) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SecondProfileTypes(
                                            title: "Female Profiles",
                                          )));
                            }
                          },
                          //icon: Icon(Icons.home),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                            child: Text(
                              "Female Profiles (${profiledata["female"]})",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Pending Profiles New male",title: "Pending Profiles New",)));
                    //                           SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN Pending Profiles New SUCCESSFULLY BY FILTER", email: userSave.email!, subtitle: "");
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Pending Profiles New (${profiledata["pending-male"]})" ,
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Approved Profiles New male",title: "Approved Profiles New",)));
                    //                               SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN Approved Profiles New SUCCESSFULLY BY FILTER", email: userSave.email!, subtitle: "");
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Approved Profiles New (${profiledata["pendingprofilenewfemale"]+profiledata["approvedfemale"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Pending Profiles Edit",title: "Pending Profiles Edit",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Pending Profiles Edit (${profiledata["pendingProfilesEdit"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Approved Profiles Edit",title: "Approved Profiles Edit",)));
      
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Approved Profiles Edit (${profiledata["approvedProfilesEdit"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                       getuseronlineusers("male");
                    //                           SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN ONLINE SUCCESSFULLY BY FILTER", email: userSave.email!, subtitle: "");
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Online Profiles",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
      
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        getuseronlineusers("female");
                    //                            SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN ONLINE SUCCESSFULLY BY FILTER", email: userSave.email!, subtitle: "");
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Online Profiles",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Offline Profiles",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                         Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Incomplete Profiles",title: "Incomplete Profiles",)));
      
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Incomplete Profiles (${profiledata["incompleteprofile"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Complete Profiles",title: "Complete Profiles",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Complete Profiles (${profiledata["completeprofile"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Profiles with photos",title: "Profiles with photos",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Profiles with photos (${profiledata["profilewithphoto"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Profiles without photos",title: "Profiles without photos",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Profiles without photos (${profiledata["profilewithoutphoto"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Logout Profiles by Users",title: "Logout Profiles by Users",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Logout Profiles by Users (${profiledata["logoutProfilesByUsers"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Logout Profiles by Users",title: "Logout Profiles by Admin",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Logout Profiles by Admin",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                         Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "About Me Blank Profiles",title: "About Me Blank Profiles",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "About Me Blank Profiles (${profiledata["all"]-profiledata["aboutMeFillProfile"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                         Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "About Me Fill Profiles",title: "About Me Fill Profiles",)));
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "About Me Fill Profiles (${profiledata["aboutMeFillProfile"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                        Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Login Profiles",title: "Login Profiles",)));
                    //                       //Navigator.of(context).pop();
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Login Profiles (${profiledata["loginProfiles"]})",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 thickness: 1,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 15,
                    //                   ),
                    //                   TextButton(
                    //                     onPressed: () {
                    //                       //Navigator.of(context).pop();
                    //                    Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: "Delete",title: "Delete Profiles by Admin",)));
                    //                               SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN DELETE PROFILE BY FILTER", email: userSave.email!, subtitle: "");
                    //                     },
                    //                     //icon: Icon(Icons.home),
                    //                     child: Text(
                    //                       "Delete Profiles by Admin ($deletetotla)",
                    //                       style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontWeight: FontWeight.normal,
                    //                           fontSize: 18),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               ListView.builder(
                    //                 shrinkWrap: true,
                    //                 itemCount: allfeatures.length,
                    //                 physics: NeverScrollableScrollPhysics(),
                    //                 itemBuilder: (context, index) {
                    //                   final numberofusers=profiledata[allfeatures[index]["value"]];
                    //                 return Column(
                    //                   children: [
                    //                      Divider(
                    //                 thickness: 1,
                    //               ),
                    //                     Row(
                    //                                     children: [
                    //                     SizedBox(
                    //                       width: 15,
                    //                     ),
                    //                     TextButton(
                    //                       onPressed: () {
                    //                          Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) => Profiles(searchText: allfeatures[index]["value"],title: allfeatures[index]["name"],)));
                    //                               SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
                    // title: "${userSave.displayName} SEEN DELETE PROFILES BY FILTER", email: userSave.email!, subtitle: "");
                    //                         //Navigator.of(context).pop();
                    //                       },
                    //                       //icon: Icon(Icons.home),
                    //                       child:allfeatures[index]["value"]=="delete"?Text(
                    //                         "${allfeatures[index]["name"]} ($deletetotla)",
                    //                         style: TextStyle(
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.normal,
                    //                             fontSize: 18),
                    //                       ): Text(
                    //                         "${allfeatures[index]["name"]} (${numberofusers ?? 0})",
                    //                         style: TextStyle(
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.normal,
                    //                             fontSize: 18),
                    //                       ),
                    //                     ),
                    //                                     ],
                    //                                   ),
                    //                                    Divider(
                    //                 thickness: 1,
                    //               ),
                    //                   ],
                    //                 );
                    //               },)
                  ],
                ),
              ),
      ),
    );
  }
}
