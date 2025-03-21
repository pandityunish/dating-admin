import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';

import '../../globalVars.dart';
import '../service/search_profile.dart';

// import '../../Assets/G_Sign.dart';
//import '../../models/shared_pref.dart';
//import '../../models/user_model.dart';

//String? SmokeStatus;

class SendLinkToAll extends StatefulWidget {
  final List<dynamic> userids;
  final List<NewUserModel> allusers;
  final String searchtext;
  const SendLinkToAll({Key? key, required this.userids,required this.searchtext, required this.allusers}) : super(key: key);

  @override
  State<SendLinkToAll> createState() => _ReligionState();
}

class _ReligionState extends State<SendLinkToAll> {
  int value = 0;
  var main_color = Colors.blue;
  bool allUsersVerified(List<NewUserModel> users) {
  for (var user in users) {
    if (user.verifiedstatus=="unverified" || user.imageurls.isEmpty) {
      return false;
    }
  }
  return true;
}
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
         if(text=="To Download Biodata" && !allUsersVerified(widget.allusers)){
 ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Something went wrong",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
         }else if(text=="To Upload Video"&& !allUsersVerified(widget.allusers)){
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Something went wrong",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
          }else if(text=="To Upload Video"&& allUsersVerified(widget.allusers)){
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Something went wrong",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
          } else{

         
        setState(() {
         SearchProfile().addtoadminnotification(userid:"", useremail:"sldkjf", userimage:"", 
  title: '${userSave.displayName} SEND LINK "$text" TO ${widget.searchtext} ', email:"", subtitle: "");
            AdminService().addtoeachsendlink( value:  text,searchtext: widget.searchtext);
                        ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Send link successfully",
                    appreciation: "",
                    icon: Icons.check,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
          //SmokeStatus = text;
          value = index;
          /*setData().then({
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => Disability()))
          });*/
        });}
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
    return Scaffold(
        appBar: CupertinoNavigationBar(
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
                    child: Text("Send Link")),
              )
            ],
          ),
          previousPageTitle: "",
        ),
        body: Column(
          children: [
           
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                    
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Improve About Me", 1)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton(
                            "To Improve About Partner Preference", 2)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Upload Success Story", 3)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Upload Video", 4)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Save Preference", 5)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Learn How To Use App", 6)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton(
                            "To Save Profession Manually", 7)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child:
                            CustomRadioButton("To Save Education Manually", 8)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Ask Rating", 9)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Upload Photo", 10)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Download Biodata", 11)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Share App", 12)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomRadioButton("To Show Support Reply", 13)),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
