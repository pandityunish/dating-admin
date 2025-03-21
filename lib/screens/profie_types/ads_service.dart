import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/ads_model.dart';

class AdsService{
  Future createads(
      {required String adsid, required String image,required String link,required String video}) async {
    try {
      http.Response res = await http.post(Uri.parse(createadsurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"description": link, "adsid": adsid,"image":image,"video":video,"name":userSave.name}));
      if (res.statusCode == 200) {
        print("ok");
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
  Future deleteads(
      {required String id}) async {
    try {
      http.Response res = await http.post(Uri.parse(deleteadsurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id, }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
  Future updateads(
      {required String id}) async {
    try {
      http.Response res = await http.post(Uri.parse(updateadsurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id, }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
  Future<List<AdsModel>> getallusers({required String adsid}) async {
    List<AdsModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getallads),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"adsid": adsid}));
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              AdsModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

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