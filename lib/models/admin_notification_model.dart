import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminNotificationModel {
  final String userid;
  final String userimage;
  final String email;
  final String createdAt;
  final String title;
  AdminNotificationModel({
    required this.userid,
    required this.userimage,
    required this.email,
    required this.createdAt,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'userimage': userimage,
      'useremail': email,
      'createdAt': createdAt,
      'title':title
    };
  }

  factory AdminNotificationModel.fromMap(Map<String, dynamic> map) {
    return AdminNotificationModel(
      userid: map['userid'] as String,
      userimage: map['userimage'] as String,
      email: map['useremail'] as String,
      createdAt: map['createdAt'] as String,
      title:map['title']as String
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminNotificationModel.fromJson(String source) => AdminNotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
