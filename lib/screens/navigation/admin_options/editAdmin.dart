import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';

import 'package:matrimony_admin/screens/profie_types/edit_admins.dart';

import '../../../Assets/ayushWidget/big_text.dart';
import '../../../models/admin_model.dart';
import '../../profie_types/create_admin_service.dart';
import '../../service/search_profile.dart';

// import '../../Assets/G_Sign.dart';
//import '../../models/shared_pref.dart';
//import '../../models/user_model.dart';

//String? SmokeStatus;

class EditAdmin extends StatefulWidget {
  const EditAdmin({Key? key}) : super(key: key);

  @override
  State<EditAdmin> createState() => _ReligionState();
}

class _ReligionState extends State<EditAdmin> {
  int value = 0;
  List<AdminModel> alladmins=[];
  void getalladmins()async{
    alladmins=await CreateAdminService().getalladmins();
    setState(() {
      
    });
  }
  @override
  void initState() {
    getalladmins();
    super.initState();
  }
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          //SmokeStatus = text;
          value = index;
          if(alladmins[index].email=="s9728401234@gmail.com"||alladmins[index].email=="s9053622222@gmail.com" || alladmins[index].email==userSave.email){

          } else{
                 SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
  title: "${userSave.displayName} SEEN SUB-ADMIN ${alladmins[index].username} ACCESS", email: userSave.email!, subtitle: "");
 Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => EditAdminProfile(model: alladmins[index],)));
          }
         
        
        });
      },
      child: Text(
        "Admin-${index + 1} ($text)",
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
          middle:Row(
              children: [
                BigText(
                  text: "Edit Admin",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ), 
          previousPageTitle: "",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
             
                 alladmins.isEmpty?SizedBox(
            height: Get.height*0.6,
            width: Get.width,
           child: Center(
            child: CircularProgressIndicator(color: main_color,),
           ),
                 ):     Column(
                            children: [
                              ListView.builder(
                                itemCount: alladmins.length,
                                shrinkWrap: true,
                                physics:const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                return   Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width * 0.9,
                   child: CustomRadioButton(alladmins[index].username, index)),
                                );
                              },),
                            
                             
                            ],
                 )
            ],
          ),
        ));
  }
}
