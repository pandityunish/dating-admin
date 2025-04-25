import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';

import '../../Assets/ImageDart/images.dart';
import '../../Storage/databaseRepo.dart';
import '../../Storage/storage_repo.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';
import '../navigation/admin_options/service/admin_service.dart';
import '../service/home_service.dart';
import 'customImg.dart';

class AddPics extends StatefulWidget {
  const AddPics({Key? key}) : super(key: key);

  @override
  State<AddPics> createState() => _ReligionState();
}

class _ReligionState extends State<AddPics> {
  int value = 0;
  User userSave = User();
  @override
  void initState() {
    super.initState();
    setData();
  }

  UserService userService = Get.put(UserService());
  setData() async {
    SharedPref sharedPref = SharedPref();

    // final json2 = await sharedPref.read("uid");
    var json3;
    try {
      json3 = await sharedPref.read("user");
    } catch (e) {
      print(e);
    }
    setState(() {
      userSave = User.fromJson(json3);
    });
    ImageUrls imageUrls = ImageUrls();
    imageUrls.clear();
  }

  @override
  Widget build(BuildContext context) {
    final imageurls = ImageUrls();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), // Adjust AppBar height
          child: AppBar(
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
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(
                  top: 10), // Adjust padding for alignment
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: main_color),
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: main_color,
                        fontFamily: 'Sans-serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      child: Text("Upload Pics"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "93% of The User Visit the Profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "After Seen Profile Pics",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // BlocBuilder<ImagesBloc, ImageState>(
                            //     builder: (context, state) {
                            //   if (state is ImageLoading) {
                            //     return Center(
                            //       child: CircularProgressIndicator(),
                            //     );
                            //   } else if (state is ImageLoaded) {
                            // return Column(

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
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 0),
                                                num: 0,
                                                isBlur: false)
                                            : CustomImageContainer(
                                                num: 0, isBlur: false),
                                        (imageCount > 1)
                                            ? CustomImageContainer(
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 1),
                                                num: 1,
                                                isBlur: false)
                                            : CustomImageContainer(
                                                num: 1, isBlur: false),
                                        (imageCount > 2)
                                            ? CustomImageContainer(
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 2),
                                                num: 2,
                                                isBlur: false)
                                            : CustomImageContainer(
                                                num: 2, isBlur: false),
                                        // CustomImageContainer(),
                                        // CustomImageContainer(),
                                        // CustomImageContainer(),
                                      ],
                                    ),
                                    SizedBox(
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
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 3),
                                                num: 3,
                                                isBlur: false,
                                              )
                                            : CustomImageContainer(
                                                num: 3, isBlur: false),
                                        (imageCount > 4)
                                            ? CustomImageContainer(
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 4),
                                                num: 4,
                                                isBlur: false)
                                            : CustomImageContainer(
                                                num: 4, isBlur: false),
                                        (imageCount > 5)
                                            ? CustomImageContainer(
                                                imageUrl: imageurls.imageUrl(
                                                    atIndex: 5),
                                                num: 5,
                                                isBlur: false)
                                            : CustomImageContainer(
                                                num: 5, isBlur: false),

                                        // CustomImageContainer(),
                                        // CustomImageContainer(),
                                        // CustomImageContainer(),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            // } else {
                            //   return Text("Something went wrong.");
                            // }
                            // }),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Upload Your Best Pics",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "To",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Get Instant Match",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        // new SizedBox(
                        //   height: 50,
                        //   width: 300,
                        //   child: ElevatedButton(
                        //       onPressed: () async {
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (context) => Congo(
                        //                   userS: userSave,
                        //                 )));
                        //       },
                        //       child: Text(
                        //         "Continue",
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       style: ButtonStyle(
                        //           shape:
                        //               MaterialStateProperty.all<RoundedRectangleBorder>(
                        //                   RoundedRectangleBorder(
                        //                       borderRadius: BorderRadius.circular(30.0),
                        //                       side: BorderSide(color: Colors.black))),
                        //           backgroundColor:
                        //               MaterialStateProperty.all<Color>(Colors.white))),
                        // ),
                      ],
                    ),
                  ],
                ),
                Container(
                  // margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 17)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: (color_done2 == false)
                                            ? Colors.white
                                            : main_color,
                                      ))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () async {
                        setState(() {
                          color_done2 = true;
                        });
                        UserService().deleteincompleteuser(
                            userService.userdata["email"]);
                        int statusCode = await AdminService()
                            .finduserprofilewithemail(
                                userService.userdata["email"]);
                        if (statusCode == 200) {
                          HomeService()
                              .deleteregisteruseraccount(
                                  email: userService.userdata["email"]!)
                              .whenComplete(() {
                            AdminService().createeditprofile(
                                userid: userService.userdata["email"],
                                aboutme: userService.userdata["aboutme"],
                                mypreference:
                                    userService.userdata["patnerpref"],
                                isBlur: false,
                                editname: "Created by ${userSave.displayName}",
                                dob: userService.userdata["dob"].toString(),
                                gender: userService.userdata["gender"],
                                phone: userService.userdata["phone"],
                                timeofbirth:
                                    userService.userdata["timeofbirth"],
                                placeofbirth:
                                    userService.userdata["placeofbirth"],
                                kundalidosh:
                                    userService.userdata["kundalidosh"],
                                martialstatus:
                                    userService.userdata["maritalstatus"] ?? "",
                                profession: userService.userdata["profession"],
                                location1: userService.userdata["location"],
                                city: userService.userdata["city"],
                                state: userService.userdata["state"],
                                country: userService.userdata["country"],
                                name: userService.userdata["name"],
                                surname: userService.userdata["surname"],
                                lat: userService.userdata["lat"],
                                lng: userService.userdata["lng"],
                                diet: userService.userdata["diet"],
                                disability: userService.userdata["disability"],
                                puid: userService.userdata["puid"],
                                drink: userService.userdata["drink"],
                                education: userService.userdata["education"],
                                height: userService.userdata["height"],
                                religion: userService.userdata["religion"],
                                income: userService.userdata["timeofbirth"],
                                imageurls: imageurls.value
                                    .map((str) => str as dynamic)
                                    .toList());
                            // Shared
                            print(userService.userdata["placeofbirth"]);
                            userService.createappuser(
                                context: context,
                                aboutme: userService.userdata["aboutme"] ?? "",
                                puid: userService.userdata["puid"],
                                lat: userService.userdata['lat'] ?? 0.1,
                                lng: userService.userdata['lng'] ?? 0.1,
                                placeofbirth:
                                    userService.userdata['placeofbirth'],
                                timeofbirth:
                                    userService.userdata['timeofbirth'],
                                age: userService.userdata["age"],
                                diet: userService.userdata["diet"] ?? "",
                                disability:
                                    userService.userdata["disability"] ?? "",
                                drink: userService.userdata["drink"] ?? "",
                                education:
                                    userService.userdata["education"] ?? "",
                                height: userService.userdata["height"] ?? "",
                                income:
                                    userService.userdata["incomestatus"] ?? "",
                                patnerprefs:
                                    userService.userdata["patnerpref"] ?? "",
                                smoke: userService.userdata["smoke"] ?? "",
                                displayname: userService.userdata["name"] ?? "",
                                email: userService.userdata["email"] ?? "",
                                religion:
                                    userService.userdata["religion"] ?? "",
                                name: userService.userdata["name"] ?? "",
                                surname: userService.userdata["surname"] ?? "",
                                phone: userService.userdata["phone"] ?? "",
                                gender: userService.userdata["gender"] ?? "",
                                kundalidosh:
                                    userService.userdata["kundalidosh"] ?? "",
                                martialstatus:
                                    userService.userdata["maritalstatus"] ?? "",
                                profession:
                                    userService.userdata["profession"] ?? "",
                                location:
                                    userService.userdata["location"] ?? "",
                                city: userService.userdata["city"] ?? "",
                                state: userService.userdata["state"] ?? "",
                                imageurls: imageurls.value
                                    .map((str) => str as dynamic)
                                    .toList(),
                                blocklists: [],
                                reportlist: [],
                                shortlist: [],
                                country: userService.userdata["country"] ?? "",
                                token: "hello this is token",
                                dob: userService.userdata["dob"] ?? "");
                          });
                        } else {
                          AdminService().createeditprofile(
                              userid: userService.userdata["email"],
                              aboutme: userService.userdata["aboutme"],
                              mypreference: userService.userdata["patnerpref"],
                              isBlur: false,
                              editname: "Created by ${userSave.displayName}",
                              dob: userService.userdata["dob"].toString(),
                              gender: userService.userdata["gender"],
                              phone: userService.userdata["phone"],
                              timeofbirth: userService.userdata["timeofbirth"],
                              placeofbirth:
                                  userService.userdata["placeofbirth"],
                              kundalidosh: userService.userdata["kundalidosh"],
                              martialstatus:
                                  userService.userdata["maritalstatus"] ?? "",
                              profession: userService.userdata["profession"],
                              location1: userService.userdata["location"],
                              city: userService.userdata["city"],
                              state: userService.userdata["state"],
                              country: userService.userdata["country"],
                              name: userService.userdata["name"],
                              surname: userService.userdata["surname"],
                              lat: userService.userdata["lat"],
                              lng: userService.userdata["lng"],
                              diet: userService.userdata["diet"],
                              disability: userService.userdata["disability"],
                              puid: userService.userdata["puid"],
                              drink: userService.userdata["drink"],
                              education: userService.userdata["education"],
                              height: userService.userdata["height"],
                              religion: userService.userdata["religion"],
                              income: userService.userdata["timeofbirth"],
                              imageurls: imageurls.value
                                  .map((str) => str as dynamic)
                                  .toList());
                          // Shared
                          print(userService.userdata["placeofbirth"]);
                          userService.createappuser(
                              context: context,
                              aboutme: userService.userdata["aboutme"] ?? "",
                              puid: userService.userdata["puid"],
                              lat: userService.userdata['lat'] ?? 0.1,
                              lng: userService.userdata['lng'] ?? 0.1,
                              placeofbirth:
                                  userService.userdata['placeofbirth'],
                              timeofbirth: userService.userdata['timeofbirth'],
                              age: userService.userdata["age"],
                              diet: userService.userdata["diet"] ?? "",
                              disability:
                                  userService.userdata["disability"] ?? "",
                              drink: userService.userdata["drink"] ?? "",
                              education:
                                  userService.userdata["education"] ?? "",
                              height: userService.userdata["height"] ?? "",
                              income:
                                  userService.userdata["incomestatus"] ?? "",
                              patnerprefs:
                                  userService.userdata["patnerpref"] ?? "",
                              smoke: userService.userdata["smoke"] ?? "",
                              displayname: userService.userdata["name"] ?? "",
                              email: userService.userdata["email"] ?? "",
                              religion: userService.userdata["religion"] ?? "",
                              name: userService.userdata["name"] ?? "",
                              surname: userService.userdata["surname"] ?? "",
                              phone: userService.userdata["phone"] ?? "",
                              gender: userService.userdata["gender"] ?? "",
                              kundalidosh:
                                  userService.userdata["kundalidosh"] ?? "",
                              martialstatus:
                                  userService.userdata["maritalstatus"] ?? "",
                              profession:
                                  userService.userdata["profession"] ?? "",
                              location: userService.userdata["location"] ?? "",
                              city: userService.userdata["city"] ?? "",
                              state: userService.userdata["state"] ?? "",
                              imageurls: imageurls.value
                                  .map((str) => str as dynamic)
                                  .toList(),
                              blocklists: [],
                              reportlist: [],
                              shortlist: [],
                              country: userService.userdata["country"] ?? "",
                              token: "hello this is token",
                              dob: userService.userdata["dob"] ?? "");
                        }
                      },
                      child: Text(
                        "Continue",
                        style: (color_done2 == false)
                            ? TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.w700)
                            : TextStyle(
                                color: main_color,
                                fontSize: 20,
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.w700),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }

  bool color_done2 = false;
}
