import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SendLinkModel {
 final int aboutme;
   final int patnerpref;
   final int success;
   final int video;
   final int savepref;
   final int useapp;
   final int professionManually;
   final int educationManually;
   final int rating;
   final int photo;
   final int biodata;
   final int share;
   final int support;
   final String createdAt;
   final String name;
   final String status;
  SendLinkModel( {
    required this.aboutme,
    required this.patnerpref,
    required this.createdAt,
    required this.success,
    required this.video,
    required this.savepref,
    required this.useapp,
    required this.professionManually,
    required this.educationManually,
    required this.rating,
    required this.photo,
    required this.biodata,
    required this.share,
    required this.support,
    required this.name,
    required this.status
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutme': aboutme,
      'patnerpref': patnerpref,
      'success': success,
      'video': video,
      'savepref': savepref,
      'useapp': useapp,
      'professionManually': professionManually,
      'educationManually': educationManually,
      'rating': rating,
      'photo': photo,
      'biodata': biodata,
      'share': share,
      'support': support,
    };
  }

  factory SendLinkModel.fromMap(Map<String, dynamic> map) {
    return SendLinkModel(
      aboutme: map['aboutme'] as int,
      patnerpref: map['patnerpref'] as int,
      success: map['success'] as int,
      video: map['video'] as int,
      createdAt: map['createdAt'] as String,
      status: map['status'] as String,
      name: map['name'] as String,
      savepref: map['savepref'] as int,
      useapp: map['useapp'] as int,
      professionManually: map['professionManually'] as int,
      educationManually: map['educationManually'] as int,
      rating: map['rating'] as int,
      photo: map['photo'] as int,
      biodata: map['biodata'] as int,
      share: map['share'] as int,
      support: map['support'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendLinkModel.fromJson(String source) => SendLinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
