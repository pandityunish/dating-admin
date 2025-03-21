// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final newUserModel = newUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:matrimony_admin/models/activity_model.dart';
import 'package:matrimony_admin/models/ads_model.dart';
import 'package:matrimony_admin/models/chat_model.dart';

import 'notification_model.dart';
import 'unapprove_activites.dart';

class NewUserModel {
  String id;

  String? About_Me;
  String? Diet;
  String? Disability;
  String? Drink;
  String? Education;
  String? Height;
  String? Income;
  String? Partner_Prefs;
  String? Smoke;
  String displayname;
  String email;
  String religion;
  String name;
  String surname;
  String phone;
  String gender;
  String KundaliDosh;
  String MartialStatus;
  double? adminlat;
  double? adminlng;
  String Profession;
  String Location;
  String city;
  String state;
  String? isLogOut;
  List<dynamic> imageurls;
  List<dynamic> blocklists;
  List<dynamic> reportlist;
  List<dynamic> shortlist;
  String country;
  String token;
  String puid;
  int dob;
  String age;
  double lat;
  double lng;
  String placeofbirth;
  String timeofbirth;
  String verifiedstatus;
  List<dynamic> pendingreq;
  List<dynamic> sendreq;
  List<dynamic> friends;
  List<dynamic>? boostprofile;
  String videolink;
  String status;
  String? editstatus;
  String? offlinetime;
  bool? onlineuser;
  bool? downloadbiodata;
  int? support;
  int? chatnow;
  int? freepersonmatch;
  int? numberdownloadbiodata;
  int? marriageloan;
  int? profileverified;
  int? share;
  int? onlinenumbers;
  List<NotificationModel> notifications;
  String? createdAt;
  List<ChatsModel>? chats;
  bool ?isBlur;
  List<ActivitiesModel>? activities;
  List<AdsModel>? showads;
  List<UnapproveActivites> unapproveActivites;
  NewUserModel({
    required this.About_Me,
    required this.id,
    this.isBlur,
    this.showads,
    this.editstatus,
    this.activities,
     this.isLogOut,
    this.createdAt,
    this.profileverified,
     this.onlineuser,
     this.support,
     this.downloadbiodata,
     this.freepersonmatch,
     this.share,
     this.onlinenumbers,
     this.marriageloan,
     this.boostprofile,
this.chatnow,
    this.chats,
    this.offlinetime,
    this.numberdownloadbiodata,
    required this.Diet,
    required this.Disability,
    required this.Drink,
    required this.status,
    required this.Education,
    required this.Height,
    required this.Income,
    required this.placeofbirth,
    required this.timeofbirth,
    required this.Partner_Prefs,
    required this.Smoke,
    required this.displayname,
    required this.email,
    required this.religion,
    required this.name,
    required this.surname,
    required this.phone,
    required this.gender,
    required this.KundaliDosh,
    required this.MartialStatus,
    required this.Profession,
    required this.Location,
    required this.city,
    required this.state,
    required this.imageurls,
    required this.blocklists,
    required this.reportlist,
    required this.shortlist,
    required this.country,
    required this.token,
    required this.puid,
    required this.dob,
    required this.age,
    required this.adminlat,
    required this.adminlng,
    required this.lat,
    required this.lng,
    required this.verifiedstatus,
    required this.pendingreq,
    required this.sendreq,
    required this.friends,
    required this.videolink,
    required this.notifications,
    required this.unapproveActivites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      'notifications': notifications,
      'aboutme': About_Me,
      'editstatus':editstatus,
'showads':showads,
      'isBlur':isBlur,
      'timeofbirth': timeofbirth,
      'placeofbirth': placeofbirth,
      '_id': id,
      'adminlat': adminlat,
      'chatnow':chatnow,
      'downloadbiodata':downloadbiodata,
      'adminlng': adminlng,
      'support':support,
      'onlineuser':onlineuser,
      'chats': chats,
      'isLogOut':isLogOut,
      'createdAt': createdAt,
      'status': status,
      'pendingreq': pendingreq,
      'sendreq': sendreq,
      'puid': puid,
      'friends': friends,
      'videolink': videolink,
      'verifiedstatus': verifiedstatus,
      'diet': Diet,
      'disability': Disability,
      'lat': lat,
      'lng': lng,
      'drink': Drink,
      'education': Education,
      'height': Height,
      'income': Income,
      'patnerprefs': Partner_Prefs,
      'smoke': Smoke,
      'displayname': displayname,
      'email': email,
      'religion': religion,
      'name': name,
      'surname': surname,
      'phone': phone,
      'gender': gender,
      'kundalidosh': KundaliDosh,
      'martialstatus': MartialStatus,
      'profession': Profession,
      'location1': Location,
      'city': city,
      'state': state,
      'imageurls': imageurls,
      'blocklists': blocklists,
      'reportlist': reportlist,
      'shortlist': shortlist,
      'country': country,
      'token': token,
      'dob': dob,
      'share':share,
      'marriageloan':marriageloan,
      'freepersonmatch':freepersonmatch,
      'unapproveActivites':unapproveActivites,

    };
  }

  factory NewUserModel.fromMap(Map<String, dynamic> map) {
    return NewUserModel(
      age: map["age"] as String,
      timeofbirth: map["timeofbirth"] as String,
      placeofbirth: map["placeofbirth"] as String,
      About_Me: map['aboutme'] as String,
      adminlat: map['adminlat'] as double,
      adminlng: map['adminlng'] as double,
      isBlur:map['isBlur'] as bool,
      puid: map["puid"] as String,
      createdAt: map['createdAt'] as String,
      editstatus: map['editstatus'] as String,
      offlinetime: map['offlinetime'] as String,
      status: map['status'] as String,
      id: map['_id'] as String,
      verifiedstatus: map['verifiedstatus'] as String,
      videolink: map['videolink'] as String,
      Diet: map['diet'] as String,
      chatnow: map['chatnow'] as int,
      numberdownloadbiodata: map['numberdownloadbiodata'] as int,
      onlinenumbers: map['onlinenumbers'] as int,
       share: map['share'] as int,
       freepersonmatch: map['freepersonmatch'] as int,
       marriageloan: map['marriageloan'] as int,
      downloadbiodata: map['downloadbiodata'] as bool,
      support: map['support'] as int,
      onlineuser: map['onlineuser'] as bool,
      lng: map['lng'] as double,
      lat: map['lat'] as double,
      Disability: map['disability'] as String,
      Drink: map['drink'] as String,
      Education: map['education'] as String,
       isLogOut: map['isLogOut'] as String,
      Height: map['height'] as String,
      Income: map['income'] as String,
      Partner_Prefs: map['patnerprefs'] as String,
      Smoke: map['smoke'] as String,
      displayname: map['displayname'] as String,
      email: map['email'] as String,
      religion: map['religion'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      KundaliDosh: map['kundalidosh'] as String,
      MartialStatus: map['martialstatus'] as String,
      Profession: map['profession'] as String,
      Location: map['location1'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      chats: List<ChatsModel>.from(
        (map['chats'] as List<dynamic>).map<ChatsModel>(
          (x) => ChatsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sendreq: List<dynamic>.from((map['sendreq'] as List<dynamic>)),
      boostprofile: List<dynamic>.from((map['boostprofile'] as List<dynamic>)),
      friends: List<dynamic>.from((map['friends'] as List<dynamic>)),
      pendingreq: List<dynamic>.from((map['pendingreq'] as List<dynamic>)),
      imageurls: List<dynamic>.from((map['imageurls'] as List<dynamic>)),
      blocklists: List<dynamic>.from((map['blocklists'] as List<dynamic>)),
      reportlist: List<dynamic>.from((map['reportlist'] as List<dynamic>)),
      shortlist: List<dynamic>.from((map['shortlist'] as List<dynamic>)),
      showads:List<AdsModel>.from(
        (map['showads'] as List<dynamic>).map<AdsModel>(
          (x) => AdsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
       unapproveActivites:List<UnapproveActivites>.from(
        (map['unapproveacitivites'] as List<dynamic>).map<UnapproveActivites>(
          (x) => UnapproveActivites.fromMap(x as Map<String, dynamic>),
        ),
      ),
      country: map['country'] as String,
      token: map['token'] as String,
      dob: map['dob'] as int,
      notifications: List<NotificationModel>.from(
        (map['notifications'] as List<dynamic>).map<NotificationModel>(
          (x) => NotificationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
       activities: List<ActivitiesModel>.from((map['activities'] as List<dynamic>).map<ActivitiesModel>((x) => ActivitiesModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewUserModel.fromJson(String source) =>
      NewUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'aboutme': aboutme,
  //     'id': id,
  //     'diet': diet,
  //     'disability': disability,
  //     'drink': drink,
  //     'education': education,
  //     'height': height,
  //     'income': income,
  //     'patnerprefs': patnerprefs,
  //     'smoke': smoke,
  //     'displayname': displayname,
  //     'email': email,
  //     'religion': religion,
  //     'name': name,
  //     'surname': surname,
  //     'phone': phone,
  //     'gender': gender,
  //     'kundalidosh': kundalidosh,
  //     'martialstatus': martialstatus,
  //     'profession': profession,
  //     'location': location,
  //     'city': city,
  //     'state': state,
  //     'imageurls': imageurls,
  //     'blocklists': blocklists,
  //     'reportlist': reportlist,
  //     'shortlist': shortlist,
  //     'country': country,
  //     'token': token,
  //     'puid': puid,
  //     'dob': dob,
  //     'age': age,
  //     'lat': lat,
  //     'lng': lng,
  //     'verifiedstatus': verifiedstatus,
  //     'pendingreq': pendingreq,
  
  //     'sendreq': sendreq,
  //     'friends': friends,
  //     'videolink': videolink,
  //     'notifications': notifications.map((x) => x.toMap()).toList(),
  //     'activities': activities.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory NewUserModel.fromMap(Map<String, dynamic> map) {
  //   return NewUserModel(
  //     aboutme: map['aboutme'] as String,
  //     id: map['id'] as String,
  //     diet: map['diet'] as String,
  //     disability: map['disability'] as String,
  //     drink: map['drink'] as String,
  //     education: map['education'] as String,
  //     height: map['height'] as String,
  //     income: map['income'] as String,
  //     patnerprefs: map['patnerprefs'] as String,
  //     smoke: map['smoke'] as String,
  //     displayname: map['displayname'] as String,
  //     email: map['email'] as String,
  //     religion: map['religion'] as String,
  //     name: map['name'] as String,
  //     surname: map['surname'] as String,
  //     phone: map['phone'] as String,
  //     gender: map['gender'] as String,
  //     kundalidosh: map['kundalidosh'] as String,
  //     martialstatus: map['martialstatus'] as String,
  //     profession: map['profession'] as String,
  //     location: map['location'] as String,
  //     city: map['city'] as String,
  //     state: map['state'] as String,
  //     imageurls: List<dynamic>.from((map['imageurls'] as List<dynamic>)),
  //     blocklists: List<dynamic>.from((map['blocklists'] as List<dynamic>)),
  //     reportlist: List<dynamic>.from((map['reportlist'] as List<dynamic>)),
  //     shortlist: List<dynamic>.from((map['shortlist'] as List<dynamic>)),
  //     country: map['country'] as String,
  //     token: map['token'] as String,
  //     puid: map['puid'] as String,
  //     dob: map['dob'] as int,
  //     age: map['age'] as String,
  //     lat: map['lat'] as double,
  //     lng: map['lng'] as double,
  //     verifiedstatus: map['verifiedstatus'] as String,
  //     pendingreq: List<dynamic>.from((map['pendingreq'] as List<dynamic>)),
  //     sendreq: List<dynamic>.from((map['sendreq'] as List<dynamic>)),
  //     friends: List<dynamic>.from((map['friends'] as List<dynamic>)),
  //     videolink: map['videolink'] as String,
  //     notifications: List<NotificationModel>.from((map['notifications'] as List<int>).map<NotificationModel>((x) => NotificationModel.fromMap(x as Map<String,dynamic>),),),
  //     activities: List<ActivitiesModel>.from((map['activities'] as List<int>).map<ActivitiesModel>((x) => ActivitiesModel.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory NewUserModel.fromJson(String source) => NewUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
