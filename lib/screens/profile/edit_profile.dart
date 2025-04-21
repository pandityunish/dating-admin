import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/models/user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/profile/ProfilePage.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Assets/ayushWidget/big_text.dart';
import 'package:matrimony_admin/screens/profile/edit_email.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:ticker_text/ticker_text.dart';

import '../../Assets/Error.dart';
import '../../Assets/ImageDart/images.dart';
import '../../globalVars.dart';
import '../../models/edit_profile_model.dart';
import '../../models/shared_pref.dart';
import '../data_collection/customImg.dart';
import '../service/search_profile.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, required this.userSave});
  NewUserModel userSave;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool savedata = false;
  bool aboutUpdateText = false;
  bool partnerUpdateText = false;
  // User userSave = User();
  TextEditingController aboutmeController = TextEditingController();
  TextEditingController partnerPrefController = TextEditingController();
  String dob = "";
  List<EditProfileModel> editdata = [];
  void geteditprofiledata() async {
    List<EditProfileModel> somedata =
        await UserService().geteditprofiles(widget.userSave.email);
    EditProfileModel currentuser = EditProfileModel(
        userid: "123456",
        lng: 2332,
        disability: widget.userSave.Disability,
        puid: widget.userSave.puid,
        religion: widget.userSave.religion,
        name: widget.userSave.name,
        surname: widget.userSave.surname,
        phone: widget.userSave.phone,
        gender: widget.userSave.gender,
        kundalidosh: widget.userSave.KundaliDosh,
        martialstatus: widget.userSave.MartialStatus,
        lat: widget.userSave.lat,
        profession: widget.userSave.Profession,
        timeofbirth: widget.userSave.timeofbirth,
        placeofbirth: widget.userSave.placeofbirth,
        country: widget.userSave.country,
        location1: widget.userSave.Location,
        city: widget.userSave.city,
        state: widget.userSave.state,
        images: widget.userSave.imageurls,
        isBlur: widget.userSave.isBlur!,
        createdAt: "");
    somedata.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    editdata = [currentuser, ...somedata];

    setState(() {});
  }

  initState() {
    super.initState();
    setData();
    geteditprofiledata();
    forIos = widget.userSave.isBlur!;
    setState(() {
      aboutmeController.text = widget.userSave.About_Me == null
          ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
          : widget.userSave.About_Me!;
      partnerPrefController.text = widget.userSave.Partner_Prefs == null
          ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
          : widget.userSave.Partner_Prefs!;
    });
  }

  bool borderColor = false;
  setData() async {
    SharedPref sharedPref = SharedPref();
    var json3;
    try {
      json3 = await sharedPref.read("user");
    } catch (e) {
      print(e);
    }
    setState(() {
      // userSave = widget.userSave ?? User.fromJson(json3);
    });
    DateTime dateofbirth =
        DateTime.fromMillisecondsSinceEpoch(widget.userSave.dob!);
    var dt = dateofbirth!.toString().substring(0, 10).split("-");
    dob = DateFormat('d-MMM-yyyy').format(dateofbirth);
    ImageUrls imageUrls = ImageUrls();
    imageUrls.clear();
    for (var i = 0; i < widget.userSave.imageurls!.length; i++) {
      setState(() {
        imageUrls.add(imageurl: widget.userSave.imageurls[i]);
      });
    }
  }

  sliderContiner(String image, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage(image),
                color: main_color,
              ),
              Container(
                  margin: EdgeInsets.only(left: 5),
                  child: BigText(text: title)),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: TickerText(
              // default values
              scrollDirection: Axis.horizontal,
              speed: 20,
              startPauseDuration: const Duration(seconds: 1),
              endPauseDuration: const Duration(seconds: 1),
              returnDuration: const Duration(milliseconds: 800),
              primaryCurve: Curves.linear,
              returnCurve: Curves.easeOut,
              child: Text(
                subtitle,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 5),
          //   child: Container(
          //     width:
          //         MediaQuery.of(context).size.width * 0.4,
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       reverse: true,
          //       child: Text(
          //         "${userSave.placeofbirth}",
          //         textAlign: TextAlign.end,
          //         style: TextStyle(fontSize: 15),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  nameContainer(icon, String head, String body) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  AssetImage(icon),
                  size: 18,
                  color: main_color,
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: BigText(text: head)),
              ],
            ),
            GestureDetector(
                onTap: () {},
                child: BigText(
                  text: '$body',
                  size: 15,
                )),
          ],
        )
      ]),
    );
  }

  nameContaineblue(icon, String head, String body) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  AssetImage(icon),
                  size: 18,
                  color: main_color,
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: BigText(text: head)),
              ],
            ),
            GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: body)).then((value) {
                    //only if ->
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Copied successfully")));
                  });
                },
                child: BigText(
                  text: '$body',
                  color: main_color,
                  size: 15,
                )),
          ],
        )
      ]),
    );
  }

  emailContainer(icon, String head, String body, Function callback) {
    return InkWell(
      onTap: callback as Function(),
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        margin: EdgeInsets.only(bottom: 5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage(icon),
                    size: 18,
                    color: main_color,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: BigText(text: head)),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: body))
                          .then((value) {
                        //only if ->
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Copied successfully")));
                      });
                    },
                    child: BigText(
                      text: '$body',
                      color: main_color,
                      size: 15,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  bool forIos = false;
  @override
  Widget build(BuildContext context) {
    final imageurls = ImageUrls();

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: editdata == null || editdata.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35, bottom: 15),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                List<dynamic> images = imageurls.value
                                    .map((str) => str as dynamic)
                                    .toList();
                                Navigator.of(context)
                                    .pop(images.isNotEmpty ? images[0] : null);
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: 35,
                                color: main_color,
                              ),
                            ),
                            BigText(
                              text: "Edit Profile",
                              size: 20,
                              color: main_color,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Manage Your Profile",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: BigText(
                                    text:
                                        "Your Changes May Take 72 Hours To Visible",
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Hide Pics"),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10)
                                      .copyWith(right: 20),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    height: 35,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: CupertinoSwitch(
                                      // overrides the default green color of the track
                                      activeColor: Colors.white,
                                      // color of the round icon, which moves from right to left
                                      thumbColor:
                                          forIos ? main_color : Colors.black12,
                                      // when the switch is off
                                      trackColor: forIos
                                          ? Colors.white
                                          : Colors.black12,
                                      // boolean variable value
                                      value: forIos,
                                      // changes the state of the switch
                                      onChanged: (value) {
                                        setState(() {
                                          forIos = value;
                                        });
                                        HomeService().updateblur(
                                            email: widget.userSave.email,
                                            isblur: value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: ImageUrls(),
                                  builder: (BuildContext context, dynamic value,
                                      Widget? child) {
                                    final urls = value as List<String>;
                                    var imageCount = imageurls.length;
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            (imageCount > 0)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 0),
                                                    num: 0)
                                                : CustomImageContainer(
                                                    num: 0,
                                                    isBlur: forIos,
                                                  ),
                                            (imageCount > 1)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 1),
                                                    num: 1)
                                                : CustomImageContainer(
                                                    num: 1,
                                                    isBlur: forIos,
                                                  ),
                                            (imageCount > 2)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 2),
                                                    num: 2)
                                                : CustomImageContainer(
                                                    num: 2,
                                                    isBlur: forIos,
                                                  ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            (imageCount > 3)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 3),
                                                    num: 3)
                                                : CustomImageContainer(
                                                    isBlur: forIos,
                                                    num: 3,
                                                  ),
                                            (imageCount > 4)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 4),
                                                    num: 4)
                                                : CustomImageContainer(
                                                    num: 4,
                                                    isBlur: forIos,
                                                  ),
                                            (imageCount > 5)
                                                ? CustomImageContainer(
                                                    isBlur: forIos,
                                                    imageUrl: imageurls
                                                        .imageUrl(atIndex: 5),
                                                    num: 5)
                                                : CustomImageContainer(
                                                    num: 5,
                                                    isBlur: forIos,
                                                  ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 30, bottom: 15),
                                    child: BigText(
                                      text: "About Me",
                                      size: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("clicked");
                                  setState(() {
                                    aboutUpdateText = true;
                                  });
                                },
                                child: Container(
                                    // width: 300,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(blurRadius: 0.05)
                                        ]),
                                    margin: EdgeInsets.only(
                                      left: 28,
                                      right: 28,
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 7, right: 5, top: 7, bottom: 7),
                                    child: (aboutUpdateText != true)
                                        ? ExpandableText(
                                            (widget.userSave.About_Me == null ||
                                                    widget.userSave.About_Me ==
                                                        "")
                                                ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                                : widget.userSave.About_Me!,
                                            collapseText: 'Less',
                                            linkColor: main_color,
                                            expandText: 'More',
                                            maxLines: 1,
                                          )
                                        : TextField(
                                            controller: aboutmeController,
                                            minLines: 3,
                                            maxLength: 300,
                                            maxLines: 5,
                                            // maxLengthEnforcement: MaxLengthEnforcement
                                            //     .enforced, // show error message
                                            // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',maxLines: 5,
                                            style: TextStyle(
                                                fontFamily: 'Sans-serif',
                                                fontSize: 17),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: 0.0),
                                              // border: OutlineInputBorder(),
                                              hintText: '',
                                            ),
                                          )),
                              ),
                            ]),
                          ),
                          Container(
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 30, bottom: 15),
                                    child: BigText(
                                      text: "My Preference",
                                      size: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // partnerPrefUpdate();
                                  setState(() {
                                    partnerUpdateText = true;
                                  });
                                },
                                child: Container(
                                  // width: 310,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 0.05)]
                                      // color: Color(0xFFFFE9E6).withOpacity(0.25)
                                      ),
                                  margin: EdgeInsets.only(
                                    left: 28,
                                    right: 28,
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 7, right: 7, top: 7, bottom: 7),
                                  child: (partnerUpdateText != true)
                                      ? ExpandableText(
                                          (widget.userSave.Partner_Prefs ==
                                                      null ||
                                                  widget.userSave
                                                          .Partner_Prefs ==
                                                      "")
                                              ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                              : widget.userSave.Partner_Prefs!,
                                          collapseText: 'Less',
                                          linkColor: main_color,
                                          expandText: 'More',
                                          maxLines: 1,
                                        )
                                      : TextField(
                                          controller: partnerPrefController,
                                          maxLength: 300,
                                          minLines: 3,
                                          maxLines: 5,
                                          style: TextStyle(
                                              fontFamily: 'Sans-serif',
                                              fontSize: 17),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(top: 0.0),
                                            hintText: 'Partner Prefs',
                                          ),
                                        ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 15),
                                  child: BigText(
                                    text: "Personal Details",
                                    size: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SingleChildScrollView(
                          // child:
                          Column(
                            children: [
                              nameContainer('images/icons/latitude.png',
                                  "Latitude", "${widget.userSave.adminlng}"),
                              const SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/latitude.png',
                                  "Longitude", "${widget.userSave.adminlat}"),
                              const SizedBox(
                                height: 2,
                              ),
                              // nameContainer('images/icons/name.png', "City",
                              //     "${widget.userSave.city}"),
                              sliderContiner("images/icons/location.png",
                                  "L&L city", "${widget.userSave.city},"),
                              const SizedBox(
                                height: 2,
                              ),
                              listofadminpermissions!.contains(
                                          "Can See user’s full name") ||
                                      listofadminpermissions!.contains("All")
                                  ? nameContaineblue(
                                      'images/icons/name.png',
                                      "Name",
                                      "${widget.userSave.name[0].toUpperCase() + widget.userSave.name!.substring(1)} ${widget.userSave.surname![0].toUpperCase() + widget.userSave.surname!.substring(1)}")
                                  : nameContaineblue(
                                      'images/icons/name.png',
                                      "Name",
                                      "${widget.userSave.name[0]} ${widget.userSave.surname}"),
                              const SizedBox(
                                height: 2,
                              ),
                              listofadminpermissions!
                                          .contains("Can See email ID") ||
                                      listofadminpermissions!.contains("All")
                                  ? emailContainer(
                                      'images/icons/email.png',
                                      "Email",
                                      "${widget.userSave.email}",
                                      () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditEmail(
                                                    email:
                                                        widget.userSave.email,
                                                  ),
                                                ))
                                          })
                                  : Container(),
                              const SizedBox(
                                height: 2,
                              ),
                              listofadminpermissions!
                                          .contains("Can See mobile number") ||
                                      listofadminpermissions!.contains("All")
                                  ? nameContainer('images/icons/name.png',
                                      "Phone No.", "${widget.userSave.phone}")
                                  : Container(),
                              const SizedBox(
                                height: 2,
                              ),
                              // nameContainer('images/icons/contact.png', "Contact No",
                              //     "${widget.userSave.phone}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/calender.png',
                                  "Date of Birth", dob),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer(
                                  'images/icons/calender.png',
                                  "Time of Birth",
                                  widget.userSave.timeofbirth!),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                              'images/icons/location.png'),
                                          color: main_color,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: BigText(
                                                text: "Place of birth")),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          child: Text(
                                            "${widget.userSave.placeofbirth}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/gender.png', "Gender",
                                  "${widget.userSave.gender}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/religion.png',
                                  "Religion", "${widget.userSave.religion}"),
                              SizedBox(
                                height: 2,
                              ),
                              (widget.userSave.religion == "Hindu")
                                  ? nameContainer(
                                      'images/icons/kundli.png',
                                      "KundliDosh",
                                      "${widget.userSave.KundaliDosh}")
                                  : Container(),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer(
                                  'images/icons/marital_status.png',
                                  "Marital Status",
                                  "${widget.userSave.MartialStatus}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/food.png', "Diet",
                                  "${widget.userSave.Diet}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/drink.png', "Drink",
                                  "${widget.userSave.Drink}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/smoke.png', "Smoke",
                                  "${widget.userSave.Smoke}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer(
                                  'images/icons/disability.png',
                                  "Disability With Person",
                                  "${widget.userSave.Disability}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/height.png', "Height",
                                  "${widget.userSave.Height}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/education.png',
                                  "Education", "${widget.userSave.Education}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer(
                                  'images/icons/profession_suitcase.png',
                                  "Profession",
                                  "${widget.userSave.Profession}"),
                              SizedBox(
                                height: 2,
                              ),
                              nameContainer('images/icons/hand_rupee.png',
                                  "Income", "${widget.userSave.Income}"),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ImageIcon(
                                            AssetImage(
                                                'images/icons/location.png'),
                                            color: main_color,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: BigText(text: "Address")),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            "${widget.userSave.Location},${widget.userSave.state},${widget.userSave.country}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                              )
                            ],
                          ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop;
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 300,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shadowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.black),
                                      // padding:
                                      //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                      //         EdgeInsets.symmetric(vertical: 17)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              side: BorderSide(
                                                color: borderColor
                                                    ? main_color
                                                    : Colors.white,
                                              ))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: (savedata)
                                          ? main_color
                                          : Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    // print(imageurls.value);
                                    saveData(imageurls.value
                                        .map((str) => str as dynamic)
                                        .toList());
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: editdata.length,
                  onPageChanged: (index) {
                    ImageUrls1().clear();

                    var imageCount = editdata[index].images.length;
                    if (imageCount >= 1) {
                      ImageUrls1().clear();
                      for (var i = 0; i < editdata[index].images.length; i++) {
                        ImageUrls1().add(imageurl: editdata[index].images[i]);
                      }
                    } else {
                      ImageUrls1().clear();
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    String somedate = editdata[index].dateofbirth == null ||
                            editdata[index].dateofbirth == ""
                        ? widget.userSave.dob.toString()
                        : editdata[index].dateofbirth!;
                    DateTime dateofbirth = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(somedate));
                    String dateofbirthofuser =
                        DateFormat('d-MMM-yyyy').format(dateofbirth);
                    // print(editdata[index].images);
                    if (editdata[index].userid == "123456") {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 35, bottom: 15),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: 35,
                                      color: main_color,
                                    ),
                                  ),
                                  BigText(
                                    text: "Edit Profile",
                                    size: 20,
                                    color: main_color,
                                    fontWeight: FontWeight.w700,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            // alignment: FractionalOffset(0.25, 0.6),
                                            child: Text(
                                              "Manage Your Profile",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 3),
                                            child: BigText(
                                              text:
                                                  "Your Changes May Take 72 Hours To Visible",
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Hide Pics"),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10)
                                                .copyWith(right: 20),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              height: 35,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: CupertinoSwitch(
                                                activeColor: Colors.white,
                                                thumbColor: widget.userSave!
                                                        .imageurls!.isNotEmpty
                                                    ? (forIos
                                                        ? main_color
                                                        : Colors.black12)
                                                    : Colors.grey,
                                                trackColor: widget.userSave!
                                                        .imageurls!.isNotEmpty
                                                    ? (forIos
                                                        ? Colors.white
                                                        : Colors.black12)
                                                    : Colors.grey,
                                                value: widget.userSave!
                                                        .imageurls!.isNotEmpty
                                                    ? forIos
                                                    : false,
                                                onChanged: (value) {
                                                  if (widget.userSave!
                                                      .imageurls!.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Add photos first to hide them")),
                                                    );
                                                    return;
                                                  }

                                                  setState(() {
                                                    forIos = value;
                                                  });

                                                  SearchProfile()
                                                      .addtoadminnotification(
                                                    userid:
                                                        widget.userSave!.id!,
                                                    useremail:
                                                        widget.userSave!.email!,
                                                    userimage: widget.userSave!
                                                            .imageurls!.isEmpty
                                                        ? ""
                                                        : widget.userSave!
                                                            .imageurls![0],
                                                    title:
                                                        "${userSave.displayName} ${value ? "UNLOCKED" : "LOCKED"} "
                                                        "${widget.userSave!.name.substring(0, 1).toUpperCase()} "
                                                        "${widget.userSave!.surname.toLowerCase()} "
                                                        "${widget.userSave!.puid} PROFILE PICTURE",
                                                    email: userSave.email!,
                                                    subtitle: "",
                                                  );

                                                  HomeService().updateblur(
                                                    email:
                                                        widget.userSave!.email,
                                                    isblur: value,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 40),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                            valueListenable: ImageUrls(),
                                            builder: (BuildContext context,
                                                dynamic value, Widget? child) {
                                              final urls =
                                                  value as List<String>;
                                              var imageCount = imageurls.length;

                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      (imageCount > 0)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          0),
                                                              num: 0)
                                                          : CustomImageContainer(
                                                              num: 0,
                                                              isBlur: forIos,
                                                            ),
                                                      (imageCount > 1)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          1),
                                                              num: 1)
                                                          : CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              num: 1,
                                                              isBlur: forIos,
                                                            ),
                                                      (imageCount > 2)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          2),
                                                              num: 2)
                                                          : CustomImageContainer(
                                                              num: 2,
                                                              isBlur: forIos,
                                                            ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      (imageCount > 3)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          3),
                                                              num: 3)
                                                          : CustomImageContainer(
                                                              isBlur: forIos,
                                                              num: 3,
                                                            ),
                                                      (imageCount > 4)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          4),
                                                              num: 4)
                                                          : CustomImageContainer(
                                                              num: 4,
                                                              isBlur: forIos,
                                                            ),
                                                      (imageCount > 5)
                                                          ? CustomImageContainer(
                                                              userSave: widget
                                                                  .userSave,
                                                              isBlur: forIos,
                                                              imageUrl: imageurls
                                                                  .imageUrl(
                                                                      atIndex:
                                                                          5),
                                                              num: 5)
                                                          : CustomImageContainer(
                                                              num: 5,
                                                              isBlur: forIos,
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    editdata.length < 2
                                        ? Center()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: SizedBox(
                                              width: Get.width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      icon: Icon(Icons
                                                          .arrow_forward_ios),
                                                      onPressed: () => {
                                                            _pageController
                                                                .nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .easeInOut,
                                                            )
                                                          }),
                                                ],
                                              ),
                                            ),
                                          ),
                                    Container(
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 30, bottom: 15),
                                              child: BigText(
                                                text: "About Me",
                                                size: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              aboutUpdateText = true;
                                            });
                                          },
                                          child: Container(
                                              // width: 300,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(blurRadius: 0.05)
                                                  ]),
                                              margin: EdgeInsets.only(
                                                left: 28,
                                                right: 28,
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: 7,
                                                  right: 5,
                                                  top: 7,
                                                  bottom: 7),
                                              child: (aboutUpdateText != true)
                                                  ? ExpandableText(
                                                      (widget.userSave.About_Me ==
                                                                  null ||
                                                              widget.userSave
                                                                      .About_Me ==
                                                                  "")
                                                          ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                                          : widget.userSave
                                                              .About_Me!,
                                                      collapseText: 'Less',
                                                      linkColor: main_color,
                                                      expandText: 'More',
                                                      maxLines: 1,
                                                    )
                                                  : TextField(
                                                      controller:
                                                          aboutmeController,
                                                      minLines: 3,
                                                      maxLength: 300,
                                                      maxLines: 5,
                                                      // maxLengthEnforcement: MaxLengthEnforcement
                                                      //     .enforced, // show error message
                                                      // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',maxLines: 5,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Sans-serif',
                                                          fontSize: 17),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0.0),
                                                        // border: OutlineInputBorder(),
                                                        hintText: '',
                                                      ),
                                                    )),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 30, bottom: 15),
                                              child: BigText(
                                                text: "My Preference",
                                                size: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // partnerPrefUpdate();
                                            setState(() {
                                              partnerUpdateText = true;
                                            });
                                          },
                                          child: Container(
                                            // width: 310,
                                            alignment: Alignment.topLeft,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(blurRadius: 0.05)
                                                ]
                                                // color: Color(0xFFFFE9E6).withOpacity(0.25)
                                                ),
                                            margin: EdgeInsets.only(
                                              left: 28,
                                              right: 28,
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 7,
                                                bottom: 7),
                                            child: (partnerUpdateText != true)
                                                ? ExpandableText(
                                                    (widget.userSave.Partner_Prefs ==
                                                                null ||
                                                            widget.userSave
                                                                    .Partner_Prefs ==
                                                                "")
                                                        ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                                        : widget.userSave
                                                            .Partner_Prefs!,
                                                    collapseText: 'Less',
                                                    linkColor: main_color,
                                                    expandText: 'More',
                                                    maxLines: 1,
                                                  )
                                                : TextField(
                                                    controller:
                                                        partnerPrefController,
                                                    maxLength: 300,
                                                    minLines: 3,
                                                    maxLines: 5,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Sans-serif',
                                                        fontSize: 17),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 0.0),
                                                      hintText: 'Partner Prefs',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            child: BigText(
                                              text: "Personal Details",
                                              size: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SingleChildScrollView(
                                    // child:
                                    Column(
                                      children: [
                                        nameContainer(
                                            'images/icons/latitude.png',
                                            "Latitude",
                                            "${widget.userSave.adminlng}"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/latitude.png',
                                            "Longitude",
                                            "${widget.userSave.adminlat}"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        // nameContainer('images/icons/location.png',
                                        //     "L&L city", "${widget.userSave.city}"),
                                        sliderContiner(
                                            "images/icons/location.png",
                                            "L&L city",
                                            "${widget.userSave.city},${widget.userSave.state},${widget.userSave.country}"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        // nameContainer(
                                        //     'images/icons/name.png',
                                        //     "Country",
                                        //     "${widget.userSave.country}"),
                                        // const SizedBox(
                                        //   height: 2,
                                        // ),
                                        // nameContainer(
                                        //     'images/icons/name.png',
                                        //     "State",
                                        //     "${widget.userSave.state}"),
                                        // const SizedBox(
                                        //   height: 2,
                                        // ),
                                        listofadminpermissions!.contains(
                                                    "Can See Full Name") ||
                                                listofadminpermissions!
                                                    .contains("All")
                                            ? nameContainer(
                                                'images/icons/newname.png',
                                                "Name",
                                                "${widget.userSave.name[0].toUpperCase() + widget.userSave.name!.substring(1)} ")
                                            : nameContainer(
                                                'images/icons/newname.png',
                                                "Name",
                                                "${widget.userSave.name[0]} ${widget.userSave.surname}"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        listofadminpermissions!.contains(
                                                    "Can See Full Name") ||
                                                listofadminpermissions!
                                                    .contains("All")
                                            ? nameContainer(
                                                'images/icons/newname.png',
                                                "Surname",
                                                " ${widget.userSave.surname![0].toUpperCase() + widget.userSave.surname!.substring(1)}")
                                            : nameContainer(
                                                'images/icons/newname.png',
                                                "Surname",
                                                "${widget.userSave.surname}"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        listofadminpermissions!.contains(
                                                    "Can See Email") ||
                                                listofadminpermissions!
                                                    .contains("All")
                                            ? emailContainer(
                                                'images/icons/email.png',
                                                "Email ID",
                                                "${widget.userSave.email}",
                                                () => {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditEmail(
                                                              email: widget
                                                                  .userSave
                                                                  .email,
                                                            ),
                                                          ))
                                                    })
                                            : Container(),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        listofadminpermissions!.contains(
                                                    "Can See Phone") ||
                                                listofadminpermissions!
                                                    .contains("All")
                                            ? nameContaineblue(
                                                'images/icons/newcontact.png',
                                                "Contact No.",
                                                "${widget.userSave.phone.substring(0, 3)}-${widget.userSave.phone.substring(3)}")
                                            : Container(),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        // nameContainer('images/icons/contact.png', "Contact No",
                                        //     "${widget.userSave.phone}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer('images/icons/dob.png',
                                            "Date of Birth", dob),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/dob.png',
                                            "Time of Birth",
                                            widget.userSave.timeofbirth!),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        sliderContiner(
                                            "images/icons/location.png",
                                            "Place of birth",
                                            widget.userSave.placeofbirth),

                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/gender.png',
                                            "Gender",
                                            "${widget.userSave.gender}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/religion.png',
                                            "Religion",
                                            "${widget.userSave.religion}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        (widget.userSave.religion == "Hindu")
                                            ? nameContainer(
                                                'images/icons/kundli.png',
                                                "KundliDosh",
                                                "${widget.userSave.KundaliDosh}")
                                            : Container(),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/marital_status.png',
                                            "Marital Status",
                                            "${widget.userSave.MartialStatus}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer('images/icons/food.png',
                                            "Diet", "${widget.userSave.Diet}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/drink.png',
                                            "Drink",
                                            "${widget.userSave.Drink}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/smoke.png',
                                            "Smoke",
                                            "${widget.userSave.Smoke}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/disability.png',
                                            "Disability With Person",
                                            "${widget.userSave.Disability}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/height.png',
                                            "Height",
                                            "${widget.userSave.Height}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/education.png',
                                            "Education",
                                            "${widget.userSave.Education}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/profession_suitcase.png',
                                            "Profession",
                                            "${widget.userSave.Profession}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        nameContainer(
                                            'images/icons/hand_rupee.png',
                                            "Income",
                                            "${widget.userSave.Income}"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        sliderContiner(
                                            "images/icons/location.png",
                                            "Location",
                                            "${widget.userSave.Location},${widget.userSave.state},${widget.userSave.country}"),
                                      ],
                                    ),
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black),
                                                // padding:
                                                //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                //         EdgeInsets.symmetric(vertical: 17)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        side: BorderSide(
                                                          color: borderColor
                                                              ? main_color
                                                              : Colors.white,
                                                        ))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                fontFamily: 'Serif',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: (savedata)
                                                    ? main_color
                                                    : Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              // print(imageurls.value);
                                              saveData(imageurls.value
                                                  .map((str) => str as dynamic)
                                                  .toList());
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 35, bottom: 15),
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 35,
                                    color: main_color,
                                  ),
                                ),
                                BigText(
                                  text: "Edit Profile",
                                  size: 20,
                                  color: main_color,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Manage Your Profile",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      child: BigText(
                                        text:
                                            "Your Changes May Take 72 Hours To Visible",
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Hide Pics"),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10)
                                          .copyWith(right: 20),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        height: 35,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: CupertinoSwitch(
                                          // overrides the default green color of the track
                                          activeColor: Colors.white,
                                          // color of the round icon, which moves from right to left
                                          thumbColor: editdata[index].isBlur
                                              ? main_color
                                              : Colors.black12,
                                          // when the switch is off
                                          trackColor: forIos
                                              ? Colors.white
                                              : Colors.black12,
                                          // boolean variable value
                                          value: editdata[index].isBlur,
                                          // changes the state of the switch
                                          onChanged: (value) {
                                            // setState(() {
                                            //   forIos = value;
                                            // });
                                            // HomeService().updateblur(
                                            //     email: widget.userSave.email,
                                            //     isblur: value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: ImageUrls1(),
                                      builder: (BuildContext context,
                                          dynamic value, Widget? child) {
                                        // final urls = value as List<String>;
                                        var imageCount =
                                            editdata[index].images.length;

                                        //    if(imageCount>=1){
                                        //    ImageUrls1().clear();
                                        //    for (var i = 0; i < editdata[index].images.length; i++) {
                                        //     ImageUrls1().add(imageurl: editdata[index].images[i]);
                                        //  }
                                        // }else{

                                        //   ImageUrls1().clear();
                                        // }

                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                (imageCount > 0)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[0],
                                                        num: 0)
                                                    : CustomImageContainer1(
                                                        num: 0,
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl: "",
                                                      ),
                                                (imageCount > 1)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[1],
                                                        num: 1)
                                                    : CustomImageContainer1(
                                                        num: 1,
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl: "",
                                                      ),
                                                (imageCount > 2)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[2],
                                                        num: 2)
                                                    : CustomImageContainer1(
                                                        num: 2,
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl: "",
                                                      ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                (imageCount > 3)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[3],
                                                        num: 3)
                                                    : CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        num: 3,
                                                      ),
                                                (imageCount > 4)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[4],
                                                        num: 4)
                                                    : CustomImageContainer1(
                                                        num: 4,
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                      ),
                                                (imageCount > 5)
                                                    ? CustomImageContainer1(
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                        imageUrl:
                                                            editdata[index]
                                                                .images[5],
                                                        num: 5)
                                                    : CustomImageContainer1(
                                                        num: 5,
                                                        isBlur: editdata[index]
                                                            .isBlur,
                                                      ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      editdata[index] == 0
                                          ? Center()
                                          : IconButton(
                                              icon: Icon(Icons.arrow_back_ios),
                                              onPressed: () => {
                                                    _pageController
                                                        .previousPage(
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                    )
                                                  }),
                                      IconButton(
                                          icon: Icon(Icons.arrow_forward_ios),
                                          onPressed: () {
                                            if (index == 1) {
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
                                                          "${userSave.name!} SEEN  ${widget.userSave.name!.substring(0, 1)} ${widget.userSave.surname!.toUpperCase()} ${widget.userSave.puid} EDIT PROFILE HISTORY",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                            }
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30, bottom: 15),
                                        child: BigText(
                                          text: "About Me",
                                          size: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("clicked");
                                      setState(() {
                                        aboutUpdateText = true;
                                      });
                                    },
                                    child: Container(
                                        // width: 300,
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(blurRadius: 0.05)
                                            ]),
                                        margin: EdgeInsets.only(
                                          left: 28,
                                          right: 28,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 7,
                                            right: 5,
                                            top: 7,
                                            bottom: 7),
                                        child: (aboutUpdateText != true)
                                            ? ExpandableText(
                                                (editdata[index].aboutme ==
                                                            null ||
                                                        editdata[index]
                                                                .aboutme ==
                                                            "")
                                                    ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                                    : editdata[index].aboutme!,
                                                collapseText: 'Less',
                                                linkColor: main_color,
                                                expandText: 'More',
                                                maxLines: 1,
                                              )
                                            : TextField(
                                                controller: aboutmeController,
                                                minLines: 3,
                                                maxLength: 300,
                                                maxLines: 5,
                                                // maxLengthEnforcement: MaxLengthEnforcement
                                                //     .enforced, // show error message
                                                // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',maxLines: 5,
                                                style: TextStyle(
                                                    fontFamily: 'Sans-serif',
                                                    fontSize: 17),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(top: 0.0),
                                                  // border: OutlineInputBorder(),
                                                  hintText: '',
                                                ),
                                              )),
                                  ),
                                ]),
                              ),
                              Container(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30, bottom: 15),
                                        child: BigText(
                                          text: "My Preference",
                                          size: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // partnerPrefUpdate();
                                      setState(() {
                                        partnerUpdateText = true;
                                      });
                                    },
                                    child: Container(
                                      // width: 310,
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(blurRadius: 0.05)
                                          ]
                                          // color: Color(0xFFFFE9E6).withOpacity(0.25)
                                          ),
                                      margin: EdgeInsets.only(
                                        left: 28,
                                        right: 28,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 7, right: 7, top: 7, bottom: 7),
                                      child: (partnerUpdateText != true)
                                          ? ExpandableText(
                                              (editdata[index].patnerpref ==
                                                          null ||
                                                      editdata[index]
                                                              .patnerpref ==
                                                          "")
                                                  ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                                  : editdata[index].patnerpref!,
                                              collapseText: 'Less',
                                              linkColor: main_color,
                                              expandText: 'More',
                                              maxLines: 1,
                                            )
                                          : TextField(
                                              controller: partnerPrefController,
                                              maxLength: 300,
                                              minLines: 3,
                                              maxLines: 5,
                                              style: TextStyle(
                                                  fontFamily: 'Sans-serif',
                                                  fontSize: 17),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(top: 0.0),
                                                hintText: 'Partner Prefs',
                                              ),
                                            ),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: BigText(
                                        text: "Personal Details",
                                        size: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SingleChildScrollView(
                              // child:
                              Column(
                                children: [
                                  nameContainer('images/icons/latitude.png',
                                      "Latitude", "${editdata[index].lat}"),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/latitude.png',
                                      "Longitude", "${editdata[index].lng}"),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  sliderContiner(
                                      "images/icons/location.png",
                                      "L&L city",
                                      "${editdata[index].city},${editdata[index].state},${editdata[index].country}"),

                                  const SizedBox(
                                    height: 2,
                                  ),

                                  listofadminpermissions!.contains(
                                              "Can See user’s full name") ||
                                          listofadminpermissions!
                                              .contains("All")
                                      ? nameContaineblue(
                                          'images/icons/newname.png',
                                          "Name",
                                          " ${editdata[index].name[0].toUpperCase() + editdata[index].name!.substring(1)} ")
                                      : nameContaineblue(
                                          'images/icons/newname.png',
                                          "Name",
                                          "  ${editdata[index].surname![0].toUpperCase() + editdata[index].surname!.substring(1)}"),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  listofadminpermissions!
                                              .contains("Can See email ID") ||
                                          listofadminpermissions!
                                              .contains("All")
                                      ? emailContainer(
                                          'images/icons/email.png',
                                          "Email IDs",
                                          "${editdata[index].userid}",
                                          () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEmail(
                                                        email: widget
                                                            .userSave.email,
                                                      ),
                                                    ))
                                              })
                                      : Container(),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  listofadminpermissions!.contains(
                                              "Can See mobile number") ||
                                          listofadminpermissions!
                                              .contains("All")
                                      ? nameContaineblue(
                                          'images/icons/phone.png',
                                          "Phone No.",
                                          "${editdata[index].phone.substring(0, 3)}-${editdata[index].phone.substring(3)}")
                                      : Container(),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  // nameContainer('images/icons/contact.png', "Contact No",
                                  //     "${widget.userSave.phone}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/dob.png',
                                      "Date of Birth", dateofbirthofuser),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/dob.png',
                                      "Time of Birth",
                                      editdata[index].timeofbirth!),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  sliderContiner(
                                      "images/icons/location.png",
                                      "Place of birth",
                                      "${editdata[index].placeofbirth}"),

                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/gender.png',
                                      "Gender", "${editdata[index].gender}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/religion.png',
                                      "Religion",
                                      "${editdata[index].religion}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  (editdata[index].religion == "Hindu")
                                      ? nameContainer(
                                          'images/icons/kundli.png',
                                          "KundliDosh",
                                          "${editdata[index].kundalidosh}")
                                      : Container(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/marital_status.png',
                                      "Marital Status",
                                      "${editdata[index].martialstatus}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/food.png', "Diet",
                                      "${editdata[index].diet}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/drink.png',
                                      "Drink", "${editdata[index].drink}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/smoke.png',
                                      "Smoke", "${widget.userSave.Smoke}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/disability.png',
                                      "Disability",
                                      "${editdata[index].disability}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/height.png',
                                      "Height", "${editdata[index].height}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/education.png',
                                      "Education",
                                      "${editdata[index].education}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer(
                                      'images/icons/profession_suitcase.png',
                                      "Profession",
                                      "${editdata[index].profession}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  nameContainer('images/icons/hand_rupee.png',
                                      "Income", "${editdata[index].income}"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  sliderContiner(
                                      'images/icons/location.png',
                                      "Location",
                                      "${editdata[index].location1},${editdata[index].state},${editdata[index].country}"),
                                ],
                              ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.black),
                                          // padding:
                                          //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                          //         EdgeInsets.symmetric(vertical: 17)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  side: BorderSide(
                                                    color: borderColor
                                                        ? main_color
                                                        : Colors.white,
                                                  ))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white)),
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          fontFamily: 'Serif',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: (savedata)
                                              ? main_color
                                              : Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        // print(imageurls.value);
                                        saveData(imageurls.value
                                            .map((str) => str as dynamic)
                                            .toList());
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              Text(
                                "${editdata[index].editname}",
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Sans-serif'),
                              ),
                              Text(
                                DateFormat('EEEE MMMM d y HH:mm').format(
                                    DateTime.parse(editdata[index].createdAt)
                                        .toLocal()),
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Sans-serif'),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    );
                  })),
    );
  }

  saveData(List<dynamic> imageurls) async {
    savedata = true;
    bool areEqual1 =
        const ListEquality().equals(imageurls, widget.userSave.imageurls);

    if (widget.userSave.About_Me == aboutmeController.text &&
        widget.userSave.Partner_Prefs == partnerPrefController.text &&
        areEqual1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SnackBarContent(
                error_text: "Please Update Data",
                appreciation: "",
                icon: Icons.error,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
    } else {
      widget.userSave.About_Me = aboutmeController.text;
      widget.userSave.Partner_Prefs = partnerPrefController.text;
      widget.userSave.imageurls = imageurls;
      setState(() {});
      AdminService().updateeditstatus(email: widget.userSave.email);
      if (aboutmeController.text != widget.userSave.About_Me) {
        SearchProfile().addtoadminnotification(
            userid: widget.userSave!.id!,
            useremail: widget.userSave!.email!,
            userimage: widget.userSave!.imageurls!.isEmpty
                ? ""
                : widget.userSave!.imageurls![0],
            subtitle: "EDIT PROFILE",
            email: userSave.email!,
            title:
                "${userSave.name!} EDIT   ${widget.userSave.name!.substring(0, 1)} ${widget.userSave.surname!.toUpperCase()} ${widget.userSave.puid} PROFILE ${"ABOUT ME"}");
      } else if (partnerPrefController.text != widget.userSave.Partner_Prefs) {
        SearchProfile().addtoadminnotification(
            userid: widget.userSave!.id!,
            useremail: widget.userSave!.email!,
            userimage: widget.userSave.imageurls.isEmpty
                ? ""
                : widget.userSave!.imageurls![0],
            subtitle: "EDIT PROFILE",
            email: userSave.email!,
            title:
                "${userSave.name!}  EDIT    ${widget.userSave.name!.substring(0, 1)} ${widget.userSave.surname!.toUpperCase()} ${widget.userSave.puid} PROFILE ${"About Partner Preference"} ");
      } else if (widget.userSave.imageurls.length != imageurls.length) {
        SearchProfile().addtoadminnotification(
            userid: widget.userSave!.id!,
            useremail: widget.userSave!.email!,
            userimage: widget.userSave!.imageurls!.isEmpty
                ? ""
                : widget.userSave!.imageurls![0],
            title:
                "${userSave.name!} EDIT  ${widget.userSave.name!.substring(0, 1)} ${widget.userSave.surname!.toUpperCase()} ${widget.userSave.puid} PROFILE ${"UPLOAD PHOTO"}",
            email: userSave.email!,
            subtitle: "");
      }

      try {
        if (!mounted) return;

        HomeService().editprofile(
            email: widget.userSave.email,
            aboutme: aboutmeController.text,
            mypreference: partnerPrefController.text,
            imageurls: imageurls);
        AdminService().createeditprofile(
            userid: widget.userSave.email,
            aboutme: aboutmeController.text,
            mypreference: partnerPrefController.text,
            isBlur: forIos,
            editname: "Edit by ${userSave.displayName}",
            dob: widget.userSave.dob.toString(),
            gender: widget.userSave.gender,
            phone: widget.userSave.phone,
            timeofbirth: widget.userSave.timeofbirth,
            placeofbirth: widget.userSave.placeofbirth,
            kundalidosh: widget.userSave.KundaliDosh,
            martialstatus: widget.userSave.MartialStatus,
            profession: widget.userSave.Profession,
            location1: widget.userSave.Location,
            city: widget.userSave.city,
            state: widget.userSave.state,
            country: widget.userSave.country,
            name: widget.userSave.name,
            surname: widget.userSave.surname,
            lat: widget.userSave.lat,
            lng: widget.userSave.lng,
            diet: widget.userSave.Diet!,
            disability: widget.userSave.Disability!,
            puid: widget.userSave.puid,
            drink: widget.userSave.Drink!,
            education: widget.userSave.Education!,
            height: widget.userSave.Height!,
            religion: widget.userSave.religion!,
            income: widget.userSave.Income!,
            imageurls: imageurls);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Update Successfully",
                  appreciation: "",
                  icon: Icons.check,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            }).then((value) {
          Navigator.pop(context, imageurls.isNotEmpty ? imageurls[0] : null);
        });
        // HomeService().getuserdata();

        // sharedPref.save("user", userSave);
      } catch (Excepetion) {
        print(Excepetion);
      }
    }
  }
}
