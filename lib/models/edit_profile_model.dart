import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditProfileModel {
  final  String userid;

  final String? aboutme;
  final String? diet;
  final String? disability;
  final String? drink;
  final double? lng;
  final String? education;
  final String puid;
  final String? height;
  final String? income;
  final String? patnerpref;
  final String religion;
  final String name;
  final String? dateofbirth;
  final String surname;
  final String phone;
  final String gender;
  final String kundalidosh;
  final String martialstatus;
  final double lat;
  final String profession;
  final String timeofbirth;
  final String placeofbirth;
  final String country;
  final String location1;
  final String city;
  final String state;
 final List<dynamic> images;
 final bool isBlur;
final String createdAt;
final String? editname;
  EditProfileModel({
    required this.userid,
    this.aboutme,
    this.dateofbirth,
    this.diet,
    required this.disability,
    this.drink,
    this.education,
    required this.puid,
    this.height,
    this.income,
    this.editname,
    this.patnerpref,
    required this.lng,
  required this.createdAt,
    required this.religion,
    required this.name,
    required this.surname,
    required this.phone,
    required this.gender,
    required this.kundalidosh,
    required this.martialstatus,
    required this.lat,
    required this.profession,
    required this.timeofbirth,
    required this.placeofbirth,
    required this.country,
    required this.location1,
    required this.city,
    required this.state,
    required this.images,
    required this.isBlur,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'aboutme': aboutme,
      'diet': diet,
      'disability': disability,
      'drink': drink,
      'education': education,
      'puid': puid,
      'lng': lng,
      'height': height,
      'income': income,
      'patnerpref': patnerpref,
   'dateofbith':dateofbirth,
      'religion': religion,
      'name': name,
      'surname': surname,
      'editname': editname,
      'phone': phone,
      'gender': gender,
      'kundalidosh': kundalidosh,
      'martialstatus': martialstatus,
      'lat': lat,
      'profession': profession,
      'timeofbirth': timeofbirth,
      'placeofbirth': placeofbirth,
      'country': country,
      'location1': location1,
      'city': city,
      'state': state,
      'images': images,
      'isBlur': isBlur,
    };
  }

  factory EditProfileModel.fromMap(Map<String, dynamic> map) {
    return EditProfileModel(
      userid: map['userid'] as String,
      lng: map['lng'] as double,
      aboutme: map['aboutme'] != null ? map['aboutme'] as String : null,
      patnerpref: map['patnerpref'] != null ? map['patnerpref'] as String : null,
      diet: map['diet'] != null ? map['diet'] as String : null,
      disability: map['disability'] != null ? map['disability'] as String : null,
      dateofbirth: map['dateofbirth'] != null ? map['dateofbirth'] as String : null,
      drink: map['drink'] != null ? map['drink'] as String : null,
      editname: map['editname'] != null ? map['editname'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      puid: map['puid'] as String,
      height: map['height'] != null ? map['height'] as String : null,
      income: map['income'] != null ? map['income'] as String : null,
     
      religion: map['religion'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      kundalidosh: map['kundalidosh'] as String,
      martialstatus: map['martialstatus'] as String,
      createdAt: map['createdAt'] as String,
      lat: map['lat'] as double,
      profession: map['profession'] as String,
      timeofbirth: map['timeofbirth'] as String,
      placeofbirth: map['placeofbirth'] as String,
      country: map['country'] as String,
      location1: map['location1'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
      isBlur: map['isBlur'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileModel.fromJson(String source) => EditProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
