import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/admin_model.dart';
import 'package:matrimony_admin/models/edit_admin_model.dart';
class CreateAdminService{
  Future createadmin(
      { required String email,required String username,required List<dynamic> permissions,required BuildContext context}) async {
       
    try {
      print(email);
      http.Response res = await http.post(Uri.parse(creatadminurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({ "email":email,
          "username":username,"permissions":permissions}));
      if (res.statusCode == 200) {
        print(res.body);
      } else if(res.statusCode==200) {
        print(res.body);
      }else{
        print(res.body);
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SnackBarContent3(
                                        error_text:
                                            "User Already Exist",
                                        appreciation: "",
                                        icon: Icons.done),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
      }
    } catch (e) {
      print(e);
    }
  }
   Future createeditadmin(
      { required String email,required String username,required List<dynamic> permissions}) async {
       
    try {
      print(email);
      http.Response res = await http.post(Uri.parse(admineditprofileurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({ "email":email,
          "editname":"Edit by ${userSave.name}",
          "username":username,"permissions":permissions}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
    Future<List<EditAdminModel>> geteditadmins({required String email}
) async {
     List<EditAdminModel> alladmins=[];  
    try {
      http.Response res = await http.post(Uri.parse(getadmineditprofileurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email":email
          })
        );
        print(res.body);
      if (res.statusCode == 200) {
       for (var i = 0; i < jsonDecode(res.body).length; i++) {
         alladmins.add(EditAdminModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
       }
       return alladmins;
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
    return alladmins;
  }
   Future editadmin(
      { required String email,required String username,required List<dynamic> permissions,required String useremail}) async {
       
    try {
      http.Response res = await http.post(Uri.parse(editadminurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({ "email":email,
          "useremail":useremail,
          "username":username,"value":permissions}));
        print("hello ${res.body}");

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
   Future<List<AdminModel>> getalladmins(
) async {
     List<AdminModel> alladmins=[];  
    try {
      http.Response res = await http.get(Uri.parse(getadminsurl),
          headers: {'Content-Type': 'Application/json'},
        );
      if (res.statusCode == 200) {
       for (var i = 0; i < jsonDecode(res.body).length; i++) {
         alladmins.add(AdminModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
       }
       return alladmins;
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
    return alladmins;
  }
}