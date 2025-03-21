import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BioDataModel {
  final String aboutme;
  final String patnerpref;
  final String profession;
  final String education;
  final String editname;
  final String createdAt;
  final List<dynamic> images;
  BioDataModel({
    required this.aboutme,
    required this.patnerpref,
    required this.profession,
    required this.education,
    required this.editname,
    required this.createdAt,
    required this.images,
  });
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutme': aboutme,
      'patnerpref': patnerpref,
      'profession': profession,
      'education': education,
      'editname': editname,
      'images': images,
    };
  }

  factory BioDataModel.fromMap(Map<String, dynamic> map) {
    return BioDataModel(
      aboutme: map['aboutme'] as String,
      patnerpref: map['patnerpref'] as String,
      profession: map['profession'] as String,
      createdAt: map['createdAt'] as String,
      education: map['education'] as String,
      editname: map['editname'] as String,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BioDataModel.fromJson(String source) => BioDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
