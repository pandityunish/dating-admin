import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/screens/profie_types/create_admin_service.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../service/search_profile.dart';

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({super.key});

  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  final name = TextEditingController();
  final useremail = TextEditingController();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
 List<String> features = [
    "All Access (Can Create Sub Admin)",
    "All Access (Can’t create sub admin)",
    "Can See Main Admin Activities",
    "Can See All Admin activities",
    "Can See Sub Admin profiles",
    "Can Send Notifications",
    "Can Upload Success Stories",
    "Can Change Advetisements",
    "Can Download excel/PDF",
    "Can See user's full name",
    "Can See mobile number",
    "Can See email ID",
    "Can See male profiles",
    "Can See female profiles",
    "Can approve profiles",
    "Can block profiles",
    "Can unblock profiles",
    "Can shortlist profiles",
    "Can delete notifications",
    "Can See user activities",
    "Can search profiles",
    "Can See complete profiles",
    "Can See incomplete profiles",
    "Can match profiles",
    "Can share/send profiles",
    "Can audio call to users",
    "Can video call to users",
    "Can make conference call",
    "Can listen audio call recording",
    "Can See video call recording",
    "Can See conference call recording",
    "Can boost profile",
    "Can send OTP",
    "Can share profile",
    "Can invisible profile",
    "Can show advertisements",
    "Can See left menu",
    "Can See right menu",
    "Can See Pending Profiles",
    "Can See Approved Profiles",
    "Can't do anything"
  ];
  List<String> matchmakinglist = [
    "Can Receive Audio Call (Matchmaker)",
    "Can Receive Video Call (Matchmaker)",
    "Can Receive Audio Call (Astrologer)",
    "Can Receive Video Call (Astrologer)",
  ];
  List<dynamic> selectedFeatures = [];
  List<String> filteritems = [
    "Manage Admins",
    "Manage Advertisement",
    "Manage Bubble Pictures",
    "Manage Charts",
    "Can See Total Users",
  ];
  List<String> notificationitems = [
    "Can see main admin activities",
    "Can see sub admin activities",
    "Can see user activities"
  ];
  List<String> leftmenuitem = [
    "Can See Full Name",
    "Can See Number of Use Features",
    "Can Search Profile",
    "Can Saved Preference",
    "Can Verify Profile",
 
 
    "Can See Online Users",
    "Can See Free Kundli Match",
    "Can Download Matrimonial Biodata",
    "Can Share App",
    "Can See Support",
    "Can See Match Profile",
    "Can Show Advertisement",
    "Can Boost Profile",
    "Can Invisible Profile",
    "Can Send OTP",
    "Can Send Link",
    "Can Send Notification",
    "Can Send Audio Clip",
    "Can Logout Profile",
    "Can Delete Profile",
  ];
  List<String> canedititem = [
    "Can See Full Name",
    "Can See Email ID",

    "Can See Phone No.",
    "Can See Edit Pic",
    "Can See Phone No.",
    "Can See Locked Pic",
    "Can See Unlocked Pic",
    "Can Edit About Me",
    "Can Edit Patner Preference",
  ];
  List<String> profileviews = [
    "Can See Pending Profile",
    "Can See Full View Pics",
    "Can See More-1",
    "Can See More-2",
    "Can Approve Profile",
    "Can Block Profile",
    "Can Unblock Profile",
    "Can Report Profile",
    "Can Unreport Profile",
    "Can Shortlist Profile",
    "Can Unshortlist Profile"
  ];
  List<String> seechatsitem = [
    "Can See Chat",
    "Can Audio Call To User (Matchmaker)",
    "Can Video Call To User (Matchmaker)",
    "Can Group Audio Call To User (Matchmaker)",
    "Can Group Video Call To User (Matchmaker)",
  "Can Audio Call To User (Astrologer)",
    "Can Video Call To User (Astrologer)",
   
  ];
  List<String> manageprofiletypes = [
   " CAN SEE PROFILE TYPES ",
"CAN SEE MANAGE ADMIN ",
"CAN SEE MANAGE ADVERTISEMENT",
"CAN SEE MANAGE BUBBLE PICS",
"CAN SEE CHARTS",
"CAN SEE TOTAL USERS",
"CAN SEE ADMIN SEARCH BAR",
"CAN CREATE PROFILE",
"CAN SEE SORT BY ",
"CAN SEE PROFILE VIEW BULK",
"CAN DOWNLOAD EXCEL BULK",
"CAN DOWNLOAD BIODATA BULK",
"CAN SEND OTP BULK",
"CAN SEND LINK BULK",
"CAN SEND NOTIFICATION BULK",
"CAN SEND AUDIO CLIP BULK ",
  ];
  List<String> gender = [
    "Can See Male Profiles",
    "Can See Female Profiles",
  ];
  void selectvalue(int index, List<String> items) {
    setState(() {
      if (selectedFeatures.contains(items[index])) {
        selectedFeatures.remove(items[index]);
      } else if (selectedFeatures.contains("All Access")) {
        selectedFeatures.remove("All Access");
        selectedFeatures.add(items[index]);
      } else if (selectedFeatures.contains("No Access")) {
        selectedFeatures.remove("No Access");
        selectedFeatures.add(items[index]);
      } else {
        selectedFeatures.add(items[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
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
      
          middle: Row(
            children: [
              BigText(
                text: "Create Admin",
                size: 20,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
      
          // TextSpan(
          //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
      
          previousPageTitle: "",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                         Container(
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        // height: 50,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: CupertinoTextField(
                            cursorColor: main_color,
                            // height: 20.0,
                            maxLength: 15,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")), // Allow only alphabets
                            ],
                            maxLengthEnforcement: MaxLengthEnforcement
                                .enforced, // show error message
                            // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                            placeholder: "Admin Name",
                            focusNode: _focusNode1,
                            controller: name,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _focusNode1.hasFocus
                                    ? main_color
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        // height: 50,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: CupertinoTextField(
                            cursorColor: main_color,
                            // height: 20.0,
                            maxLength: 100,
                  
                            maxLengthEnforcement: MaxLengthEnforcement
                                .enforced, // show error message
                            // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                            placeholder: "Admin Email",
                            focusNode: _focusNode2,
                            controller: useremail,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _focusNode2.hasFocus
                                    ? main_color
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: (name) => {},
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: InkWell(
                            onTap: () {
                              if (selectedFeatures.contains("All Access")) {
                                selectedFeatures.remove("All Access");
                              } else if (selectedFeatures.isNotEmpty) {
                                selectedFeatures.clear();
                                selectedFeatures.add("All Access");
                              } else {
                                selectedFeatures.add("All Access");
                              }
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "All Access",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                selectedFeatures.contains("All Access")
                                    ? Icon(
                                        Icons.done,
                                        color: main_color,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                     ExpansionTile(
                                    iconColor: main_color,
                                    title: Text(
                                      "Manage Access",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                    textColor: main_color,
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     Divider(
                                      //       thickness: 1,
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 7),
                                      //       child: InkWell(
                                      //         onTap: () {
                                      //           selectvalue(
                                      //               0, ["Can See Full Name"]);
                                      //         },
                                      //         child: Row(
                                      //           children: [
                                      //             SizedBox(
                                      //               width: 15,
                                      //             ),
                                      //             Text(
                                      //               "Can See Full Name",
                                      //               style: TextStyle(
                                      //                   color: Colors.black,
                                      //                   fontWeight:
                                      //                       FontWeight.normal,
                                      //                   fontSize: 18),
                                      //             ),
                                      //             selectedFeatures.contains(
                                      //                     "Can See Full Name")
                                      //                 ? Icon(
                                      //                     Icons.done,
                                      //                     color: main_color,
                                      //                   )
                                      //                 : Container()
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Divider(
                                      //       thickness: 1,
                                      //     ),
                                      //   ],
                                      // ),
                                      ExpansionTile(
                                        title: Text("Gender",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                        
                                        ),
                                        children: [
                                          ListView.builder(
                                            itemCount: gender.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectvalue(
                                                            index, gender);
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            gender[index],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14),
                                                          ),
                                                          selectedFeatures
                                                                  .contains(
                                                                      gender[
                                                                          index])
                                                              ? Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      main_color,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: Text("Profile View",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                        
                                        ),
                                        textColor: main_color,
                                        iconColor: main_color,
                                        children: [
                                          ListView.builder(
                                            itemCount: profileviews.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectvalue(
                                                            index, profileviews);
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            profileviews[index],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14),
                                                          ),
                                                          selectedFeatures
                                                                  .contains(
                                                                      profileviews[
                                                                          index])
                                                              ? Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      main_color,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: Text("Can See Left Menu",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                        
                                        ),
                                        textColor: main_color,
                                        iconColor: main_color,
                                        children: [
                                          ListView.builder(
                                            itemCount: leftmenuitem.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets
                                                .zero, // Added this line to remove any padding
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectvalue(
                                                            index, leftmenuitem);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            leftmenuitem[index],
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          selectedFeatures
                                                                  .contains(
                                                                      leftmenuitem[
                                                                          index])
                                                              ? Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      main_color,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          ExpansionTile(
                                            title: Text(
                                                "Can See Free Personalised Matchmaking",style: TextStyle(fontWeight: FontWeight.bold),),
                                            textColor: main_color,
                                            iconColor: main_color,
                                            children: [
                                              ListView.builder(
                                                itemCount: matchmakinglist.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets
                                                    .zero, // Added this line to remove any padding
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 7),
                                                        child: InkWell(
                                                          onTap: () {
                                                            selectvalue(index,
                                                                matchmakinglist);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                matchmakinglist[
                                                                    index],
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              selectedFeatures.contains(
                                                                      seechatsitem[
                                                                          index])
                                                                  ? Icon(
                                                                      Icons.done,
                                                                      color:
                                                                          main_color,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          ExpansionTile(
                                            title: const Text("Can See Chat",style: TextStyle(fontWeight: FontWeight.bold),),
                                            textColor: main_color,
                                            iconColor: main_color,
                                            children: [
                                              ListView.builder(
                                                itemCount: seechatsitem.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets
                                                    .zero, // Added this line to remove any padding
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 7),
                                                        child: InkWell(
                                                          onTap: () {
                                                            selectvalue(index,
                                                                seechatsitem);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                seechatsitem[
                                                                    index],
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              selectedFeatures.contains(
                                                                      seechatsitem[
                                                                          index])
                                                                  ? Icon(
                                                                      Icons.done,
                                                                      color:
                                                                          main_color,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                       
                                        ],
                                      ),
                                          ExpansionTile(
                                            title: Text("Can See Edit Profile",style: TextStyle(fontWeight: FontWeight.bold),),
                                            textColor: main_color,
                                            iconColor: main_color,
                                            children: [
                                              ListView.builder(
                                                itemCount: canedititem.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets
                                                    .zero, // Added this line to remove any padding
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 7),
                                                        child: InkWell(
                                                          onTap: () {
                                                            selectvalue(index,
                                                                canedititem);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                canedititem[
                                                                    index],
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              selectedFeatures.contains(
                                                                      canedititem[
                                                                          index])
                                                                  ? Icon(
                                                                      Icons.done,
                                                                      color:
                                                                          main_color,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                         
                                      ExpansionTile(
                                        title: Text("Can See Notification",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                        
                                        ),
                                        textColor: main_color,
                                        iconColor: main_color,
                                        children: [
                                          ListView.builder(
                                            itemCount: notificationitems.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectvalue(index,
                                                            notificationitems);
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            notificationitems[
                                                                index],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14),
                                                          ),
                                                          selectedFeatures.contains(
                                                                  notificationitems[
                                                                      index])
                                                              ? Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      main_color,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    
                                      ExpansionTile(
                                        title: Text("Can See Filter",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                        
                                        ),
                                        textColor: main_color,
                                        iconColor: main_color,
                                        children: [
                                          
                                          ListView.builder(
                                            itemCount: manageprofiletypes.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectvalue(
                                                            index, manageprofiletypes);
                  
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            manageprofiletypes[index],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14),
                                                          ),
                                                          selectedFeatures
                                                                  .contains(
                                                                      manageprofiletypes[
                                                                          index])
                                                              ? Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      main_color,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                     
                                     
                                     
                                      
                                    ],
                                  ),
                    Column(
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: InkWell(
                            onTap: () {
                              if (selectedFeatures.contains("No Access")) {
                                selectedFeatures.remove("No Access");
                              } else if (selectedFeatures.isNotEmpty) {
                                selectedFeatures.clear();
                                selectedFeatures.add("No Access");
                              } else {
                                selectedFeatures.add("No Access");
                              }
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "No Access",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                selectedFeatures.contains("No Access")
                                    ? Icon(
                                        Icons.done,
                                        color: main_color,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
           
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: Get.width ,
                  child: ElevatedButton(
                    onPressed: () async {
                      final regex = RegExp(r".*@gmail.com");
                      bool isgmail = regex.hasMatch(useremail.text);
                      if (useremail.text.isEmpty ||
                          name.text.isEmpty ||
                          selectedFeatures.isEmpty) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SnackBarContent3(
                                    error_text: "Please Enter Data",
                                    appreciation: "",
                                    icon: Icons.done),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                            });
                      } else if (isgmail == false) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SnackBarContent3(
                                    error_text: "Please Enter Valid Gmail",
                                    appreciation: "",
                                    icon: Icons.done),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                            });
                      } else {
                        if (useremail.text.isNotEmpty &&
                            name.text.isNotEmpty &&
                            selectedFeatures.isNotEmpty) {
                          if (selectedFeatures.contains("All Access")) {
                            CreateAdminService().createadmin(
                                email: useremail.text,
                                username: name.text,
                                context: context,
                                permissions: ["All"]);
                          } else if (selectedFeatures
                              .contains("No Access")) {
                            CreateAdminService().createadmin(
                                email: useremail.text,
                                username: name.text,
                                context: context,
                                permissions: []);
                          } else {
                            CreateAdminService().createadmin(
                                email: useremail.text,
                                username: name.text,
                                context: context,
                                permissions: selectedFeatures);
                          }
        
                          SearchProfile().addtoadminnotification(
                              userid: userSave!.puid!,
                              useremail: userSave.email!,
                              userimage: userSave.imageUrls!.isEmpty
                                  ? ""
                                  : userSave.imageUrls![0],
                              title:
                                  "${userSave.displayName} CREATED SUB ADMIN ${name.text} SUCCESSFULLY ",
                              email: userSave.email!,
                              subtitle: "");
                          Navigator.pop(context);
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent3(
                                      error_text:
                                          "Admin Created Successfully",
                                      appreciation: "",
                                      icon: Icons.done),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        }
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                EdgeInsets.symmetric(vertical: 20)),
                        shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                                side: BorderSide(color: Colors.white))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
