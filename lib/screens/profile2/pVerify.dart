import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../../Assets/Error.dart';
import '../../Assets/ImageDart/videoUpload.dart';
import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../../models/new_user_model.dart';
import '../../models/verify_user_model.dart';
import '../../sendUtils/notiFunction.dart';
import 'package:http/http.dart' as http;

import '../navigation/admin_options/service/admin_service.dart';
import '../service/search_profile.dart';

class Verify extends StatefulWidget {
  Verify({Key? key, required this.userSave}) : super(key: key);
  NewUserModel userSave;
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  get navigator => null;
  final picker = ImagePicker();
  late File _videoFile = File('');
  bool isuploading = false;
  double uploadProgress = 0;
  // ignore: prefer_typing_uninitialized_variables
  var uid;

  @override
  void initState() {
    super.initState();
    setuserData();
    getbiodata();
  }

  List<VerifyUserModel> verifyvideo = [];
  void getbiodata() async {
    try {
      List<VerifyUserModel> biodatas =
          await AdminService().getverifyuser(id: widget.userSave.email);
      // VerifyUserModel newbiodata = VerifyUserModel(
      //   createdAt: "",
      //   name: "1234",
      //   videoLink: "",
      // );
      biodatas.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      verifyvideo = [...biodatas];
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  setuserData() async {}

  Future _pickVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    // setState(() {
    if (pickedFile != null) {
      // _videoFile = File(pickedFile.path);
      var size = await pickedFile.length();
      if (size < 2e+7) {
        setState(() {
          _videoFile = File(pickedFile.path);
        });
        setState(() {
          isuploading = true;
        });
        _uploadVideoToFirebase();
        // NotificationFunction.setNotification(
        //   "admin",
        //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} TRIED TO UPLOAD VIDEO (JUST LIKE THAT )",
        //   'videouploadjlt',
        // );
      } else {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Video size must be less than 20 MB",
                  appreciation: "",
                  icon: Icons.check,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } else {}
    // });
  }

  Future _captureVideoFromCamera() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    // setState(() {
    if (pickedFile != null) {
      var size = await pickedFile.length();
      if (size < 2e+7) {
        // _videoFile = File(pickedFile.path);
        setState(() {
          _videoFile = File(pickedFile.path);
        });
        setState(() {
          isuploading = true;
        });
        _uploadVideoToFirebase();
        // NotificationFunction.setNotification(
        //   "admin",
        //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} TRIED TO UPLOAD VIDEO (JUST LIKE THAT )",
        //   'videouploadjlt',
        // );
      } else {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Video size must be less than 20 MB",
                  appreciation: "",
                  icon: Icons.check,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } else {
      print('No video captured.');
    }
    // });
  }

  Future _uploadVideoToFirebase() async {
    var videoname = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('videos/$videoname');
    final UploadTask uploadTask = storageRef.putFile(_videoFile);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Upload ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      setState(() {
        uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    }, onError: (Object e) {
      print(e.toString());
    }, onDone: () async {
      print('File uploaded!');
    });
    await uploadTask.whenComplete(() async {
      print('Video uploaded to Firebase storage');

      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SnackBarContent(
                error_text:
                    "Video Has Been Uploaded Successfully \n Your Profile Would Be Verified Shortly",
                appreciation: "",
                icon: Icons.check,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
      _getDownloadUrl(videoname);
      // NotificationFunction.setNotification(
      //   "admin",
      //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} TRIED TO UPLOAD VIDEO (JUST LIKE THAT )",
      //   'videouploadsuccess',
      // );
      // NotificationFunction.setNotification(
      //   "user1",
      //   "VIDEO UPLOADED SUCCESSFULLY",
      //   'videouploadsuccess',
      // );
    });
  }

  Future _getDownloadUrl(var videoName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    User? user = User.fromJson(await sharedPref.read("user") ?? {});
    String downloadUrl =
        await storage.ref('videos/${videoName}').getDownloadURL();
    setState(() {
      user.videoLink = downloadUrl;
      user.videoName = videoName;
    });
    final json = user.toJson();
    print(json.toString());
    print("uid : ${uid}");
    final docUser =
        await FirebaseFirestore.instance.collection('user_data').doc(uid);

    try {
      await sharedPref.save("user", user);
      await docUser.update(json).catchError((error) => print(error));
      setState(() {
        userSave = user;
        isuploading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isuploading = false;
      });
    }
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickVideoFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _captureVideoFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _deleteVideo() async {
    try {
      http.Response res = await http.post(Uri.parse("$baseurl/auth/delete"),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": widget.userSave.email,
          }));
      if (res.statusCode == 200) {
        print("unblock");
      }
    } catch (e) {
      print(e.toString());
    }

    if (userSave.videoLink != null && userSave.videoLink != "") {
      final videoRef =
          FirebaseStorage.instance.ref().child('videos/${userSave.videoName}');

      // User? user = User.fromJson(await sharedPref.read("user"));

      setState(() {
        widget.userSave.videolink = "";
        widget.userSave.videolink = "";
      });
      final json = userSave.toJson();
      // print(json.toString());
      // print("uid : ${uid}");
      final docUser = await FirebaseFirestore.instance
          .collection('user_data')
          .doc(userSave.uid);

      try {
        // await sharedPref.save("user", user);
        await docUser.update(json).then((value) async {
          await videoRef.delete();
        }).catchError((error) => print(error));
        setState(() {
          // userSave = user;
          isuploading = false;
        });
      } catch (e) {
        print(e);
        // setState(() {
        //   // isuploading = false;
        // });
      }
      // Delete the video file from Firebase Storage
    }
  }

  void sendPushMessagetoallusers(String body, String title, String uid,
      String username, String token) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAARNDuqEs:APA91bFMhCmAO8olPfJxG868C9czilKHzNIk_pYuXBJ7iFrGiK6bPl6K_O5Uqkq607hZFu_ScIfyCRq7ZBnHTtz_vl6HvrIvdDwxu_nxP4P4E-pDpGvIeGhP5Z3CQoxgwq6sZTlFLtYa',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'icon': 'ic_launcher'
            },
            "android": {"priority": "high"},
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'uid': uid,
              'route': "",
              'id': uid,
              'userName': username,
              'status': 'done',
              'sound': ""
            },
            "to": token,
          },
        ),
      );

      print(res.body);
    } catch (e) {
      print("error push notification");
    }
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: CustomAppBar(
              title: "Profile Verification",
              iconImage: "images/icons/verified.png"),
          //  CupertinoNavigationBar(
          //   middle: Row(
          //     children: [
          //       BigText(
          //         text: "Profile Verified",
          //         size: 20,
          //         color: main_color,
          //         fontWeight: FontWeight.w700,
          //       )
          //     ],
          //   ),
          //   leading: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(
          //       Icons.arrow_back_ios_new,
          //       color: main_color,
          //       size: 25,
          //     ),
          //   ),
          //   previousPageTitle: "",
          // ),
          body: PageView.builder(
            itemCount: verifyvideo.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              // if (verifyvideo[index].name == "1234") {
              //   return SingleChildScrollView(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         SizedBox(
              //           height: 120,
              //         ),
              //         Text(
              //           "Upload A Video",
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //               fontFamily: 'Sans-serif',
              //               decoration: TextDecoration.none,
              //               fontSize: 24,
              //               color: Colors.black54,
              //               fontWeight: FontWeight.w600),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         SizedBox(
              //             height: 200,
              //             width: 300,
              //             child: (isuploading)
              //                 ? Center(
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         CircularProgressIndicator(
              //                           valueColor:
              //                               AlwaysStoppedAnimation<Color>(
              //                                   main_color),
              //                           value: uploadProgress,
              //                           color: main_color,
              //                         ),
              //                         SizedBox(height: 20),
              //                         Text(
              //                           "Uploading Video: ${(uploadProgress * 100).toStringAsFixed(0)}%",
              //                           style: TextStyle(
              //                             fontFamily: 'Sans-serif',
              //                             decoration: TextDecoration.none,
              //                             fontSize: 16,
              //                             color: Colors.black54,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   )
              //                 : (widget.userSave.videolink == null ||
              //                         widget.userSave.videolink == '')
              //                     ? FloatingActionButton(
              //                         onPressed: () {
              //                           _showPicker(context: context);
              //                         },
              //                         child: const Icon(Icons.add),
              //                         backgroundColor: Colors.white,
              //                         foregroundColor: Colors.black,
              //                         shape: BeveledRectangleBorder(
              //                           borderRadius: BorderRadius.zero,
              //                         ),
              //                       )
              //                     : VideoPlayerWidget1(
              //                         videoUrl: widget.userSave.videolink!,
              //                         userSave: widget.userSave,
              //                       )),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Text(
              //           "A Video About Me",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               decoration: TextDecoration.none,
              //               fontSize: 20,
              //               fontFamily: 'Sans-serif',
              //               color: Colors.black54,
              //               fontWeight: FontWeight.w600),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),

              //         SizedBox(
              //             height: 200,
              //             width: 300,
              //             child: VideoPlayerWidget1(
              //                 userSave: widget.userSave,
              //                 videoUrl: (widget.userSave.gender != "male")
              //                     ? "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/videos%2Ffemalevideo.mp4?alt=media&token=46d36b9f-e321-4fe8-ac66-496a27aca7c7"
              //                     : "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/videos%2Fmalevideo.mp4?alt=media&token=96c5c184-1ee7-49c2-80dd-ba63f564766d")),
              //         // BigText(text: 'A Video About Me'),
              //         verifyvideo.length > 1
              //             ? Padding(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 10, vertical: 10),
              //                 child: SizedBox(
              //                   width: Get.width,
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.end,
              //                     children: [
              //                       IconButton(
              //                           icon: Icon(Icons.arrow_forward_ios),
              //                           onPressed: () => {
              //                                 _pageController.nextPage(
              //                                   duration:
              //                                       Duration(milliseconds: 500),
              //                                   curve: Curves.easeInOut,
              //                                 )
              //                               }),
              //                     ],
              //                   ),
              //                 ),
              //               )
              //             : Center(),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.045,
              //         ),
              //         SizedBox(
              //           height: 50,
              //           width: 300,
              //           child: ElevatedButton(
              //             style: ButtonStyle(
              //                 shadowColor: MaterialStateColor.resolveWith(
              //                     (states) => Colors.black),
              //                 shape: MaterialStateProperty.all<
              //                         RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(30.0),
              //                   // side: const BorderSide(
              //                   //     color: Colors.black)
              //                 )),
              //                 backgroundColor: MaterialStateProperty.all<Color>(
              //                     Colors.white)),
              //             child: (isuploading)
              //                 ? CircularProgressIndicator(
              //                     valueColor:
              //                         AlwaysStoppedAnimation<Color>(main_color),
              //                     value: uploadProgress,
              //                     color: main_color,
              //                   )
              //                 : Text(
              //                     (widget.userSave.verifiedstatus != "verified")
              //                         ? "Verify"
              //                         : "Unverify",
              //                     style: TextStyle(
              //                       fontFamily: 'Serif',
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.w700,
              //                       color: Colors.black,
              //                     ),
              //                   ),
              //             onPressed: () async {
              //               if (isuploading) {
              //                 print("updating video");
              //               } else {
              //                 if (widget.userSave.status != "") {
              //                   if ((widget.userSave.verifiedstatus !=
              //                       "verified")) {
              //                     widget.userSave.verifiedstatus = "verified";
              //                     SearchProfile().addtoadminnotification(
              //                         userid: widget.userSave!.id!,
              //                         useremail: widget.userSave!.email!,
              //                         userimage:
              //                             widget.userSave!.imageurls!.isEmpty
              //                                 ? ""
              //                                 : widget.userSave!.imageurls![0],
              //                         title:
              //                             "${userSave.displayName} VERIFIED ${widget.userSave.name[0]} ${widget.userSave.surname} ${widget.userSave.puid}",
              //                         email: userSave.email!,
              //                         subtitle: "");
              //                     HomeService()
              //                         .verifyuser(email: widget.userSave.email);
              //                     SearchProfile().addtonotification(
              //                       email: widget.userSave.email,
              //                       title:
              //                           "PROFILE HAS BEEN VERIFIED SUCCESSFULLY",
              //                     );
              //                     HomeService().createverifieduser(
              //                         editname: "Verified By ${userSave.name}",
              //                         videolink: widget.userSave.videolink,
              //                         useremail: widget.userSave.email);

              //                     sendPushMessagetoallusers(
              //                         "PROFILE HAS BEEN VERIFIED SUCCESSFULLY",
              //                         "Free Rishtey Wala",
              //                         widget.userSave.id,
              //                         widget.userSave.name,
              //                         widget.userSave.token);
              //                     setState(() {});
              //                     ScaffoldMessenger.of(context).showSnackBar(
              //                       SnackBar(
              //                         duration: Duration(seconds: 1),
              //                         content: SnackBarContent(
              //                           error_text:
              //                               "Profile Verified Successfully",
              //                           appreciation: "Congratulations",
              //                           icon: Icons.check,
              //                           sec: 2,
              //                         ),
              //                         margin: EdgeInsets.only(
              //                             bottom: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 0.25,
              //                             left: MediaQuery.of(context)
              //                                     .size
              //                                     .width *
              //                                 0.06),
              //                         behavior: SnackBarBehavior.floating,
              //                         backgroundColor: Colors.transparent,
              //                         elevation: 0,
              //                       ),
              //                     );
              //                   } else {
              //                     widget.userSave.verifiedstatus = "unverified";
              //                     SearchProfile().addtoadminnotification(
              //                         userid: widget.userSave!.id!,
              //                         useremail: widget.userSave!.email!,
              //                         userimage:
              //                             widget.userSave!.imageurls!.isEmpty
              //                                 ? ""
              //                                 : widget.userSave!.imageurls![0],
              //                         title:
              //                             "${userSave.displayName} DELETE UPLOADED VIDEO BY ${widget.userSave.name[0]} ${widget.userSave.surname} ${widget.userSave.puid}",
              //                         email: userSave.email!,
              //                         subtitle: "");
              //                     HomeService().unverifyuser(
              //                         email: widget.userSave.email);
              //                     HomeService().createverifieduser(
              //                         editname:
              //                             "UnVerified By ${userSave.name}",
              //                         videolink: widget.userSave.videolink,
              //                         useremail: widget.userSave.email);

              //                     setState(() {});
              //                     ScaffoldMessenger.of(context).showSnackBar(
              //                       SnackBar(
              //                         duration: Duration(seconds: 1),
              //                         content: SnackBarContent(
              //                           error_text:
              //                               "Profile Unverified Successfully",
              //                           appreciation: "Congratulations",
              //                           icon: Icons.check,
              //                           sec: 2,
              //                         ),
              //                         margin: EdgeInsets.only(
              //                             bottom: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 0.25,
              //                             left: MediaQuery.of(context)
              //                                     .size
              //                                     .width *
              //                                 0.06),
              //                         behavior: SnackBarBehavior.floating,
              //                         backgroundColor: Colors.transparent,
              //                         elevation: 0,
              //                       ),
              //                     );
              //                   }
              //                 } else {
              //                   await showDialog(
              //                       barrierDismissible: false,
              //                       context: context,
              //                       builder: (context) {
              //                         return const AlertDialog(
              //                           content: SnackBarContent(
              //                             error_text:
              //                                 "Please Approve The User First",
              //                             appreciation: "",
              //                             icon: Icons.error,
              //                             sec: 3,
              //                           ),
              //                           backgroundColor: Colors.transparent,
              //                           elevation: 0,
              //                         );
              //                       });
              //                 }
              //               }
              //             },
              //           ),
              //         ),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.005,
              //         ),
              //         // SizedBox(
              //         //   height: 50,
              //         //   width: 300,
              //         //   child: ElevatedButton(
              //         //     style: ButtonStyle(
              //         //         shadowColor: MaterialStateColor.resolveWith(
              //         //             (states) => Colors.black),
              //         //         shape: MaterialStateProperty.all<
              //         //                 RoundedRectangleBorder>(
              //         //             RoundedRectangleBorder(
              //         //           borderRadius: BorderRadius.circular(30.0),
              //         //           // side: const BorderSide(
              //         //           //     color: Colors.black)
              //         //         )),
              //         //         backgroundColor: MaterialStateProperty.all<Color>(
              //         //             Colors.white)),
              //         //     child: (isuploading)
              //         //         ? CircularProgressIndicator(
              //         //             valueColor:
              //         //                 AlwaysStoppedAnimation<Color>(main_color),
              //         //             value: uploadProgress,
              //         //             color: main_color,
              //         //           )
              //         //         : Text(
              //         //             (widget.userSave.videolink == null ||
              //         //                     widget.userSave.videolink == '')
              //         //                 ? "Upload"
              //         //                 : "Reject",
              //         //             style: TextStyle(
              //         //               fontFamily: 'Serif',
              //         //               fontSize: 20,
              //         //               fontWeight: FontWeight.w700,
              //         //               color: Colors.black,
              //         //             ),
              //         //           ),
              //         //     onPressed: () {
              //         //       if (isuploading) {
              //         //         print("updating video");
              //         //       } else {
              //         //         HomeService().createverifieduser(
              //         //             editname: "Rejected By ${userSave.name}",
              //         //             videolink: widget.userSave.videolink,
              //         //             useremail: widget.userSave.email);
              //         //         _deleteVideo();
              //         //         sendPushMessagetoallusers(
              //         //             "PROFILE HAS BEEN REJECTED PLEASE REUPLOAD VIDEO ",
              //         //             "Free Rishtey Wala",
              //         //             widget.userSave.id,
              //         //             widget.userSave.name,
              //         //             widget.userSave.token);

              //         //         SearchProfile().addtoadminnotification(
              //         //             userid: widget.userSave!.id!,
              //         //             useremail: widget.userSave!.email!,
              //         //             userimage: widget.userSave!.imageurls!.isEmpty
              //         //                 ? ""
              //         //                 : widget.userSave!.imageurls![0],
              //         //             title:
              //         //                 "${userSave.displayName} REJECT VIDEO OF ${widget.userSave.name[0]} ${widget.userSave.surname} ${widget.userSave.puid}",
              //         //             email: userSave.email!,
              //         //             subtitle: "");
              //         //       }
              //         //     },
              //         //   ),
              //         // ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //       ],
              //     ),
              //   );
              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Uploaded on " +
                              DateFormat('EEEE d MMM y HH:mm').format(
                                DateTime.parse(verifyvideo[index].createdAt)
                                    .toLocal(),
                              ),
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                            height: 200,
                            width: Get.width * 0.9,
                            child: VideoPlayerWidget1(
                              videoUrl: verifyvideo[index].videoLink!,
                              userSave: widget.userSave,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   "A Video About Me",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       decoration: TextDecoration.none,
                        //       fontSize: 20,
                        //       fontFamily: 'Sans-serif',
                        //       color: Colors.black54,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),

                        // SizedBox(
                        //     height: 200,
                        //     width: 300,
                        //     child: VideoPlayerWidget1(
                        //         userSave: widget.userSave,
                        //         videoUrl: (widget.userSave.gender != "male")
                        //             ? "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/videos%2Ffemalevideo.mp4?alt=media&token=46d36b9f-e321-4fe8-ac66-496a27aca7c7"
                        //             : "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/videos%2Fmalevideo.mp4?alt=media&token=96c5c184-1ee7-49c2-80dd-ba63f564766d")),
                        // BigText(text: 'A Video About Me'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: SizedBox(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                index == 0
                                    ? Center()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: main_color,
                                        ),
                                        onPressed: () => {
                                              _pageController.previousPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              )
                                            }),
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: main_color,
                                    ),
                                    onPressed: () => {
                                          _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          )
                                        }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                  ),
                  SizedBox(
                    height: 50,
                    width: Get.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            // side: const BorderSide(
                            //     color: Colors.black)
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: (isuploading)
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(main_color),
                              value: uploadProgress,
                              color: main_color,
                            )
                          : Text(
                              (widget.userSave.verifiedstatus != "verified")
                                  ? "Verify"
                                  : "Unverify",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                      onPressed: () async {},
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  SizedBox(
                    height: 50,
                    width: Get.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            // side: const BorderSide(
                            //     color: Colors.black)
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: (isuploading)
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(main_color),
                              value: uploadProgress,
                              color: main_color,
                            )
                          : Text(
                              "Delete",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "${verifyvideo[index].name}",
                  //   style: TextStyle(
                  //     fontFamily: 'Serif',
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w700,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              );
            },
          )),
    );
  }
}
