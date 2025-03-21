import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SendNotificationModel {
  final String name;
  final String email;
  final String title;
  final String heading;
  final String type;
  final String status;
  final String createdAt;
  SendNotificationModel({
    required this.name,
    required this.email,
    required this.title,
    required this.heading,
    required this.type,
    required this.status,
    required this.createdAt,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'title': title,
      'heading': heading,
      'type': type,
      'status': status,
    };
  }

  factory SendNotificationModel.fromMap(Map<String, dynamic> map) {
    return SendNotificationModel(
      name: map['name'] as String,
      email: map['email'] as String,
      title: map['title'] as String,
      heading: map['heading'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendNotificationModel.fromJson(String source) => SendNotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
