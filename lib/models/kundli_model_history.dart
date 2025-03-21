import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class KundliMatchHistoryModel {
  final String gname;
 final String gday;
 final String gmonth;
 final String gyear;
 final String ghour;
 final String gsec;
 final String bname;
 final String bday;
 final String bmonth;
 final String byear;
 final String bhour;
 final String bsec;
 final String bplace;
 final String userid;
 final String gplace;
 final String totalgun;
 final String createdAt;
 final String name;
 final String bam;
 final String gam;
 final String gkundli;
 final String bkundli;
  KundliMatchHistoryModel({
    required this.gname,
    required this.gday,
    required this.totalgun,
    required this.gmonth,
    required this.gyear,
    required this.ghour,
    required this.bam,
    required this.gam,
    required this.gsec,
    required this.name,
    required this.bname,
    required this.bday,
    required this.bmonth,
    required this.byear,
    required this.bhour,
    required this.bsec,
    required this.createdAt,
    required this.bplace,
    required this.userid,
    required this.gplace,
    required this.gkundli,
    required this.bkundli,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gname': gname,
      'gday': gday,
      'gmonth': gmonth,
      'gyear': gyear,
      'ghour': ghour,
      'gsec': gsec,
      'bname': bname,
      'bday': bday,
      'bmonth': bmonth,
      'byear': byear,
      'bhour': bhour,
      'bsec': bsec,
      'bplace': bplace,
      'userid': userid,
      'totalgun':totalgun,
      'gplace': gplace,
      'createdAt':createdAt,
      'name':name,
      'gam':gam,
      'bam':bam
    };
  }

  factory KundliMatchHistoryModel.fromMap(Map<String, dynamic> map) {
    return KundliMatchHistoryModel(
      gname: map['gname'] as String,
      gday: map['gday'] as String,
      gmonth: map['gmonth'] as String,
      gyear: map['gyear'] as String,
      ghour: map['ghour'] as String,
      gam: map['gam'] as String,
      bam: map['bam'] as String,
      gsec: map['gsec'] as String,
      bname: map['bname'] as String,
      bday: map['bday'] as String,
      name: map['name'] as String,
      bmonth: map['bmonth'] as String,
      byear: map['byear'] as String,
      bhour: map['bhour'] as String,
      bsec: map['bsec'] as String,
      bplace: map['bplace'] as String,
      userid: map['userid'] as String,
      gplace: map['gplace'] as String,
      totalgun: map['totalgun'] as String,
      createdAt: map['createdAt'] as String,
       gkundli: map['gkundli'] as String,
      bkundli: map['bkundli'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory KundliMatchHistoryModel.fromJson(String source) => KundliMatchHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
