import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/models/user_model.dart';

import '../globalVars.dart';

class SearchFunctions {
  searchData(SavedPref svp,var gen) async {
    // var gen;
    SearchDataList sdl = SearchDataList();
    if (gen == "male") {
      gen = "female";
    } else {
      gen = "male";
    }
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection("user_data");
   
    Set commonData = {};
    //  var temp = [];
    //  var res = await query.where("status",isEqualTo: "").get();
    //  res.docs.forEach((element) {
    //     temp.add(element['uid']);
    //   });
    //   if (commonData.isEmpty) {
    //     commonData = temp.toSet();
    //     print("$commonData");
    //   } else {
    //     commonData = commonData.intersection(temp.toSet());
    //   }
    if (svp.SmokeList.isNotEmpty) {
      var res = await query.where('Smoke', whereIn: svp.SmokeList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print("$commonData");
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.AgeList.isNotEmpty) {
      // // print("drinklist : ${DrinkList.toString()}");
      DateTime currentDate = DateTime.now();
      DateTime iniDate = DateTime(
          currentDate.year - int.parse(svp.AgeList[0]),
          currentDate.month,
          currentDate.day,
          currentDate.hour,
          currentDate.minute,
          currentDate.second);
      DateTime finalDate = DateTime(
          currentDate.year - int.parse(svp.AgeList[1])-1,
          currentDate.month,
          currentDate.day,
          currentDate.hour,
          currentDate.minute,
          currentDate.second);

      int start = iniDate.millisecondsSinceEpoch;
      int last = finalDate.millisecondsSinceEpoch;
      // // print("$start, $last");
      var res = await query
          .where('dob', isGreaterThan: last)
          .where('dob', isLessThan: start)
          .get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.HeightList.isNotEmpty) {
      // // print("drinklist : ${DrinkList.toString()}");
      var temphtList = [];
      int start = int.parse(svp.HeightList[0]);
      int last = int.parse(svp.HeightList[1]);
      // print("$start ,$last");
      for (int i = start; i <= last; i++) {
        temphtList.add(sdl.Height[i]);
      }

      var res = await largeWherein(query, 'Height', temphtList);
      var temp = [];
      // res.docs.forEach((element) {
      res.forEach((element) {
        print(User.fromdoc(element).toString());
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print("1 : $commonData");
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.DrinkList.isNotEmpty) {
      // // print("drinklist : ${DrinkList.toString()}");
      // var res = await query.where('Drink', whereIn: svp.DrinkList).get();
      var res = await largeWherein(query, 'Drink', svp.DrinkList);

      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.ReligionList.isNotEmpty) {
      var res = await query.where('religion', whereIn: svp.ReligionList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('religion', whereIn: ReligionList);
    }
    if (svp.KundaliDoshList.isNotEmpty) {
      var res = await largeWherein(query, 'KundaliDosh', svp.KundaliDoshList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('KundaliDosh', whereIn: KundaliDoshList);
    }
    if (svp.MaritalStatusList.isNotEmpty) {
      // var res = await query
      //     .where('MartialStatus', whereIn: svp.MaritalStatusList)
      //     .get();
      var res =
          await largeWherein(query, 'MartialStatus', svp.MaritalStatusList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('MartialStatus', whereIn: MaritalStatusList);
    }
    if (svp.DisabilityList.isNotEmpty) {
      // var res =
      //     await query.where('Disability', whereIn: svp.DisabilityList).get();
      var res = await largeWherein(query, 'Disability', svp.DisabilityList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('Disability', whereIn: DisabilityList);
    }

    if (svp.dietList.isNotEmpty) {
      // var res = await query.where('Diet', whereIn: svp.dietList).get();
      var res = await largeWherein(query, 'Diet', svp.dietList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("diet list added");
      }
    }
    if (svp.EducationList.isNotEmpty) {
      // var res =
      //     await query.where('Education', whereIn: svp.EducationList).get();
      var res = await largeWherein(query, 'Education', svp.EducationList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("education list added");
      }
      // query = query.where('Education', whereIn: EducationList);
    }
    if (svp.ProfessionList.isNotEmpty) {
      // var res =
      //     await query.where('Profession', whereIn: svp.ProfessionList).get();
      var res = await largeWherein(query, 'Profession', svp.ProfessionList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("profession list added");
      }
      // query = query.where('Profession', whereIn: ProfessionList);
    }
     if (svp.LocatioList != null && svp.LocatioList[2].isNotEmpty) {
      var res;
      if (svp.LocatioList[1].isNotEmpty) {
        if (svp.LocatioList[0].isNotEmpty) {
          print("checking city data");
          // res = await query.where('city', whereIn: svp.LocatioList[0]).get();
          res = await largeWherein(query, 'city', svp.LocatioList[0]);
        } else {
          // res = await query.where('state', whereIn: svp.LocatioList[1]).get();
          res = await largeWherein(query, 'state', svp.LocatioList[1]);
        }
      } else {
        // res = await query.where('country', whereIn: svp.LocatioList[2]).get();
        res = await largeWherein(query, 'country', svp.LocatioList[2]);
      }
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        print("location list added");
      }
    }
    if (svp.IncomeList.isNotEmpty) {
      // var res = await query.where('Income', whereIn: svp.IncomeList).get();
      var res = await largeWherein(query, 'Income', svp.IncomeList);
      var temp = [];
      res.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // // print("Income list added");
      }
    }
    var result = await query.get();
    print("2 : ${commonData.toString()}");
    return commonData;
  }

  

  searchDefaultData(SavedPref svp) async {
    var gen;

    if (userSave.gender == "male") {
      gen = "female";
    } else {
      gen = "male";
    }
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection("user_data");
    query = query.where('gender', isEqualTo: gen);
    Set commonData = {};
    DateTime dob = DateTime.fromMillisecondsSinceEpoch(userSave.dob!);
    var age = calculateAge(dob);
    int ageStart;
    int ageEnd;
    if (userSave.gender == 'male') {
      ageEnd = age;
      if (age <= 24) {
        ageStart = 18;
      } else {
        ageStart = age - 6;
      }
    } else {
      ageEnd = age + 6;
      if (age >= 21) {
        ageStart = age;
      } else {
        ageStart = 21;
      }
    }
    DateTime currentDate = DateTime.now();
    DateTime iniDate = DateTime(
        currentDate.year - ageStart,
        currentDate.month,
        currentDate.day,
        currentDate.hour,
        currentDate.minute,
        currentDate.second);
    DateTime finalDate = DateTime(
        currentDate.year - ageEnd,
        currentDate.month,
        currentDate.day,
        currentDate.hour,
        currentDate.minute,
        currentDate.second);

    int start = iniDate.millisecondsSinceEpoch;
    int last = finalDate.millisecondsSinceEpoch;
    // // print("$start, $last");
    var res = await query
        .where('dob', isGreaterThan: last)
        .where('dob', isLessThan: start)
        .get();
    var temp = [];
    res.docs.forEach((element) {
      temp.add(element['uid']);
    });
    if (commonData.isEmpty) {
      commonData = temp.toSet();
      // // print(commonData);
    } else {
      commonData = commonData.intersection(temp.toSet());
    }
    // }
    if (svp.HeightList.isNotEmpty) {
      // // print("drinklist : ${DrinkList.toString()}");
      var temphtList = [];
      double start = double.parse(svp.HeightList[0]);
      double last = double.parse(svp.HeightList[1]);
      // print("$start ,$last");
      for (double i = start; i <= last; i += 0.1) {
        temphtList.add("${i.toStringAsFixed(1)} Feet");
      }
      // print(temphtList);
      var res = await query.where('Height', whereIn: temphtList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print("1 : $commonData");
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.DrinkList.isNotEmpty) {
      // // print("drinklist : ${DrinkList.toString()}");
      var res = await query.where('Drink', whereIn: svp.DrinkList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
    }
    if (svp.ReligionList.isNotEmpty) {
      var res = await query.where('religion', whereIn: svp.ReligionList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('religion', whereIn: ReligionList);
    }
    if (svp.KundaliDoshList.isNotEmpty) {
      var res =
          await query.where('KundaliDosh', whereIn: svp.KundaliDoshList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('KundaliDosh', whereIn: KundaliDoshList);
    }
    if (svp.MaritalStatusList.isNotEmpty) {
      var res = await query
          .where('MartialStatus', whereIn: svp.MaritalStatusList)
          .get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('MartialStatus', whereIn: MaritalStatusList);
    }
    if (svp.DisabilityList.isNotEmpty) {
      var res =
          await query.where('Disability', whereIn: svp.DisabilityList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
      }
      // query = query.where('Disability', whereIn: DisabilityList);
    }

    if (svp.dietList.isNotEmpty) {
      var res = await query.where('Diet', whereIn: svp.dietList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("diet list added");
      }
      // query = query.where('Diet', whereIn: dietList);
    }
    if (svp.EducationList.isNotEmpty) {
      var res =
          await query.where('Education', whereIn: svp.EducationList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("education list added");
      }
      // query = query.where('Education', whereIn: EducationList);
    }
    if (svp.ProfessionList.isNotEmpty) {
      var res =
          await query.where('Profession', whereIn: svp.ProfessionList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // print("profession list added");
      }
      // query = query.where('Profession', whereIn: ProfessionList);
    }
    if (svp.IncomeList.isNotEmpty) {
      var res = await query.where('Income', whereIn: svp.IncomeList).get();
      var temp = [];
      res.docs.forEach((element) {
        temp.add(element['uid']);
      });
      if (commonData.isEmpty) {
        commonData = temp.toSet();
        // print(commonData);
      } else {
        commonData = commonData.intersection(temp.toSet());
        // // print("Income list added");
      }
    }
    var result = await query.get();
    print("2 : ${commonData.toString()}");
    return commonData;
  }

  largeWherein(Query<Map<String, dynamic>> query, var value, var list) async {
    // value is the data to search and list is the list of data
    List<List<dynamic>> batches = List.generate((list.length / 10).ceil(), (i) {
      int start = i * 10;
      int end = (i + 1) * 10;
      return list.sublist(start, end < list.length ? end : list.length);
    });

    List<QuerySnapshot<Map<String, dynamic>>> querySnapshots =
        await Future.wait(batches.map((batch) {
      return query.where(value, whereIn: batch).get();
    }));

    List<QueryDocumentSnapshot<Map<String, dynamic>>> res =
        querySnapshots.expand((snapshot) => snapshot.docs).toList();
    //
    //
    //
    //List<List<dynamic>> batches = List.generate((list.length / 10).ceil(), (i) {
    //   int start = i * 10;
    //   int end = (i + 1) * 10;
    //   return list.sublist(start, end < list.length ? end : list.length);
    // });

    // List<Query<Map<String, dynamic>>> queries = batches.map((batch) {
    //   return query
    //       .where(value, whereIn: batch)
    //       .withConverter<Map<String, dynamic>>(
    //         fromFirestore: (snapshot, _) => snapshot.data()!,
    //         toFirestore: (data, _) => data,
    //       );
    // }).toList();

    // List<QuerySnapshot<Map<String, dynamic>>> querySnapshots =
    //     await Future.wait(queries.map((query) => query.get()));

    // List<QueryDocumentSnapshot<Map<String, dynamic>>> res =
    //     querySnapshots.expand((snapshot) => snapshot.docs).toList();
    return res;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
