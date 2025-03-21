import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HistorySavePref {
  final List<dynamic> ageList;
  final List<dynamic> citylocation;
  final List<dynamic> religionList;
  final List<dynamic> kundaliDoshList;
  final List<dynamic> drinkList;
  final List<dynamic> maritalStatusList;
  final List<dynamic> dietList;
  final List<dynamic> smokeList;
  final List<dynamic> disabilityList;
  final List<dynamic> heightList;
   final List<dynamic> educationList;
    final List<dynamic> professionList;
     final List<dynamic> incomeList;
     final List<dynamic> statelocation;
     final List<dynamic> location;
     final String createdAt;
     final String name;
  HistorySavePref({
    required this.createdAt, 
    required this.ageList,
    required this.citylocation,
    required this.religionList,
    required this.kundaliDoshList,
    required this.drinkList,
    required this.maritalStatusList,
    required this.dietList,
    required this.smokeList,
    required this.disabilityList,
    required this.heightList,
    required this.educationList,
    required this.professionList,
    required this.incomeList,
    required this.statelocation,
    required this.name,
    required this.location
  });
   
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ageList': ageList,
      'citylocation': citylocation,
      'religionList': religionList,
      'kundaliDoshList': kundaliDoshList,
      'drinkList': drinkList,
      'maritalStatusList': maritalStatusList,
      'dietList': dietList,
      'smokeList': smokeList,
      'disabilityList': disabilityList,
      'heightList': heightList,
      'educationList': educationList,
      'professionList': professionList,
      'incomeList': incomeList,
      'createdAt':createdAt,
      'statelocation': statelocation,
      'name':name,
      'location':location,
    };
  }

  factory HistorySavePref.fromMap(Map<String, dynamic> map) {
    return HistorySavePref(
      location:List<dynamic>.from((map['location'] as List<dynamic>)) ,
      ageList: List<dynamic>.from((map['ageList'] as List<dynamic>)),
      createdAt: map['createdAt']  as String,
      name: map['name']  as String,
      citylocation: List<dynamic>.from((map['citylocation'] as List<dynamic>)),
      religionList: List<dynamic>.from((map['religionList'] as List<dynamic>)),
      kundaliDoshList: List<dynamic>.from((map['kundaliDoshList'] as List<dynamic>)),
      drinkList: List<dynamic>.from((map['drinkList'] as List<dynamic>)),
      maritalStatusList: List<dynamic>.from((map['maritalStatusList'] as List<dynamic>)),
      dietList: List<dynamic>.from((map['dietList'] as List<dynamic>)),
      smokeList: List<dynamic>.from((map['smokeList'] as List<dynamic>)),
      disabilityList: List<dynamic>.from((map['disabilityList'] as List<dynamic>)),
      heightList: List<dynamic>.from((map['heightList'] as List<dynamic>)),
      educationList: List<dynamic>.from((map['educationList'] as List<dynamic>)),
      professionList: List<dynamic>.from((map['professionList'] as List<dynamic>)),
      incomeList: List<dynamic>.from((map['incomeList'] as List<dynamic>)),
      statelocation: List<dynamic>.from((map['statelocation'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory HistorySavePref.fromJson(String source) => HistorySavePref.fromMap(json.decode(source) as Map<String, dynamic>);
}
