import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdsModel {
  final String image;
   final String createdAt;
   final int seen;
   final int clicked;
   final String adsid;
   final String id;
   final String description;
   final String video;
   final String name;
   final bool isActive;
  AdsModel( {
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this. seen,
    required this. clicked,
    required this.adsid,
    required this.id,
    required this.description,
    required this.video,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'createdAt': createdAt,
      'adsid': adsid,
      '_id':id,
      
    };
  }

  factory AdsModel.fromMap(Map<String, dynamic> map) {
    return AdsModel(
      image: map['image'] as String,
      createdAt: map['createdAt'] as String,
      seen: map['seen'] as int,
      clicked: map['clicked'] as int,
      adsid: map['adsid'] as String,
      isActive: map['isActive'] as bool,
      id:map['_id']as String,
      description:map['description']as String,
      video:map['video']as String,
      name:map['name']as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdsModel.fromJson(String source) => AdsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
