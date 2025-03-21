import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteUser {
  String id;
  String aboutMe;
  String diet;
  int age;
  String disability;
  String puid;
  String drink;
  String education;
  String height;
  String income;
  String partnerPrefs;
  String smoke;
  String displayName;
  String email;
  String religion;
  String name;
  String surname;
  double lat;
  double lng;
  String gender;
  String phone;
  String timeOfBirth;
  String placeOfBirth;
  String kundaliDosh;
  String maritalStatus;
  String profession;
  String location;
  String city;
  String state;
  String country;
  String token;
  double dob;
  String status;
  String verifiedStatus;
  String videoLink;
  String videoName;
  List<dynamic> imageUrls;
  List<dynamic> blockLists;
  List<dynamic> reportList;
  List<dynamic> shortList;
  List<dynamic> friends;
  List<dynamic> pendingReq;
  List<dynamic> sendReq;
  String reasonToDeleteUser;
  List<dynamic> notifications;
  List<dynamic> chats;
  List<dynamic> activities;
  DateTime createdAt;
  DateTime updatedAt;
  bool chatNow;
  bool downloadBiodata;
  bool freePersonMatch;
  bool isBlur;
  bool marriageLoan;
  bool onlineUser;
  int share;
  int support;
  double adminLat;
  double adminLng;
  String editStatus;
  String location1;
  List<dynamic> showAds;
  bool isLogOut;
  int numOfInterest;
  int numOfProfileViewed;
  int numOfProfileViewer;
  String otp;
  DeleteUser({
    required this.id,
    required this.aboutMe,
    required this.diet,
    required this.age,
    required this.disability,
    required this.puid,
    required this.drink,
    required this.education,
    required this.height,
    required this.income,
    required this.partnerPrefs,
    required this.smoke,
    required this.displayName,
    required this.email,
    required this.religion,
    required this.name,
    required this.surname,
    required this.lat,
    required this.lng,
    required this.gender,
    required this.phone,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.kundaliDosh,
    required this.maritalStatus,
    required this.profession,
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.token,
    required this.dob,
    required this.status,
    required this.verifiedStatus,
    required this.videoLink,
    required this.videoName,
    required this.imageUrls,
    required this.blockLists,
    required this.reportList,
    required this.shortList,
    required this.friends,
    required this.pendingReq,
    required this.sendReq,
    required this.reasonToDeleteUser,
    required this.notifications,
    required this.chats,
    required this.activities,
    required this.createdAt,
    required this.updatedAt,
    required this.chatNow,
    required this.downloadBiodata,
    required this.freePersonMatch,
    required this.isBlur,
    required this.marriageLoan,
    required this.onlineUser,
    required this.share,
    required this.support,
    required this.adminLat,
    required this.adminLng,
    required this.editStatus,
    required this.location1,
    required this.showAds,
    required this.isLogOut,
    required this.numOfInterest,
    required this.numOfProfileViewed,
    required this.numOfProfileViewer,
    required this.otp,
  });

  

  factory DeleteUser.fromMap(Map<String, dynamic> json) {
    return DeleteUser(
      id: json['_id'],
      aboutMe: json['aboutme'],
      diet: json['diet'],
      age: json['age'],
      disability: json['disability'],
      puid: json['puid'],
      drink: json['drink'],
      education: json['education'],
      height: json['height'],
      income: json['income'],
      partnerPrefs: json['patnerprefs'],
      smoke: json['smoke'],
      displayName: json['displayname'],
      email: json['email'],
      religion: json['religion'],
      name: json['name'],
      surname: json['surname'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      gender: json['gender'],
      phone: json['phone'],
      timeOfBirth: json['timeofbirth'],
      placeOfBirth: json['placeofbirth'],
      kundaliDosh: json['kundalidosh'],
      maritalStatus: json['martialstatus'],
      profession: json['profession'],
      location: json['location'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      token: json['token'],
      dob: double.parse(json['dob']),
      status: json['status'],
      verifiedStatus: json['verifiedstatus'],
      videoLink: json['videolink'],
      videoName: json['videoname'],
      imageUrls: json['imageurls'],
      blockLists: json['blocklists'],
      reportList: json['reportlist'],
      shortList: json['shortlist'],
      friends: json['friends'],
      pendingReq: json['pendingreq'],
      sendReq: json['sendreq'],
      reasonToDeleteUser: json['reasontodeleteuser'],
      notifications: json['notifications'],
      chats: json['chats'],
      activities: json['activities'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['createdAt'])),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['updatedAt'])),
      chatNow: json['chatnow'] == 1 ? true : false,
      downloadBiodata: json['downloadbiodata'],
      freePersonMatch: json['freepersonmatch'] == 1 ? true : false,
      isBlur: json['isBlur'],
      marriageLoan: json['marriageloan'] == 1 ? true : false,
      onlineUser: json['onlineuser'],
      share: json['share'],
      support: json['support'],
      adminLat: double.parse(json['adminlat']),
      adminLng: double.parse(json['adminlng']),
      editStatus: json['editstatus'],
      location1: json['location1'],
      showAds: json['showads'],
      isLogOut: json['isLogOut'] == "true" ? true : false,
      numOfInterest: json['numofinterest'],
      numOfProfileViewed: json['numofprofileviewed'],
      numOfProfileViewer: json['numofprofileviewer'],
      otp: json['otp'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'aboutMe': aboutMe,
  //     'diet': diet,
  //     'age': age,
  //     'disability': disability,
  //     'puid': puid,
  //     'drink': drink,
  //     'education': education,
  //     'height': height,
  //     'income': income,
  //     'partnerPrefs': partnerPrefs,
  //     'smoke': smoke,
  //     'displayName': displayName,
  //     'email': email,
  //     'religion': religion,
  //     'name': name,
  //     'surname': surname,
  //     'lat': lat,
  //     'lng': lng,
  //     'gender': gender,
  //     'phone': phone,
  //     'timeOfBirth': timeOfBirth,
  //     'placeOfBirth': placeOfBirth,
  //     'kundaliDosh': kundaliDosh,
  //     'maritalStatus': maritalStatus,
  //     'profession': profession,
  //     'location': location,
  //     'city': city,
  //     'state': state,
  //     'country': country,
  //     'token': token,
  //     'dob': dob,
  //     'status': status,
  //     'verifiedStatus': verifiedStatus,
  //     'videoLink': videoLink,
  //     'videoName': videoName,
  //     'imageUrls': imageUrls,
  //     'blockLists': blockLists,
  //     'reportList': reportList,
  //     'shortList': shortList,
  //     'friends': friends,
  //     'pendingReq': pendingReq,
  //     'sendReq': sendReq,
  //     'reasonToDeleteUser': reasonToDeleteUser,
  //     'notifications': notifications,
  //     'chats': chats,
  //     'activities': activities,
  //     'createdAt': createdAt.millisecondsSinceEpoch,
  //     'updatedAt': updatedAt.millisecondsSinceEpoch,
  //     'chatNow': chatNow,
  //     'downloadBiodata': downloadBiodata,
  //     'freePersonMatch': freePersonMatch,
  //     'isBlur': isBlur,
  //     'marriageLoan': marriageLoan,
  //     'onlineUser': onlineUser,
  //     'share': share,
  //     'support': support,
  //     'adminLat': adminLat,
  //     'adminLng': adminLng,
  //     'editStatus': editStatus,
  //     'location1': location1,
  //     'showAds': showAds,
  //     'isLogOut': isLogOut,
  //     'numOfInterest': numOfInterest,
  //     'numOfProfileViewed': numOfProfileViewed,
  //     'numOfProfileViewer': numOfProfileViewer,
  //     'otp': otp,
  //   };
  // }

  // factory DeleteUser.fromMap(Map<String, dynamic> map) {
  //   return DeleteUser(
  //     id: map['id'] as String,
  //     aboutMe: map['aboutMe'] as String,
  //     diet: map['diet'] as String,
  //     age: map['age'] as int,
  //     disability: map['disability'] as String,
  //     puid: map['puid'] as String,
  //     drink: map['drink'] as String,
  //     education: map['education'] as String,
  //     height: map['height'] as String,
  //     income: map['income'] as String,
  //     partnerPrefs: map['partnerPrefs'] as String,
  //     smoke: map['smoke'] as String,
  //     displayName: map['displayName'] as String,
  //     email: map['email'] as String,
  //     religion: map['religion'] as String,
  //     name: map['name'] as String,
  //     surname: map['surname'] as String,
  //     lat: map['lat'] as double,
  //     lng: map['lng'] as double,
  //     gender: map['gender'] as String,
  //     phone: map['phone'] as String,
  //     timeOfBirth: map['timeOfBirth'] as String,
  //     placeOfBirth: map['placeOfBirth'] as String,
  //     kundaliDosh: map['kundaliDosh'] as String,
  //     maritalStatus: map['maritalStatus'] as String,
  //     profession: map['profession'] as String,
  //     location: map['location'] as String,
  //     city: map['city'] as String,
  //     state: map['state'] as String,
  //     country: map['country'] as String,
  //     token: map['token'] as String,
  //     dob: map['dob'] as double,
  //     status: map['status'] as String,
  //     verifiedStatus: map['verifiedStatus'] as String,
  //     videoLink: map['videoLink'] as String,
  //     videoName: map['videoName'] as String,
  //     imageUrls: List<dynamic>.from((map['imageUrls'] as List<dynamic>),
  //     blockLists: List<dynamic>.from((map['blockLists'] as List<dynamic>),
  //     reportList: List<dynamic>.from((map['reportList'] as List<dynamic>),
  //     shortList: List<dynamic>.from((map['shortList'] as List<dynamic>),
  //     friends: List<dynamic>.from((map['friends'] as List<dynamic>),
  //     pendingReq: List<dynamic>.from((map['pendingReq'] as List<dynamic>),
  //     sendReq: List<dynamic>.from((map['sendReq'] as List<dynamic>),
  //     reasonToDeleteUser: map['reasonToDeleteUser'] as String,
  //     notifications: List<dynamic>.from((map['notifications'] as List<dynamic>),
  //     chats: List<dynamic>.from((map['chats'] as List<dynamic>),
  //     activities: List<dynamic>.from((map['activities'] as List<dynamic>),
  //     createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  //     updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
  //     chatNow: map['chatNow'] as bool,
  //     downloadBiodata: map['downloadBiodata'] as bool,
  //     freePersonMatch: map['freePersonMatch'] as bool,
  //     isBlur: map['isBlur'] as bool,
  //     marriageLoan: map['marriageLoan'] as bool,
  //     onlineUser: map['onlineUser'] as bool,
  //     share: map['share'] as int,
  //     support: map['support'] as int,
  //     adminLat: map['adminLat'] as double,
  //     adminLng: map['adminLng'] as double,
  //     editStatus: map['editStatus'] as String,
  //     location1: map['location1'] as String,
  //     showAds: List<dynamic>.from((map['showAds'] as List<dynamic>),
  //     isLogOut: map['isLogOut'] as bool,
  //     numOfInterest: map['numOfInterest'] as int,
  //     numOfProfileViewed: map['numOfProfileViewed'] as int,
  //     numOfProfileViewer: map['numOfProfileViewer'] as int,
  //     otp: map['otp'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  factory DeleteUser.fromJson(String source) => DeleteUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
