import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/new_user_model.dart';
import 'package:http/http.dart' as http;
class ProfileMatch {
  final List matchPercentage = [];
  int profileMatch(data,NewUserModel newUserModel) {
    var match = 0;
    if (newUserModel.religion == data.religion) {
      // print("1");
      match += 10;
    }
    if (newUserModel.KundaliDosh == data.KundaliDosh) {
      // print("2");
      match += 10;
    }
    if (newUserModel.MartialStatus == data.MartialStatus) {
      // print("3");
      match += 10;
    }
    if (newUserModel.Diet == data.Diet) {
      // print("4");
      match += 10;
    }
    if (newUserModel.gender != data.gender) {
      if (newUserModel.gender == "Male" &&
          (double.parse(newUserModel.Height!.split(' ')[0]) >
              data.Height!.split(' ')[0])) {
        match += 10;
      } else if (newUserModel.gender == "Female" &&
          (double.parse(newUserModel.Height!.split(' ')[0]) <
              data.Height!.split(' ')[0])) {
        match += 10;
      }
    }
    if (newUserModel.Profession == data.Profession) {
      // print("5");
      match += 10;
    }
    if (newUserModel.Diet == data.Diet) {
      // print("6");
      match += 10;
    }
    if (newUserModel.Drink == data.Drink) {
      // print("7");
      match += 5;
    }
    if (newUserModel.Smoke == data.Smoke) {
      // print("8");
      match += 5;
    }
    if (newUserModel.Disability == data.Disability) {
      // print("9");
      match += 10;
    }
    // if (profileMatchDataJson.LocatioList.toString().contains(data.Location)) {
    //   match += 10;
    // }
    if (match > 90) {
      match = 100;
    }

    // matchConditionCheck();
    // print(match);
    return match;
  }
Future<double> getallusermatch(NewUserModel newuserModel,NewUserModel userSave) async {
  var data;
    if (userSave.gender == "male") {
      DateTime dateofbirth = DateTime.fromMillisecondsSinceEpoch(userSave.dob!);

      String m_day = dateofbirth.day.toString();
      String m_month = dateofbirth.month.toString();
      String m_year = dateofbirth.year.toString();
      DateTime dateofbirth1 =
          DateTime.fromMillisecondsSinceEpoch(newuserModel.dob);
      String f_day = dateofbirth1.day.toString();
      String f_month = dateofbirth1.month.toString();
      String f_year = dateofbirth1.year.toString();
      List<String> m_parts = userSave.timeofbirth!.split(':');
      int m_hours = int.parse(m_parts[0]);

      List<String> minuteAndAmPm = m_parts[1].split(' ');
      int m_minutes = int.parse(minuteAndAmPm[0]);
      List<String> f_parts = newuserModel!.timeofbirth.split(':');
      print("******************");
      print(f_parts);
      print("******************");
      int f_hours = int.parse(f_parts[0]);

      List<String> fminuteAndAmPm = f_parts[1].split(' ');
      int f_minutes = int.parse(fminuteAndAmPm[0]);
      print("******************");
      print(f_hours);
      print("******************");
      var url = Uri.parse(
          'https://api.kundali.astrotalk.com/v1/combined/match_making');
    
      var payload = {
        "m_detail": {
          "day": m_day,
          "hour": m_hours,
          "lat": userSave.lat,
          "lon": userSave.lng,
          "min": m_minutes,
          "month": m_month,
          "name": userSave.name,
          "tzone": "5.5",
          "year": m_year,
          "gender": "male",
          "place": userSave.Location,
          "sec": 0
        },
        "f_detail": {
          "day": f_day,
          "hour": f_hours,
          "lat": newuserModel!.lat,
          "lon": newuserModel!.lng,
          "min": f_minutes,
          "month": f_month,
          "name": newuserModel!.name,
          "tzone": "5.5",
          "year": f_year,
          "gender": "female",
          "place": newuserModel!.Location,
          "sec": 0
        },
        "languageId": 1
      };

      var body = json.encode(payload);

      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      print("*********************");
      print(response.body);
      print("*********************");
      if (response.statusCode == 200) {
          print("999999999999999999999999");
        print(jsonDecode(response.body)['ashtkoot']['total']['received_points']);
        data=jsonDecode(response.body)['ashtkoot']['total']['received_points'].toDouble();
      
        return data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      DateTime dateofbirth =
          DateTime.fromMillisecondsSinceEpoch(newuserModel!.dob!);

      String m_day = dateofbirth.day.toString();
      String m_month = dateofbirth.month.toString();
      String m_year = dateofbirth.year.toString();
      DateTime dateofbirth1 =
          DateTime.fromMillisecondsSinceEpoch(userSave.dob!);
      String f_day = dateofbirth1.day.toString();
      String f_month = dateofbirth1.month.toString();
      String f_year = dateofbirth1.year.toString();
      List<String> m_parts = newuserModel!.timeofbirth!.split(':');
      int m_hours = int.parse(m_parts[0]);

      List<String> minuteAndAmPm = m_parts[1].split(' ');
      int m_minutes = int.parse(minuteAndAmPm[0]);
      List<String> f_parts = userSave.timeofbirth!.split(':');
      int f_hours = int.parse(f_parts[0]);

      List<String> fminuteAndAmPm = f_parts[1].split(' ');
      int f_minutes = int.parse(fminuteAndAmPm[0]);
      print(m_year);
      var url = Uri.parse(
          'https://api.kundali.astrotalk.com/v1/combined/match_making');

      var payload = {
        "m_detail": {
          "day": m_day,
          "hour": m_hours,
          "lat": newuserModel!.lat,
          "lon": newuserModel!.lng,
          "min": m_minutes,
          "month": m_month,
          "name": newuserModel!.name,
          "tzone": "5.5",
          "year": m_year,
          "gender": "male",
          "place": newuserModel!.Location,
          "sec": 0
        },
        "f_detail": {
          "day": f_day,
          "hour": f_hours,
          "lat": userSave.lat,
          "lon": userSave.lng,
          "min": f_minutes,
          "month": f_month,
          "name": userSave.name,
          "tzone": "5.5",
          "year": f_year,
          "gender": "female",
          "place": userSave.Location,
          "sec": 0
        },
        "languageId": 1
      };

      var body = json.encode(payload);

      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      print("##################");
      print(response);
      print("##################");
      if (response.statusCode == 200) {
      data=jsonDecode(response.body)['ashtkoot']['total']['received_points'].toDouble();
        return data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return data;
  }
  // matchConditionCheck() {}
}
  // matchConditionCheck() {}

