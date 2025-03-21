import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/admin_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/create_admin_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../models/edit_profile_model.dart';
import '../data_collection/congo.dart';
import '../data_collection/religion.dart';

class UserService extends GetxController {
  RxMap userdata = {}.obs;
  Future getbubbles() async {
    var data;
    try {
      http.Response res = await http.get(
        Uri.parse(getbubblesurl),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        return data = jsonDecode(res.body);
      }
    } catch (e) {
      print(e.toString());
      print("we are here ====>");
    }
    return data;
  }

  Future<void> createappuser(
      {required String aboutme,
      required String diet,
      required String disability,
      required String drink,
      required String education,
      required String height,
      required String income,
      required String patnerprefs,
      required String smoke,
      required String displayname,
      required String email,
      required String religion,
      required String name,
      required String surname,
      required String phone,
      required String gender,
      required String kundalidosh,
      required String martialstatus,
      required String profession,
      required String location,
      required String city,
      required String state,
      required List<dynamic> imageurls,
      required List<dynamic> blocklists,
      required List<dynamic> reportlist,
      required List<dynamic> shortlist,
      required String country,
      required String token,
      required String age,
      required double lat,
      required double lng,
      required String placeofbirth,
      required String timeofbirth,
      required String puid,
      required BuildContext context,
      required int dob}) async {
    try {
      print(email);
      NewUserModel userModel = NewUserModel(
          About_Me: aboutme,
          status: "",
          lat: lat,
          unapproveActivites: [],
          placeofbirth: placeofbirth,
          timeofbirth: timeofbirth,
          lng: lng,
          puid: puid,
          showads: [],
          verifiedstatus: "",
          pendingreq: [],
          adminlat: lat,
          friends: [],
          adminlng: lng,
          notifications: [],
          sendreq: [],
          age: age,
          id: "",
          Diet: diet,
          Disability: disability,
          Drink: drink,
          videolink: '',
          Education: education,
          Height: height,
          Income: income,
          Partner_Prefs: patnerprefs,
          Smoke: smoke,
          displayname: displayname,
          email: email,
          religion: religion,
          name: name,
          surname: surname,
          phone: phone,
          gender: gender,
          KundaliDosh: kundalidosh,
          MartialStatus: martialstatus,
          Profession: profession,
          Location: location,
          city: city,
          state: state,
          imageurls: imageurls,
          blocklists: blocklists,
          reportlist: reportlist,
          shortlist: shortlist,
          country: country,
          token: token,
          dob: dob);
      http.Response res = await http.post(Uri.parse(createuser),
          headers: {'Content-Type': 'Application/json'},
          body: userModel.toJson());
      print(res.body);
      if (res.statusCode == 200) {
        NewUserModel userModel =
            NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)));
        print(res.body);
        List<AdminModel> alladmins = await CreateAdminService().getalladmins();
        for (var i = 0; i < alladmins.length; i++) {
          sendPushMessagetoallusers(
              "${userSave.name!}  CREATED ${userModel.name.substring(0, 1).toUpperCase()} ${userModel.surname.toLowerCase()} ${userModel!.puid}  PROFILE SUCCESSFULLY ",
              "Free Rishtey Wala",
              userSave.uid!,
              "Free Rishtey Wala",
              alladmins[i].token);
        }

        SearchProfile().addtoadminnotification(
            userid: userModel!.id!,
            useremail: userModel!.email!,
            userimage:
                userModel!.imageurls!.isEmpty ? "" : userModel!.imageurls![0],
            title:
                "${userSave.displayName} CREATED ${userModel.name.substring(0, 1).toUpperCase()} ${userModel.surname.toLowerCase()} ${userModel!.puid} PROFILE SUCCESSFULLY WITH ${userModel.email}",
            email: userSave.email!,
            subtitle: "");

        Get.to(Congo());
      } else {
        SearchProfile().addtoadminnotification(
            userid: userModel!.id!,
            useremail: userModel!.email!,
            userimage:
                userModel!.imageurls!.isEmpty ? "" : userModel!.imageurls![0],
            title:
                "${userSave.displayName} TRIED TO CREATED  PROFILE SUCCESSFULLY WITH ${userModel.email} (EMAIL ERROR)",
            email: userSave.email!,
            subtitle: "");
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Email With User Already Exists",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> registercreateappuser(
      {required String aboutme,
      required String diet,
      required String disability,
      required String drink,
      required String education,
      required String height,
      required String income,
      required String patnerprefs,
      required String smoke,
      required String displayname,
      required String email,
      required String religion,
      required String name,
      required String surname,
      required String phone,
      required String gender,
      required String kundalidosh,
      required String martialstatus,
      required String profession,
      required String location,
      required String city,
      required String state,
      required List<dynamic> imageurls,
      required List<dynamic> blocklists,
      required List<dynamic> reportlist,
      required List<dynamic> shortlist,
      required String country,
      required String token,
      required String age,
      required double lat,
      required double lng,
      required String placeofbirth,
      required String timeofbirth,
      required String puid,
      required String username,
      required int dob_timestamp,
      required BuildContext context,
      required int dob}) async {
    try {
      print(email);
      NewUserModel userModel = NewUserModel(
          About_Me: aboutme,
          status: "",
          lat: lat,
          unapproveActivites: [],
          placeofbirth: placeofbirth,
          timeofbirth: "'",
          lng: lng,
          puid: puid,
          showads: [],
          verifiedstatus: "",
          pendingreq: [],
          adminlat: lat,
          friends: [],
          adminlng: lng,
          notifications: [],
          sendreq: [],
          age: age,
          id: "",
          Diet: diet,
          Disability: disability,
          Drink: drink,
          videolink: '',
          Education: education,
          Height: height,
          Income: income,
          Partner_Prefs: patnerprefs,
          Smoke: smoke,
          displayname: displayname,
          email: email,
          religion: religion,
          name: name,
          surname: surname,
          phone: phone,
          gender: gender,
          KundaliDosh: kundalidosh,
          MartialStatus: martialstatus,
          Profession: profession,
          Location: location,
          city: city,
          state: state,
          imageurls: imageurls,
          blocklists: blocklists,
          reportlist: reportlist,
          shortlist: shortlist,
          country: country,
          token: token,
          dob: dob);
      http.Response res = await http.post(Uri.parse(createuser),
          headers: {'Content-Type': 'Application/json'},
          body: userModel.toJson());
      print(res.body);
      if (res.statusCode == 200) {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Religion(
                      User_Name: username,
                      email: email,
                      User_SurName: surname,
                      age: age!,
                      dob: dob_timestamp!,
                      gender: gender,
                      phone_num: phone,
                      placeofbirth: placeofbirth,
                      timeofbirth: timeofbirth,
                    )));
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Email With User Already Exists",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteincompleteuser(String email) async {
    try {
      http.Response res = await http.post(Uri.parse(deleteincompleteurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("unblock");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createincompleteappuser(
      {required String aboutme,
      required String diet,
      required String disability,
      required String drink,
      required String education,
      required String height,
      required String income,
      required String patnerprefs,
      required String smoke,
      required String displayname,
      required String email,
      required String religion,
      required String name,
      required String surname,
      required String phone,
      required String gender,
      required String kundalidosh,
      required String martialstatus,
      required String profession,
      required String location,
      required String city,
      required String state,
      required List<dynamic> imageurls,
      required List<dynamic> blocklists,
      required List<dynamic> reportlist,
      required List<dynamic> shortlist,
      required String country,
      required String token,
      required String age,
      required double lat,
      required double lng,
      required String placeofbirth,
      required String timeofbirth,
      required String puid,
      required String username,
      required int dob_timestamp,
      required BuildContext context,
      required int dob}) async {
    try {
      NewUserModel userModel = NewUserModel(
          About_Me: aboutme,
          status: "",
          lat: lat,
          unapproveActivites: [],
          placeofbirth: placeofbirth,
          timeofbirth: "'",
          lng: lng,
          puid: puid,
          showads: [],
          verifiedstatus: "",
          pendingreq: [],
          adminlat: lat,
          friends: [],
          adminlng: lng,
          notifications: [],
          sendreq: [],
          age: age,
          id: "",
          Diet: diet,
          Disability: disability,
          Drink: drink,
          videolink: '',
          Education: education,
          Height: height,
          Income: income,
          Partner_Prefs: patnerprefs,
          Smoke: smoke,
          displayname: displayname,
          email: email,
          religion: religion,
          name: name,
          surname: surname,
          phone: phone,
          gender: gender,
          KundaliDosh: kundalidosh,
          MartialStatus: martialstatus,
          Profession: profession,
          Location: location,
          city: city,
          state: state,
          imageurls: imageurls,
          blocklists: blocklists,
          reportlist: reportlist,
          shortlist: shortlist,
          country: country,
          token: token,
          dob: dob);
      http.Response res = await http.post(Uri.parse(createincompleteuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: userModel.toJson());
      print(res.body);
      if (res.statusCode == 200) {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => Religion(
                      User_Name: username,
                      email: email,
                      User_SurName: surname,
                      age: age!,
                      dob: dob_timestamp!,
                      gender: gender,
                      phone_num: phone,
                      placeofbirth: placeofbirth,
                      timeofbirth: timeofbirth,
                    )));
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Email With User Already Exists",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } catch (e) {
      print(e.toString());
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

  Future<List<EditProfileModel>> geteditprofiles(String email) async {
    List<EditProfileModel> data = [];
    try {
      http.Response res = await http.post(
        Uri.parse(geteditprofilesurl),
        body: jsonEncode({"userid": email}),
        headers: {'Content-Type': 'Application/json'},
      );
      print("**************");
      print(res.body);
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          data.add(
              EditProfileModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
    return data;
  }
}
