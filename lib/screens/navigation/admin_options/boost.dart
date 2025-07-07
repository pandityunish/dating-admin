
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';

import '../../../Assets/Error.dart';
import '../../../models/history_save_pref.dart';
import '../../../models/new_user_model.dart';
import '../../service/search_profile.dart';
import 'boostProfile.dart';
import 'custom_spButton.dart';


class Boost extends StatefulWidget {
  final NewUserModel newUserModel;
  
  const Boost({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<Boost> createState() => _ReligionState();
}

class _ReligionState extends State<Boost> {
  int value = 0;
  bool color = false;
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
          color: (value == index) ? Colors.blue : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? Colors.blue : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          preferredSize: const Size.fromHeight(80), // Adjust AppBar height
          child: AppBar(
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
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(
                  top: 20), // Adjust padding for alignment
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      //FontAwesomeIcons.bolt,
                      Icons.offline_bolt_outlined,
                      color: main_color,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: main_color,
                        fontFamily: 'Sans-serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      child: Text("Boost Profile"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
           
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSpecialButtom(
                      text: "Boost To Save Preference",
                      bordercolor: Colors.black,
                      onTap: () {
                        if(widget.newUserModel.status=="approved"){
                        SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} BOOST ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} IN ALL DATABASE", email: userSave.email!, subtitle: "");
                          AdminService().boosttoallprofile(value: widget.newUserModel.puid,gender: widget.newUserModel.gender=="male"?"female":"male").whenComplete((){
                             showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Boost To All Successfully",
                                    appreciation: "",
                                    icon: Icons.check_circle_sharp,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              }).whenComplete((){
                    Navigator.push(context,                                   MaterialPageRoute(
                                builder: (context) => MyProfile(
                                  profilecomp: 50,
                                      userSave: widget.newUserModel!,
                                      isDelete:false,
                                    )));
                              });
                       }).whenComplete((){
                    
                       });
                            
                          }else{
                             SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} TRIED TO BOOST ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} PROFILE (ERROR)", email: userSave.email!, subtitle: "");
                             showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Approve The User First",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                          }
                          
                          
                        },
                    ),
                    CustomSpecialButtom(
                      text: "Boost To All",
                      bordercolor: Colors.black,
                      onTap: () async{
                        if(widget.newUserModel.status=="approved"){
                            List<HistorySavePref> 
                             history_save_pref =
                            await AdminService().getsavepref(id: widget.newUserModel.id);
                            if(history_save_pref.isEmpty){
                                SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} TRIED TO BOOST ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} TO SAVED PREFERENCE (ERROR)", email: userSave.email!, subtitle: "");
                              showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Preference Required",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                            }else{
                    showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Boost To Save Preference Successfully",
                                    
                                    appreciation: "",
                                    icon: Icons.check_circle_sharp,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              }).whenComplete((){
                                   Navigator.push(context,                                   MaterialPageRoute(
                                builder: (context) => MyProfile(
                                  profilecomp: 50,
                                      userSave: widget.newUserModel!,
                                      isDelete:false,
                                    )));
                              });
                                 SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} BOOST ${widget.newUserModel.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} TO SAVED PREFERENCE", email: userSave.email!, subtitle: "");
                        AdminService().boosttoallprofile(value: widget.newUserModel.puid,gender: widget.newUserModel.gender=="male"?"female":"male");
                    
                            }
                           
                         
                             }else{
                                        showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Please Approve The User First",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                                    }
                        },
                    ),
                    CustomSpecialButtom(
                      text: "Boost To Particular Profile",
                      bordercolor: Colors.black,
                      onTap: () {
                        if(widget.newUserModel.status=="approved"){
                   
                                Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0),
                pageBuilder: (_, __, ___) => BoostProfile(newUserModel: widget.newUserModel,)));
                           }else{
                            
                           }
                         
                        },
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
