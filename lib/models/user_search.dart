import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserSearchModel {
   String? searchidprofile;
   String? searchDistance;
   String? age;
  String? religion;
 String? kundlidosh;
 String ? marital_status; 
 String? diet;
 String? smoke;
 String? drink;
 String? disability;
 String? height;
 String? education;
 String? profession;
 String? income;
 String? location;
 String? userid;
 String? createdAt;
 String ? name;
 List<dynamic>? location1;
 List<dynamic>? citylocation;
 List<dynamic>? statelocation;

  UserSearchModel({
    this.searchidprofile,
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
    this.userid,
    this.createdAt,
    this.name,
    this.citylocation,
    this.location1,
    this.statelocation
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
      'userid': userid,
      'createdAt':createdAt,
      'name':name,

    };
  }

  factory UserSearchModel.fromMap(Map<String, dynamic> map) {
    return UserSearchModel(
      searchidprofile: map['searchidprofile'] != null ? map['searchidprofile'] as String : null,
      searchDistance: map['searchDistance'] != null ? map['searchDistance'] as String : null,
      age: map['age'] != null ? map['age'] as String : null,
      religion: map['religion'] != null ? map['religion'] as String : null,
      kundlidosh: map['kundlidosh'] != null ? map['kundlidosh'] as String : null,
      marital_status: map['marital_status'] != null ?  map['marital_status'] as String : null,
      diet: map['diet'] != null ? map['diet'] as String : null,
      smoke: map['smoke'] != null ? map['smoke'] as String : null,
      drink: map['drink'] != null ? map['drink'] as String : null,
      disability: map['disability'] != null ? map['disability'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      profession: map['profession'] != null ? map['profession'] as String : null,
      income: map['income'] != null ? map['income'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      location1: List<dynamic>.from((map['location1'] as List<dynamic>)),
      citylocation: List<dynamic>.from((map['citylocation'] as List<dynamic>)),
      statelocation: List<dynamic>.from((map['statelocation'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSearchModel.fromJson(String source) => UserSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
