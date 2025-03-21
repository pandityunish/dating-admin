import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminSearchModel {
  String? searchidprofile;
  String? searchnameprofile;
  String? searchemailprofile;
  String? searchsurprofile;
  String? searchphoneprofile;
  String? searchDistance;
  String? age;
  String? religion;
  String? kundlidosh;
  String? marital_status;
  String? diet;
  String? smoke;
  String? drink;
  String? disability;
  String? height;
  String? education;
  String? profession;
  String? income;
  String? location;
  String? createdAt;
  String? adminname;

  AdminSearchModel({
    this.searchemailprofile,
    this.searchnameprofile,
    this.searchphoneprofile,
    this.searchsurprofile,
    this.searchidprofile,
    this.adminname,
    this.searchDistance,
    this.age,
    this.religion,
    this.kundlidosh,
    this.marital_status,
    this.diet,
    this.smoke,
    this.drink,
    this.disability,
    this.height,
    this.education,
    this.profession,
    this.income,
    this.location,
    this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'searchidprofile': searchidprofile,
      'searchDistance': searchDistance,
      'age': age,
      'religion': religion,
      'kundlidosh': kundlidosh,
      'marital_status': marital_status,
      'diet': diet,
      'smoke': smoke,
      'drink': drink,
      'disability': disability,
      'height': height,
      'education': education,
      'profession': profession,
      'income': income,
      'location': location,
      'createdAt': createdAt
    };
  }

  factory AdminSearchModel.fromMap(Map<String, dynamic> map) {
    return AdminSearchModel(
      searchidprofile: map['searchidprofile'] != null
          ? map['searchidprofile'] as String
          : null,
      searchemailprofile: map['searchemailprofile'] != null
          ? map['searchemailprofile'] as String
          : null,
      searchnameprofile: map['searchnameprofile'] != null
          ? map['searchnameprofile'] as String
          : null,
      searchphoneprofile: map['searchphoneprofile'] != null
          ? map['searchphoneprofile'] as String
          : null,
      searchsurprofile: map['searchsurnameprofile'] != null
          ? map['searchsurnameprofile'] as String
          : null,
      adminname: map['adminname'] != null ? map['adminname'] as String : null,
      searchDistance: map['searchDistance'] != null
          ? map['searchDistance'] as String
          : null,
      age: map['age'] != null ? map['age'] as String : null,
      religion: map['religion'] != null ? map['religion'] as String : null,
      kundlidosh:
          map['kundlidosh'] != null ? map['kundlidosh'] as String : null,
      marital_status: map['marital_status'] != null
          ? map['marital_status'] as String
          : null,
      diet: map['diet'] != null ? map['diet'] as String : null,
      smoke: map['smoke'] != null ? map['smoke'] as String : null,
      drink: map['drink'] != null ? map['drink'] as String : null,
      disability:
          map['disability'] != null ? map['disability'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      profession:
          map['profession'] != null ? map['profession'] as String : null,
      income: map['income'] != null ? map['income'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminSearchModel.fromJson(String source) =>
      AdminSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
