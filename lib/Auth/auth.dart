import 'dart:convert';

import 'package:get/get.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/admin_model.dart';
import 'package:matrimony_admin/screens/Main_Screen.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/SignIn.dart';
import 'package:http/http.dart' as http;

import '../screens/maintinance_screen.dart';

class AuthService {
  // 1. handleAuthState()
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return LetsStart();
          } else {
            return const SignInScreen();
          }
        });
  }

  //sign In
  dynamic signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  static signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<String> findadminuser(String email) async {
    String condition = "";
    try {
      print("hellohi");
      http.Response res = await http.post(Uri.parse(finadminuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email}));
      print("*****getadmin");
      print(res.body);
      print("*****getadmin");
      if (res.statusCode == 200) {
        userSave.displayName = jsonDecode(res.body)["username"];
        return condition = "true";
      } else if (res.statusCode == 400) {
        return condition = "false";
      }
    } catch (e) {
      return condition = "false";
    }
    return condition;
  }

  Future<AdminModel> getadminuser(String email) async {
    AdminModel? adminModel;
    try {
      print("hellohi");
      http.Response res = await http.post(Uri.parse(finadminuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email}));
      print(res.body);
      if (res.statusCode == 200) {
        adminModel = AdminModel.fromJson(jsonEncode(jsonDecode(res.body)));
        if (adminModel.isLogOut == "true") {
          Get.offAll(FirstScreen());
          AuthService().updatelogin(email: email, mes: "false");
        }

        listofadminpermissions = adminModel.permissions;
        print(listofadminpermissions);
        userSave.name = adminModel.username;
        userSave.latitude = adminModel.lat;
        userSave.longitude = adminModel.lng;

        if (adminModel.permissions.isEmpty) {
          Get.offAll(MeintenanceScreen());
        }
        return adminModel;
      } else if (res.statusCode == 400) {}
    } catch (e) {
      print(e);
    }
    return adminModel!;
  }

  Future<void> updatelogin({
    required String email,
    required String mes,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(adminupdateloginurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "mes": mes}));
      print("islogout1234 ${res.body}");
      if (res.statusCode == 200) {
        print("update noti  successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

// Future<AdminModel> getadmin(String email)async{
//   AdminModel? adminModel;
//   try {
//     print("hellohi");
//     http.Response res=await http.post(Uri.parse(finadminuserurl),headers:{
//         'Content-Type':'Application/json'
//       },body: jsonEncode({
//         "email":email
//       }));
//      print(res.body);
//       if(res.statusCode==200){
//         adminModel=jsonDecode(res.body);
//       //  userSave.latitude=adminModel!.lat;
//       // userSave.longitude=adminModel.lng;
//       }
//   } catch (e) {
//     print(e);
//   }
//   return adminModel!;
// }
  Future<int> finduser(String email) async {
    int statusCode = 0;
    try {
      http.Response res = await http.get(Uri.parse("$finduserurl/$email"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        userSave.email = jsonDecode(res.body)["user"]["email"];
        print(userSave.email);
        return statusCode = res.statusCode;
      } else if (res.statusCode == 400) {
        return statusCode = res.statusCode;
      }
    } catch (e) {
      print(e.toString());
    }
    return statusCode;
  }
}
