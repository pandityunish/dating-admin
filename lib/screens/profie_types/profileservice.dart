import 'dart:convert';

import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:http/http.dart' as http;
class ProfileService{
  Future<List<NewUserModel>> getallusersbymalefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getmalefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getallusersbyfemalefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getfemalefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getminiagefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getminiagefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getmaxagefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getmaxagefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getminiheightfirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getminiheightfirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getmaxheightfirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getmaxheightfirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getminiincomefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getminiincomefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getsortdata({required String searchtext,required int page}) async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getsortdataurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
             "page":page,
            "searchtext":searchtext
          })
         );
     
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getmaxincomefirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getmaxincomefirsturl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getwithphotofirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getwithphotourl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
  Future<List<NewUserModel>> getwithoutphotofirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(Uri.parse(getwithoutphotourl),
          headers: {'Content-Type': 'Application/json'},
         );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }
}