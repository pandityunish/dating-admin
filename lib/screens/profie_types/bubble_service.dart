import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
class BubbleService{
  Future getbubbles()async{
     var data;
    try {
      http.Response res = await http.get(Uri.parse(getbubblesurl),
          headers: {'Content-Type': 'Application/json'},
       );
      print(res.body);
      if (res.statusCode == 200) {
        return data=jsonDecode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return data;
  }
   Future getbubblesbydate(String dateStr)async{
     var data;
    try {
      http.Response res = await http.post(Uri.parse(getbubblesbydateurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "dateStr":dateStr
          })
       );
      
      if (res.statusCode == 200) {
        return data=jsonDecode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return data;
  }
   Future updatebubbles(
      { required String image1,required String image2,
      required String image3,required String image4,required String image5,
      required String image6,required String image7,required String image8,
      required String image9,required String image10,required String image11,
      required String image12,required String image13,required String image14,
      required String number,
      required String image15,required String image16,}) async {
    try {
      http.Response res = await http.post(Uri.parse(updatebubblesurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"image1":image1,"username":"$number By ${userSave.name}","image2":image2,"image3":image3,"image4":image4,"image5":image5,
          "image6":image6,"image7":image7,"image8":image8,
          "image9":image9,"image10":image10,"image11":image11,"image12":image12,"image13":image13,"image14":image14,"image15":image15,"image16":image16}));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}