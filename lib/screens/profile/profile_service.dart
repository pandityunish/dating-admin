import 'dart:convert';

import '../../common/api_routes.dart';
import '../../models/admin_notification_model.dart';
import 'package:http/http.dart' as http;
class NotiService{

      Future<List<AdminNotificationModel>> getdateNotifications(
      String year,String month,String day,int pagenumber,int perpagenumber) async {
    List<AdminNotificationModel> getAdminNotificationsData = [];
    try {
      print(year+ month+ day);
      final response = await http.post(
        Uri.parse(getdatenotiurl),
        body: jsonEncode({
          "year":year,"month":month,"day":day,
        "pagenumber":pagenumber,"perpagenumber":perpagenumber}),
        headers: {'Content-Type': 'application/json'},
      );
print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getAdminNotificationsData.add(AdminNotificationModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return getAdminNotificationsData;
  }
   Future<void> updatenoti() async {
    try {
      http.Response res = await http.get(Uri.parse(updateallnotiurl),
          headers: {'Content-Type': 'Application/json'},
          
          );
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> updatemaintenance(bool isUnder) async {
    try {
      http.Response res = await http.post(Uri.parse(updatemaintenanceurl),
          headers: {'Content-Type': 'Application/json'},
          body:jsonEncode({
            "isUnder":isUnder
          })
          );
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<int> getdailyuser(String year,String month,String day) async {
    int totaluser = 0;
    try {
      print(year + month + day);
      http.Response res = await http.post(
        Uri.parse(getsearchuserurl),
        headers: {'Content-Type': 'Application/json'},
        body: json.encode({
          "year":year,
"month":month,
"day":day
        })
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
}