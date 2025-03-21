// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import '../../../models/new_user_model.dart';
import '../../../models/send_notification_model.dart';
import '../../service/search_profile.dart';
import '../navigator.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:flutter/services.dart';


// import '../../Assets/G_Sign.dart';
//import '../../models/shared_pref.dart';
//import '../../models/user_model.dart';

//String? SmokeStatus;

class FirebaseAuthService {
  static Future<String?> getAccessToken() async {
    try {
      final serviceAccount = await rootBundle.loadString('assets/token.json');
      final Map<String, dynamic> keyMap = json.decode(serviceAccount);

      try {
        final credentials = ServiceAccountCredentials.fromJson(keyMap);
        final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

        try {
          // Use the imported function correctly:
          final client = await clientViaServiceAccount(credentials, scopes); // Correct usage

          final accessToken = client.credentials.accessToken.data;

      
            print("Access Token: $accessToken");
            return accessToken;
         
        } catch (e) {
          print("Error getting HTTP client: $e");
          return null;
        }
      } catch (e) {
        print("Error parsing service account JSON: $e");
        return null;
      }
    } catch (e) {
      print("Error loading service account file: $e");
      return null;
    }
  }
}
class SendNotification extends StatefulWidget {
  final NewUserModel userSave;
  final List<NewUserModel>? users;
  const SendNotification({
    Key? key,
    required this.userSave,
    this.users,
  }) : super(key: key);

  @override
  State<SendNotification> createState() => _ReligionState();
}

class _ReligionState extends State<SendNotification> {
  List<SendNotificationModel> allnotification=[];
  void sendPushMessage(
      String body, String title, String userid, String route, String token,
      {String userName = "", String sound = "navnot"}) async {
    try {
       String? newtoken = await FirebaseAuthService.getAccessToken();
      http.Response res = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/freerishteywala-2f843/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $newtoken',
        },
        body: jsonEncode(
         {"message": <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            "android": {"priority": "high"},
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'uid': userid,
              'route': route,
              'id': userSave.uid,
              'userName': userName,
              'status': 'done',
              'sound': sound
            },
            "token": token,
          },}
        ),
      );

      print(res.body);
      if(jsonDecode(res.body)["success"]>=1){
   AdminService().addtosendnotification(email: widget.userSave.email,
         heading: title, name: userSave.name!, title: body, status: "Received", type: "Personal");
      }else{
  AdminService().addtosendnotification(email: widget.userSave.email,
         heading: title, name: userSave.name!, title: body, status: "Pending", type: "Personal");
      }
     
    } catch (e) {
      print("error push notification");
    }
  }

  void sendPushMessagetoallusers(String body, String title,
      {String userName = "", String sound = "navnot"}) async {
    try {
      for (var i = 0; i < widget.users!.length; i++) {
        http.Response res = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAARNDuqEs:APA91bFMhCmAO8olPfJxG868C9czilKHzNIk_pYuXBJ7iFrGiK6bPl6K_O5Uqkq607hZFu_ScIfyCRq7ZBnHTtz_vl6HvrIvdDwxu_nxP4P4E-pDpGvIeGhP5Z3CQoxgwq6sZTlFLtYa',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': title,
                'icon': 'ic_launcher'
              },
              "android": {"priority": "high"},
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'uid': widget.users![i].id,
                'route': "",
                'id': widget.userSave.id,
                'userName': userName,
                'status': 'done',
                'sound': sound
              },
              "to": widget.users![i].token,
            },
          ),
        );
      }
    } catch (e) {
      print("error push notification");
    }
  }
void getnotification()async{
List<SendNotificationModel>  notifications=await AdminService().getsendnotification(email: widget.userSave.email);
  SendNotificationModel newnotification=SendNotificationModel(name: "", email: "123", title: "", heading: "", type: "", status: "",createdAt: "");
     notifications.sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt));
  allnotification=[newnotification, ...notifications];
print(allnotification);

  setState(() {
    
  });
}

  int value = 0;
  final TextEditingController controller = TextEditingController();
  final TextEditingController headcontroller = TextEditingController();
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          //SmokeStatus = text;
          value = index;
          /*setData().then({
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => Disability()))
          });*/
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? main_color : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }
//testalignment 
//image not loading
//features isnot clicking 
//same features 
//error is not working
//homepage why us and how we work
@override
  void initState() {
    getnotification();
    super.initState();
  }
   final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: CustomAppBar(title: "Send Notification", iconImage: "images/notification.png"),
          body: PageView.builder(
                         controller: _pageController,
                         onPageChanged: (index) {},
                         itemCount:allnotification.length,
                         itemBuilder: (BuildContext context, int index) { 
          if(allnotification[index].email=="123"){
          return Center(
               child: Container(
             height: MediaQuery.of(context).size.height * 0.85,
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Container(
                     margin: EdgeInsets.only(left: 15, right: 15),
                     child: TextField(
                       controller: headcontroller,
                       minLines: 3,
                       maxLines: 5,
                       maxLength: 50,
                       style:
                           TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                       decoration: InputDecoration(
                         hintText: "Enter Headline here",
                         border: OutlineInputBorder(
                             borderSide: new BorderSide(color: main_color)),
                         focusedBorder: OutlineInputBorder(
                             borderSide: new BorderSide(color: main_color)),
                         // labelText: 'Write Here',
                       ),
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Container(
                     margin: EdgeInsets.only(left: 15, right: 15),
                     child: TextField(
                       controller: controller,
                       minLines: 3,
                       maxLines: 7,
                       maxLength: 50,
                       style:
                           TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                       decoration: InputDecoration(
                         hintText: "Enter Notification Here",
                         border: OutlineInputBorder(
                             borderSide: new BorderSide(color: main_color)),
                         focusedBorder: OutlineInputBorder(
                             borderSide: new BorderSide(color: main_color)),
                         // labelText: 'Write Here',
                       ),
                     ),
                   ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                 index==0?Center():     IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>{
                                _pageController.previousPage( duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,)
                              }),              
                              IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                                _pageController.nextPage( duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,)
                              }),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                     height: 20,
                   ),
                   SizedBox(
                     width: 300,
                     height: 50,
                     child: ElevatedButton(
                       style: ButtonStyle(
                           shadowColor: MaterialStateColor.resolveWith(
                               (states) => Colors.black),
                           padding: MaterialStateProperty.all<
                                   EdgeInsetsGeometry?>(
                               EdgeInsets.symmetric(vertical: 13)),
                           shape: MaterialStateProperty.all<
                                   RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(60.0),
                             // side: BorderSide(
                             //   color: (value == false)
                             //       ? Colors.white
                             //       : main_color,
                             // )
                           )),
                           backgroundColor: MaterialStateProperty.all<Color>(
                               Colors.white)),
                       child: Text(
                         "Send Notification",
                         style: TextStyle(
                           fontSize: 20,
                           color: Colors.black,
                         ),
                       ),
                       onPressed: () async {
                         print(widget.userSave.token);
                         // print(widget.users);
                         // if(widget.users!.isEmpty){
                         if (controller.text.isEmpty ||
                             headcontroller.text.isEmpty) {
                           showDialog(
                               context: context,
                               builder: (context) {
                                 return const AlertDialog(
                                   content: SnackBarContent(
                                       sec: 2,
                                       error_text: "Please Enter Value",
                                       appreciation: "",
                                       icon: Icons.error),
                                   backgroundColor: Colors.transparent,
                                   elevation: 0,
                                 );
                               });
                         } else {
                          print(widget.userSave.token);
          
                           sendPushMessage(
                               controller.text,
                               headcontroller.text,
                               widget.userSave.id,
                               "",
                               widget.userSave.token);
          
                           SearchProfile()
                               .addtoadminnotification(
                                   userid: userSave!.puid!,
                                   useremail: userSave.email!,
                                   userimage: userSave.imageUrls!.isEmpty
                                       ? ""
                                       : userSave.imageUrls![0],
                                   title:
                                       "${userSave.displayName} SEND NOTIFICATION TO ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave.puid} HEADLINE (${headcontroller.text}) NOTIFICATION (${controller.text})",
                                   email: userSave.email!,
                                   subtitle: "")
                               .whenComplete(
                             () {
                               
                             },
                           );
                            showDialog(
                               context: context,
                               builder: (context) {
                                 return const AlertDialog(
                                   content: SnackBarContent(
                                       sec: 2,
                                       error_text: "Notification Send Successfully",
                                       appreciation: "",
                                       icon: Icons.check_circle),
                                   backgroundColor: Colors.transparent,
                                   elevation: 0,
                                 );
                               }).whenComplete(() {
                                  Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (context) => MyProfile(
                                                                  profilecomp: 50,
                                                                  userSave: widget.userSave,
                                                                 )));
                               },);
                           controller.clear();
                           headcontroller.clear();
                         }
          
                         // }else{
          
                         // }
                       },
                     ),
                   ),
                 ],
               ),
             ),
           ));
          }
           return Column(
              children: [
                Center(
                   child: Container(
                 height: MediaQuery.of(context).size.height * 0.85,
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Container(
                         margin: EdgeInsets.only(left: 15, right: 15),
                         child: TextFormField(
                                                        initialValue: allnotification[index].heading,
          
                           minLines: 3,
                           maxLines: 5,
                           maxLength: 50,
                           style:
                               TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                           decoration: InputDecoration(
                             hintText: "Enter Headline here",
                             border: OutlineInputBorder(
                                 borderSide: new BorderSide(color: main_color)),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: new BorderSide(color: main_color)),
                             // labelText: 'Write Here',
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: EdgeInsets.only(left: 15, right: 15),
                         child: TextFormField(
                           initialValue: allnotification[index].title,
                           minLines: 3,
                           maxLines: 5,
                           maxLength: 50,
                           style:
                               TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                           decoration: InputDecoration(
                             hintText: "Enter Notification Here",
                             border: OutlineInputBorder(
                                 borderSide: new BorderSide(color: main_color)),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: new BorderSide(color: main_color)),
                             // labelText: 'Write Here',
                           ),
                         ),
                       ),
                       Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                 index==0?Center():     IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>{
                                _pageController.previousPage( duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,)
                              }),              
                              IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                                _pageController.nextPage( duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,)
                              }),
                        ],
                      ),
                    ),
                  ),
                       SizedBox(
                         height: 20,
                       ),
                       SizedBox(
                         width: 300,
                         height: 50,
                         child: ElevatedButton(
                           style: ButtonStyle(
                               shadowColor: MaterialStateColor.resolveWith(
                                   (states) => Colors.black),
                               padding: MaterialStateProperty.all<
                                       EdgeInsetsGeometry?>(
                                   EdgeInsets.symmetric(vertical: 13)),
                               shape: MaterialStateProperty.all<
                                       RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(60.0),
                                 // side: BorderSide(
                                 //   color: (value == false)
                                 //       ? Colors.white
                                 //       : main_color,
                                 // )
                               )),
                               backgroundColor: MaterialStateProperty.all<Color>(
                                   Colors.white)),
                           child: Text(
                             "Send Notification",
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.black,
                             ),
                           ),
                           onPressed: () async {
                            
                
                             // }else{
                
                             // }
                           },
                         ),
                       ),
                       Text(allnotification[index].status,style:  TextStyle(
                             fontFamily: 'Serif',
                             fontSize: 20,
                             fontWeight: FontWeight.w700,
                             color:allnotification[index].status=="Received"? main_color:Colors.red,
                           ),),
                 Text("Send by:${allnotification[index].name}",style:  TextStyle(
                             fontFamily: 'Serif',
                             fontSize: 20,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),),
                            Text("Particular",style:  TextStyle(
                             fontFamily: 'Serif',
                             fontSize: 20,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),),
                              Text( DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(allnotification[index].createdAt).toLocal()),style: TextStyle(
                             fontFamily: 'Serif',
                             fontSize: 20,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),)
                     ],
                   ),
                 ),
               )),
                 
              ],
            );
          }
           ,)),
    );
  }
}
