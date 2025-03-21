import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/notification_service.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/globalVars.dart' as glb;
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:matrimony_admin/main.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../models/admin_notification_model.dart';
import '../models/shared_pref.dart';
import '../models/user_model.dart' as usr;
import '../screens/data_collection/LetsStart.dart';
import '../screens/maintinance_screen.dart';
import '../screens/profile/profileScroll.dart';
import '../screens/service/search_profile.dart';
import '../sendUtils/notiFunction.dart';
import 'Error.dart';

class G_Sign extends StatefulWidget {
  var term;

  G_Sign({Key? key, required this.term}) : super(key: key);

  @override
  State<G_Sign> createState() => _G_SignState();
}

class _G_SignState extends State<G_Sign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: glb.scaffoldKey,
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SignInButton(
              Buttons.GoogleDark,
              padding: EdgeInsets.all(5),
              onPressed: () async {
                if (widget.term == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: SnackBarContent(
                        error_text: "Term's & Condition is not Marked",
                        appreciation: "",
                        icon: Icons.error,
                        sec: 2,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                } else {
                  try {
                    await signup(context);
                    glb.isLogin = true;
                    // Navigator.of(context).pop();
                    // Tpage.transferPage(context,"gsign");
                    // globals.isLoggedIn = true;

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LetsStart()));
                  } catch (e) {
                    print(e);
                  }

                  // }).catchError((e) => print(e));
                }
              },
            ),
          )),
    );
  }

  Position? _currentPosition;
  String? _currentAddress;
  String? location;
  Placemark? place;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place!.locality}, ${place!.postalCode}, ${place!.country}";
        // print(_currentAddress);
        location = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }
}

String? uid = uid_value;
final FirebaseAuth auth = FirebaseAuth.instance;

Future<dynamic> signup(BuildContext context) async {
  _G_SignState location = _G_SignState();
  await location._getCurrentLocation();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    print(result.user!.email);
    userSave.email = result.user!.email;
    userSave.token = result.credential!.accessToken;
    SharedPref sharedPref = SharedPref();
    await sharedPref.save("user", userSave);
    List<AdminNotificationModel> allnotifications = [];
    allnotifications = await HomeService().getunreadmessages();
    String findusercond =
        await AuthService().findadminuser(result.user!.email!);
    if (findusercond == "true") {
      int statusCode = await AuthService().finduser(result.user!.email!);
      if (statusCode == 200) {
        HomeService().getuserdata().whenComplete(() {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
              title: "${userSave.displayName} LOGIN SUCCESSFULLY",
              email: userSave.email!,
              subtitle: "");
        });
        //  AuthService().getadmin(userSave.email!);
        var data;

        data = await HomeService().getmaintenance();

        if (data[0]["isUnder"] == false) {
          if (userSave.email == "s9053622222@gmail.com" ||
              userSave.email == "s9728401234@gmail.com" ||
              userSave.email == "yunishpandit98@gmail.com"||userSave.email == "pandityunish1228@gmail.com") {
            print("mein ${userSave.email}");
            print("ok hello");
            print("$allnotifications allnotification");
            for (var i = 0; i < allnotifications.length; i++) {
              print("run the function1");
              if (allnotifications[i].title.contains("CREATED PROFILE") ||
                  allnotifications[i].title.contains("ACCEPTED INTEREST OF")) {
                print("run the function");
                NotificationServiceLocal().showNotification(
                    id: i, body: "", title: allnotifications[i].title);
              }
            }
            Get.offAll(SlideProfile());
          } else {
            Get.offAll(MeintenanceScreen());
          }
        } else {
          Navigator.of((glb.scaffoldKey.currentContext == null)
                  ? context
                  : glb.scaffoldKey.currentContext!)
              .pushReplacement(
                  MaterialPageRoute(builder: (builder) => SlideProfile()));
        }
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Please login into the user app",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      SearchProfile().addtoadminnotification(
          userid: "2345",
          useremail: result.user!.email!,
          userimage: "",
          title: "${result.user!.email} TRIED TO LOGIN AS ADMIN  ",
          email: userSave.email!,
          subtitle: "");
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SnackBarContent(
                error_text: "OTP Send Successfully",
                appreciation: "",
                icon: Icons.check_circle_rounded,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
    }
    // var docemail = await FirebaseFirestore.instance
    //     .collection("admin_data")
    //     .doc("admin_email_list")
    //     .get();
    // var listemail = docemail['email'];
    // print("listemail : $listemail");
    // if (result != null) {
    //   uid = FirebaseAuth.instance.currentUser!.uid.toString();
    //   final doc = await FirebaseFirestore.instance
    //       .collection('user_data')
    //       .doc(uid)
    //       .get();
    //   final bool doesDocExist = doc.exists;

    //   SharedPref sharedPref = SharedPref();
    //   usr.User? userSave = usr.User();
    //   if (listemail.contains(user!.email)&& doesDocExist && doc.data().toString().contains('Location')) {
    //     userSave = await usr.User.fromdoc(doc);
    //     // userSave.token = glb.deviceToken;
    //     final json2 = userSave.toJson();
    //     // print("userSave.token : ${glb.deviceToken}");
    //     await sharedPref.save("user", userSave);
    //     await sharedPref.save("uid", {"uid": uid});

    //     FirebaseFirestore.instance
    //         .collection("user_data")
    //         .doc(uid)
    //         .update(json2);
    //     // NotificationFunction.setNotification(
    //     //   "admin",
    //     //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid} ",
    //     //   'login',
    //     // );
    //     // NotificationFunction.setNotification(
    //     //     "user1", "LOGIN SUCCESSFULLY", 'login',
    //     //     useruid: uid!);
    //   } else {
    //     showDialog(
    //         barrierDismissible: false,
    //         context: context,
    //         builder: (context) {
    //           return const AlertDialog(
    //             content: SnackBarContent(
    //               error_text:
    //                   "You Don't have permission \nto \naccess this app",
    //               appreciation: "",
    //               icon: Icons.error,
    //               sec: 2,
    //             ),
    //             backgroundColor: Colors.transparent,
    //             elevation: 0,
    //           );
    //         });
    //     final GoogleSignIn googleSignIn = GoogleSignIn();

    //     try {
    //       if (!kIsWeb) {
    //         await googleSignIn.signOut();
    //       }
    //       // await FirebaseFirestore.instance
    //       //     .collection("deleted_account")
    //       //     .doc(uid)
    //       //     .update({'connectivity': "Offline"});

    //       await FirebaseAuth.instance.signOut();
    //     } catch (e) {
    //       print(e);
    //     }
    //     return;
    //   }

    //   print('User is signed in!');
    //   usr.User dummy = usr.User();
    //   setState() {
    //     glb.userSave = (userSave == null) ? dummy : userSave;
    //   }

    // }
    // if result not null we simply call the MaterialpageRoute,
    // for go to the HomePage screen
  }
}
