import 'dart:convert';

import 'package:matrimony_admin/models/shared_pref.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/user_model.dart';
import 'package:http/http.dart' as http;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> scrollKey = GlobalKey<ScaffoldState>();
String? deviceToken;
// bool color_done = false;
bool isLogin = false;
var uid = "";
User userSave = User(); //data of user
SharedPref sharedPref = SharedPref();
List<dynamic>? friends = []; //sent requests
List<dynamic>? friendr = []; //received requests
List<dynamic>? frienda = []; //accepted requests
List<dynamic>? friendrej = []; //rejected requests
FriendList? fl; //friend list
Blocklist? bl; //block list
List<dynamic>? listofadminpermissions=[];
List<dynamic>? selectedCounty=[];
List<dynamic>? selectedCity=[];
List<dynamic>? selectedState=[];
List<dynamic>? blocFriend = []; //blocked users
ReportList? rl; //block list
List<dynamic>? reportFriend = []; //blocked users
ReportList? sl; //block list
List<dynamic>? shortFriend = []; //blocked users
String uploadimageurl="";
String videoimageurl="";
String audiourl="";
ImageList imgDict = ImageList();
String profileType="";
String newProfileType="";
String secondProfileType="";
String thirdProfileType="";
Color main_color = Color(0xFF38B9F4);
Color textColor = Color(0xFF9D9A9A);
Color newtextColor=const Color(0xFF999999);

SavedPref savedPref = SavedPref();
var fontSize2 = 16;
var fontSize1 = 20;
List<String> yearList = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
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
  bool isUrl(String text) {
  final Uri? uri = Uri.tryParse(text);
  return uri != null && (uri.isAbsolute && uri.hasScheme && uri.hasAuthority);
}

bool isImageUrl(String url) {
  final RegExp imageRegExp = RegExp(r'\.(jpg|jpeg|png|gif|bmp|webp)$', caseSensitive: false);
  return imageRegExp.hasMatch(url);
}

bool isVideoUrl(String url) {
  final RegExp videoRegExp = RegExp(r'\.(mp4|avi|mov|wmv|flv|mkv|webm)$', caseSensitive: false);
  return videoRegExp.hasMatch(url);
}

bool isAudioUrl(String url) {
  final RegExp audioRegExp = RegExp(r'\.(mp3|wav|aac|flac|ogg|m4a)$', caseSensitive: false);
  return audioRegExp.hasMatch(url);
}

String identifyTextType(String text) {
  if (isUrl(text)) {
    if (isImageUrl(text)) {
      return "Image URL";
    } else if (isVideoUrl(text)) {
      return "Video URL";
    } else if (isAudioUrl(text)) {
      return "Audio URL";
    } else {
      return "Website URL";
    }
  } else {
    return "Simple Text";
  }
}
