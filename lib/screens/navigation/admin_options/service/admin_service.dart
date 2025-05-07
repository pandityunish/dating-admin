import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/bio_data_model.dart';
import 'package:matrimony_admin/models/history_save_pref.dart';
import 'package:matrimony_admin/models/kundli_model_history.dart';
import 'package:matrimony_admin/models/send_link_model.dart';
import 'package:matrimony_admin/models/send_notification_model.dart';
import 'package:matrimony_admin/models/user_search.dart';
import 'package:matrimony_admin/models/verify_user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/sendNotification.dart';

class AdminService {
  Future<int> findprofile(String uid) async {
    int status = 0;
    try {
      http.Response res = await http.get(Uri.parse("$finduser/$uid"));
      print(res.statusCode);
      if (res.statusCode == 200) {
        return status = 200;
      } else {
        return status = 404;
      }
    } catch (e) {}
    return status;
  }

  Future<int> finduserprofilewithemail(String email) async {
    int statusCode = 0;
    try {
      http.Response res = await http.get(Uri.parse("$finduserurl/$email"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        userSave.email = jsonDecode(res.body)["user"]["email"];
        print(userSave.email);
        return statusCode = res.statusCode;
      } else if (res.statusCode == 400) {
        return statusCode = res.statusCode;
      }
    } catch (e) {
      print(e.toString());
    }
    return statusCode;
  }

  Future<List<SendLinkModel>> getsendlink(String email) async {
    List<SendLinkModel> alllinks = [];
    try {
      http.Response res = await http.post(Uri.parse(getsendlinkurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email}));

      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          alllinks
              .add(SendLinkModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return alllinks;
  }

  Future posttheuserid(
      {required String uid, required List<dynamic> listofids}) async {
    try {
      http.Response res = await http.post(Uri.parse(postalldataurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": uid, "listofids": listofids}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future countsendlink(
      {required String email,
      required int aboutme,
      required int patnerpref,
      required int success,
      required int video,
      required int savepref,
      required int useapp,
      required int professionManually,
      required int educationManually,
      required int rating,
      required int photo,
      required int biodata,
      required int support}) async {
    try {
      print(email);
      http.Response res = await http.post(Uri.parse(postcountsendlinkurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "aboutme": aboutme,
            "patnerpref": patnerpref,
            "name": userSave.displayName,
            "status": "Pending",
            "success": success,
            "video": video,
            "savepref": savepref,
            "useapp": useapp,
            "professionManually": professionManually,
            "educationManually": educationManually,
            "rating": rating,
            "photo": photo,
            "biodata": biodata,
            "support": support
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addtosendlink({required String email, required String value}) async {
    print("hello");
    try {
      http.Response res = await http.post(Uri.parse(addtosendlinkurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "value": value}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addtosendnotification(
      {required String email,
      required String heading,
      required String name,
      required String title,
      required String status,
      required String type}) async {
    print("hello");
    try {
      http.Response res = await http.post(Uri.parse(addtosendnotificationurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "title": title,
            "heading": heading,
            "name": name,
            "status": status,
            "type": type
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<SendNotificationModel>> getsendnotification(
      {required String email}) async {
    List<SendNotificationModel> notification = [];
    try {
      http.Response res = await http.post(Uri.parse(getsendnotificationurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          notification.add(SendNotificationModel.fromJson(
              jsonEncode(jsonDecode(res.body)[i])));
        }
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
    return notification;
  }

  Future addtoeachsendlink(
      {required String searchtext, required String value}) async {
    try {
      http.Response res = await http.post(Uri.parse(addsendlinktoeachuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"value": value, "searchtext": searchtext}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addnotificationtoeachsendlink(
      {required String searchtext,
      required String body,
      required String title}) async {
    print("hello");
    try {
      http.Response res = await http.post(
          Uri.parse(sendnotificationtoeachuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "searchtext": searchtext,
            "body": body,
            "title": title,
            "sound": "navnot"
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addtoads(
      {required String description,
      required String email,
      required String adsid,
      required String image}) async {
    try {
      http.Response res = await http.post(Uri.parse(showadstouserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "description": description,
            "email": email,
            "adsid": adsid,
            "image": image
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future removefromads({required String email, required String adsid}) async {
    try {
      http.Response res = await http.post(Uri.parse(removeadsurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "adsid": adsid,
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future invisibletouser({required String puid, required String value}) async {
    print("hello");
    try {
      http.Response res = await http.post(Uri.parse(invisibletouserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"puid": puid, "id": value}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future boosttouser({required String puid, required String value}) async {
    print("hello");
    try {
      http.Response res = await http.post(Uri.parse(boosttouserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"puid": puid, "id": value}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createeditprofile(
      {required String userid,
      required String aboutme,
      required String mypreference,
      required bool isBlur,
      required String editname,
      required String dob,
      required String gender,
      required String phone,
      required String timeofbirth,
      required String placeofbirth,
      required String kundalidosh,
      required String martialstatus,
      required String profession,
      required String location1,
      required String city,
      required String state,
      required String country,
      required String name,
      required String surname,
      required double lat,
      required double lng,
      required String diet,
      required String disability,
      required String puid,
      required String drink,
      required String education,
      required String height,
      required String religion,
      required String income,
      required List<dynamic> imageurls}) async {
    try {
      print("****************");
      print(mypreference);
      http.Response res = await http.post(Uri.parse(createeditprofileurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "userid": userid,
            "patnerpref": mypreference,
            "aboutme": aboutme,
            "editname": editname,
            "dateofbirth": dob.toString(),
            "images": imageurls,
            "isBlur": isBlur,
            "gender": gender!,
            "phone": phone,
            "timeofbirth": timeofbirth,
            "placeofbirth": placeofbirth,
            "kundalidosh": kundalidosh,
            "martialstatus": martialstatus,
            "profession": profession,
            "religion": religion,
            "location1": location1,
            "city": city,
            "state": state,
            "country": country,
            "name": name,
            "surname": surname,
            "lat": lat,
            "lng": lng,
            "diet": diet,
            "age": "",
            "disability": disability,
            "puid": puid,
            "drink": drink,
            "education": education,
            "height": height,
            "income": income
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateeditstatus({
    required String email,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(updateeditstatusurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("clear token successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future boosttoallprofile(
      {required String value, required String gender}) async {
    try {
      http.Response res = await http.post(Uri.parse(boosttoalluserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": value, "gender": gender}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future invisibletoallprofile({required String value, required BuildContext context}) async {
    try {
      http.Response res = await http.post(Uri.parse(invisibletoalluserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": value}));
      if (res.statusCode == 200) {
        print(res.body);
          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Invisible for All Successfully",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 2,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getmaintenance() async {
    var data;
    try {
      http.Response res = await http.get(
        Uri.parse(getmaintenanceurl),
        headers: {'Content-Type': 'Application/json'},
      );
      if (res.statusCode == 200) {
        data = jsonDecode(res.body);
      } else {
        print(res.body);
      }
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future getreview({required String email}) async {
    var data;
    try {
      http.Response res = await http.post(Uri.parse(getreviews),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"useremail": email}));
      if (res.statusCode == 200) {
        print("res");
        print(res.body);
        data = jsonDecode(res.body);
      } else {
        print(res.body);
      }
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserSearchModel>> getsearchuser({required String id}) async {
    List<UserSearchModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getallsearchuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id}));
      print("**********");
      print(response.body);
      print("**********");
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(UserSearchModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<List<BioDataModel>> getbiodatauser({required String id}) async {
    List<BioDataModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getallbiodataurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"userid": id}));
      print("**********");
      print(response.body);
      print("**********");
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              BioDataModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<List<VerifyUserModel>> getverifyuser({required String id}) async {
    List<VerifyUserModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getverifyuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"userid": id}));
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(VerifyUserModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<void> createbiodataprofile({
    required String editname,
    required String userid,
    required String patnerpref,
    required String aboutme,
    required List<dynamic> images,
    required String education,
    required String profession,
  }) async {
    try {
      print("****************");
      print(userSave.dob);
      http.Response res = await http.post(Uri.parse(createbiodataeurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "userid": userid,
            "patnerpref": patnerpref,
            "aboutme": aboutme,
            "editname": editname,
            "images": images,
            "profession": profession,
            "education": education,
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<HistorySavePref>> getsavepref({required String id}) async {
    List<HistorySavePref> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getallsaveprefurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id}));
      print("**********fdgd");
      print(response.body);
      print("**********fasdf");
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(HistorySavePref.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<List<KundliMatchHistoryModel>> getkundlimatch(
      {required String id}) async {
    List<KundliMatchHistoryModel> getallusersdata = [];
    try {
      http.Response response = await http.post(
          Uri.parse(getallkundlihistoryurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id}));
      print("**********fdgd");
      print(response.body);
      print("**********fasdf");
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(KundliMatchHistoryModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  void addtokundaliprofile(
      {required String gname,
      required String gday,
      required String gmonth,
      required String gyear,
      required String ghour,
      required String gplace,
      required String uid,
      required String name,
      required String gsec,
      required String bname,
      required String bday,
      required String bmonth,
      required String byear,
      required String bhour,
      required String bsec,
      required String bplace,
      required String totalgun,
      required String bam,
      required String gkundli,
      required String bkundli,
      required String gam}) async {
    try {
      http.Response res = await http.post(Uri.parse(addtokundaliprofileurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "gname": gname,
            "gday": gday,
            "gplace": gplace,
            "bam": bam,
            "gam": gam,
            "gmonth": gmonth,
            "gyear": gyear,
            "gkundli": gkundli,
            "bkundli": bkundli,
            "ghour": ghour,
            "gsec": gsec,
            "bname": bname,
            "bday": bday,
            "bmonth": bmonth,
            "byear": byear,
            "bhour": bhour,
            "bsec": bsec,
            "bplace": bplace,
            "totalgun": totalgun,
            "name": name,
            "userid": uid
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("updatelogin  successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
