import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyUserModel {
  final String name;
  final String videoLink;
  final String createdAt;
  VerifyUserModel({
    required this.name,
    required this.videoLink,
    required this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'videoLink': videoLink,
      'createdAt': createdAt,
    };
  }

  factory VerifyUserModel.fromMap(Map<String, dynamic> map) {
    return VerifyUserModel(
      name: map['name'] as String,
      videoLink: map['videoLink'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyUserModel.fromJson(String source) => VerifyUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
