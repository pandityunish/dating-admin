import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matrimony_admin/models/admin_search_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/api_routes.dart';
import '../../globalVars.dart';

class SearchProfile {
  Future<List<NewUserModel>> getuserdatabyid(
      {required String puid, required String email}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.post(Uri.parse(searchuserbyidurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({"puid": puid, "email": email}));
      print("${res.body} hello");
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<NewUserModel> searchuserdatabyid({
    required String puid,
  }) async {
    NewUserModel? allusers;

    try {
      http.Response res = await http.get(
        Uri.parse("$finduser/$puid"),
        headers: {'Content-Type': 'Application/json'},
      );
      print("${res.body} hello");
      if (res.statusCode == 200) {
        allusers = NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)));

        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers!;
  }

  Future<List<NewUserModel>> getuserdatabyemail(
      {required String searchemail, required String email}) async {
    List<NewUserModel> allusers = [];

    try {
      //FRWFPYXH4FF
log("message ${searchemail}");
      http.Response res = await http.post(Uri.parse(searchuserbyemailurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({"searchemail": searchemail, "email": email}));
      print("${res.body} hello");
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<List<NewUserModel>> getuserdatabyphone(
      {required String phone, required String email}) async {
    List<NewUserModel> allusers = [];

    try {
      //FRWFPYXH4FF
      //916494918181
      print(phone);
      http.Response res = await http.post(Uri.parse(searchuserbyphoneurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({"phonenumber": phone, "email": email}));
      print("${res.body} hello33");
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future getnumberofsearchusers(String searchtext) async {
    var totaluser;
    try {
      http.Response res = await http.post(
        Uri.parse(getnumberofsearchuserurl),
        body: jsonEncode({"searchtext": searchtext}),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        totaluser = jsonDecode(res.body);
        return totaluser;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
    }
    return totaluser;
  }

  Future<void> postquery({required String email, required String desc}) async {
    try {
      http.Response res = await http.post(Uri.parse(postqueryurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "description": desc,
            "isAdmin": true,
            "name": userSave.name
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("add to sortlist successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtonotification({
    required String email,
    required String title,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(addtonotificationurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "title": title,
          }));
      print("helloin****");
      print(res.body);
      print("helloin*******");
      if (res.statusCode == 200) {
        print("notification added successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getsupports(String email) async {
    var data;
    try {
      http.Response res = await http.post(Uri.parse(getsupporturl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email}));
      print("${res.body} hello33");
      if (res.statusCode == 200) {
        data = jsonDecode(res.body);
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<NewUserModel>> getuserdatabyname(
      {required String name, required String email}) async {
    List<NewUserModel> allusers = [];

    try {
      print(name);
      http.Response res = await http.post(Uri.parse(searchuserbynameurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({"name": name,"limit":20,"page":1}));
      log("new ${res.body} hello");
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body)["users"].length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)["users"][i])));

          // print(userdata);
        }
        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<List<NewUserModel>> getuserdatabysurname(
      {required String surname, required String email}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.post(Uri.parse(searchuserbysurnameurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({"surname": surname,"limit":20,"page":1}));
      print(res.body);
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body)["users"].length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)["users"][i])));
        }
        return allusers;
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<List<NewUserModel>> searchuserdata(
      {required String gender,
      required String email,
      required String religion,
      required int page,
      required double lat,
      required double lng,
      required List<dynamic> ages,
      required List<dynamic> religionList,
      required List<dynamic> kundaliDoshList,
      required List<dynamic> maritalStatusList,
      required List<dynamic> dietList,
      required List<dynamic> drinkList,
      required List<dynamic> smokeList,
      required List<dynamic> disabilityList,
      required List<dynamic> heightList,
      required List<dynamic> educationList,
      required List<dynamic> professionList,
      required List<dynamic> incomeList,
      required int maxDistanceKm,
      required List<dynamic> statelocation,
      required List<dynamic> citylocation,
      required List<dynamic> location}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.post(Uri.parse(searchusers),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({
            "gender": gender,
            "religion": religion,
            "page": page,
            "email": email,
            "ages": ages,
            "religionList": religionList,
            'latitude': lat,
            'longitude': lng,
            "kundaliDoshList": kundaliDoshList,
            "maritalStatusList": maritalStatusList,
            "dietList": dietList,
            "drinkList": drinkList,
            "smokeList": smokeList,
            "disabilityList": disabilityList,
            "heightList": heightList,
            "educationList": educationList,
            "professionList": professionList,
            "incomeList": incomeList,
            "maxDistanceKm": maxDistanceKm,
            "citylocation": citylocation,
            "statelocation": statelocation,
            "location": location
          }));
      print("${jsonDecode(res.body)} hello");

      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<List<NewUserModel>> searchuserdataforprofiletype(
      {required String gender,
      required String email,
      required String religion,
      required int page,
      required double lat,
      required double lng,
      required List<dynamic> ages,
      required List<dynamic> religionList,
      required List<dynamic> kundaliDoshList,
      required List<dynamic> maritalStatusList,
      required List<dynamic> dietList,
      required List<dynamic> drinkList,
      required List<dynamic> smokeList,
      required List<dynamic> disabilityList,
      required List<dynamic> heightList,
      required List<dynamic> educationList,
      required List<dynamic> professionList,
      required List<dynamic> incomeList,
      required int maxDistanceKm,
      required List<dynamic> statelocation,
      required List<dynamic> citylocation,
      required List<dynamic> location}) async {
    List<NewUserModel> allusers = [];

    try {
      print(kundaliDoshList);
      print("${maxDistanceKm} helakjdslf");

      http.Response res =
          await http.post(Uri.parse(searchallusersurlforprofile),
              headers: {'Content-Type': 'Application/json'},
              body: json.encode({
                "gender": gender,
                "religion": religion,
                "page": page,
                "email": email,
                "ages": ages,
                "religionList": religionList,
                'latitude': lat,
                'longitude': lng,
                "kundaliDoshList": kundaliDoshList,
                "maritalStatusList": maritalStatusList,
                "dietList": dietList,
                "drinkList": drinkList,
                "smokeList": smokeList,
                "disabilityList": disabilityList,
                "heightList": heightList,
                "educationList": educationList,
                "professionList": professionList,
                "incomeList": incomeList,
                "maxDistanceKm": maxDistanceKm,
                "citylocation": citylocation,
                "statelocation": statelocation,
                "location": location
              }));
      print("${res.body} hello");

      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<List<NewUserModel>> profiletypesSearch(
      {required int page,
      required String searchText,
      required String gender}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.post(Uri.parse(profiletypessearch),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode(
              {"searchtext": searchText, "page": page, "gender": gender}));
      print(res.body);
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<void> downloadExcel(String searchtext) async {
    final response =
        await http.get(Uri.parse("$downloadexcelfile/?searchtext=$searchtext"));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Get the directory for the device's downloads
      final directory = await getExternalStorageDirectory();
      final path = '${directory?.path}/discloselater.xlsx';
      // Write the file
      final File file = File(path);
      await file.writeAsBytes(bytes);

      // Open the file
      OpenFile.open(path);
      print('Excel file downloaded to: $path');
    } else {
      print('Failed to download Excel file: ${response.statusCode}');
    }
  }

  Future<List<NewUserModel>> deleteProfiles(
      {required int page, required String searchText}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.get(
        Uri.parse("$deletedprofileurl?page=$page?perPage=10"),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          print(jsonDecode(res.body)[i]);
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<Map<String, dynamic>> getAdminSearch(int page, int limit) async {
  try {
    final url = Uri.parse('$getadminsearchurl?page=$page&limit=$limit');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
log("message ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Decode the entire JSON response
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load data'); // Throw an exception for error handling
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load data'); // Throw an exception for error handling
  }
}

  Future<void> updateemail(
      {required String email, required String editemail}) async {
    try {
      http.Response res = await http.post(Uri.parse(editemailurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "editemail": editemail}));
      print(res.body);
      if (res.statusCode == 200) {
        print("verified user");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> addtosearchprofile(
      {required String searchprofile,
      required String searchDistance,
      required String age,
      required String religion,
      required String kundalidosh,
      required String marital_status,
      required String diet,
      required String email,
      required String name,
      required String smoke,
      required String drink,
      required String disability,
      required String searchnameprofile,
      required String searchphoneprofile,
      required String searchsurprofile,
      required String searchemailprofile,
      required String height,
      required String education,
      required String profession,
      required String income,
      bool? isSearch,
      int?minDistance,
      int? maxDistance,
      required String location}) async {
    try {
      http.Response res = await http.post(Uri.parse(addtoadminsearchurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "searchidprofile": searchprofile,
            "searchnameprofile": searchnameprofile,
            "searchphoneprofile": searchphoneprofile,
            "searchsurnameprofile": searchsurprofile,
            "searchemailprofile": searchemailprofile,
            "searchDistance": searchDistance,
            "age": age,
            "religion": religion,
            "kundlidosh": kundalidosh,
            "marital_status": marital_status,
            "diet": diet,
            "smoke": smoke,
            "drink": drink,
            "disability": disability,
            "height": height,
            "education": education,
            "profession": profession,
            "income": income,
            "email": email,
            "adminname": name,
            "location": location,
            "userid": userSave.uid,
            "isSearch": isSearch??false,
            "minDistance": minDistance??0,
            "maxDistance": maxDistance??0
          }));
      log("updated search" + res.body);
      if (res.statusCode == 200) {
        final data=jsonDecode(res.body);
        return data["_id"];
      }
    } catch (e) {
      
      print(e.toString());
    }
    return '';
  }
void increaseSearchProfileFound(
      {required String id,
      required int number}) async {
    try {
    
      http.Response res = await http.post(Uri.parse(increaseProfileFoundurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
           'id': id,
           'incrementBy':number
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("updatelogin  successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> addtoadminnotification(
      {required String userid,
      required String useremail,
      required String userimage,
      required String title,
      required String email,
      required String subtitle}) async {
    try {
      print(useremail);
      print(userimage);
      print(title);
      print(subtitle);
      http.Response res = await http.post(Uri.parse(addtoadminnotificationurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "userid": userid,
            "title": title,
            "useremail": useremail,
            "userimage": userimage,
            "subtitle": subtitle,
            "adminemail": email
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("Admin notification added successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
