// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/profie_types/profiles.dart';
import '../../../models/new_user_model.dart';
import '../service/search_profile.dart';

// import '../../Assets/G_Sign.dart';
//import '../../models/shared_pref.dart';
//import '../../models/user_model.dart';

//String? SmokeStatus;

class SendAllNotification extends StatefulWidget {
 final  List<NewUserModel>? users;
 final String searchtext;
 final String title;
  const SendAllNotification({
    Key? key,
    this.users, required this.searchtext, required this.title,
  }) : super(key: key);

  @override
  State<SendAllNotification> createState() => _ReligionState();
}

class _ReligionState extends State<SendAllNotification> {
 
  void sendPushMessagetoallusers(
      String body, String title, 
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
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'uid': widget.users![i].id,
                'route': "",
                'id':widget. users![i].id,
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
  int value = 0;
  final TextEditingController controller=TextEditingController();
  final TextEditingController headcontroller=TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        
          navigationBar: CupertinoNavigationBar(
              leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
             
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: main_color,
                size: 25,
              ),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: DefaultTextStyle(
                      style:
                          GoogleFonts.poppins(color: Colors.black, fontSize: 25),
                      child: Text("Send Notification")),
                )
              ],
            ),
            previousPageTitle: "",
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
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
                          maxLength: 20,
                          style:
                              TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                          decoration: InputDecoration(
                            hintText: "Write Headline here",
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
                          maxLines: 5,
                          maxLength: 50,
                          style:
                              TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                          decoration: InputDecoration(
                            hintText: "Write Notification",
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: main_color)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: main_color)),
                            // labelText: 'Write Here',
                          ),
                        ),
                      ),
                     
                      SizedBox(height: 20,),
                      SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                    EdgeInsets.symmetric(vertical: 13)),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                            
                                        // side: BorderSide(
                                        //   color: (value == false)
                                        //       ? Colors.white
                                        //       : main_color,
                                        // )
                                        )
                                        ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        child:const Text(
                          "Send Notification",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {
                          if(controller.text.isEmpty || headcontroller.text.isEmpty){
  showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: SnackBarContent(
                                sec: 2,
                                  error_text:
                                      "Please Enter Value",
                                  appreciation: "",
                                  icon: Icons.error),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            );
                          });
                          }else{
                             SearchProfile().addtoadminnotification(userid: "54678", useremail:"userSave.email!", userimage:"", 
  title: "${userSave.displayName} SEND NOTIFICATION TO ${widget.searchtext} PROFILES WITH HEADLINE (${headcontroller.text}) NOTIFICATION (${controller.text})", email: userSave.email!, subtitle: "");
                            AdminService().addnotificationtoeachsendlink(searchtext: widget.searchtext, body: controller.text, title: headcontroller.text);
                              showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: SnackBarContent(
                                sec: 2,
                                  error_text:
                                      "Send Successfully",
                                  appreciation: "",
                                  icon: Icons.done),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            );
                          }).whenComplete(() {
                            Get.to(Profiles( searchText: widget.searchtext,title: widget.title,));
                          },);
                          }

                            //  Navigator.push(context, MaterialPageRoute(builder: ))
              // print(widget.users);
              // if(widget.users!.isEmpty){
                      controller.clear();
                      headcontroller.clear();
              // }else{

              // }
                    
                       
                        },
                      ),
                    ),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
