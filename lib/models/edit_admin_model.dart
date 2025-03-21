import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditAdminModel {
  final String email;
  final double lat;
  final double lng;
  final String username;
  final List<dynamic> permissions;
  final String token;
  final String isLogOut;
  final String editname;
  final String createdAt;
  EditAdminModel( {
    required this.email,
    required this.lat,
    required this.permissions,
    required this.lng,
    required this.username,
    required this.editname,
    required this.token,
    required this.isLogOut,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'lat': lat,
      'lng': lng,
      'username': username,
      'token':token
    };
  }

  factory EditAdminModel.fromMap(Map<String, dynamic> map) {
    return EditAdminModel(
      email: map['email'] as String,
      username: map['username'] as String,
      token: map['token'] as String,
      isLogOut: map['isLogOut'] as String,
      editname: map['editname'] as String,
      createdAt: map['createdAt'] as String,
       permissions: List<dynamic>.from((map['permissions'] as List<dynamic>)),
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditAdminModel.fromJson(String source) => EditAdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
