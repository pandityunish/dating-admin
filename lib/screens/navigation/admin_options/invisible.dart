import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:matrimony_admin/screens/admin/Csp_Button_2.dart';
// import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

// import '../../Assets/G_Sign.dart';
import '../../../Assets/Error.dart';
import '../../../globalVars.dart';
import '../../../models/new_user_model.dart';
import 'boostProfile.dart';
import 'custom_spButton.dart';
import 'invProfile.dart';
import 'service/admin_service.dart';
// import '../../models/shared_pref.dart';
// import '../../models/user_model.dart';

//String? SmokeStatus;

class Invisible extends StatefulWidget {
  final NewUserModel newUserModel;
  const Invisible({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<Invisible> createState() => _ReligionState();
}

class _ReligionState extends State<Invisible> {
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
        appBar:CustomAppBar(title: "Invisible Profile", iconImage: "images/icons/invisible.png",height: 80,),
       
        body: Column(
          children: [
            
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                            SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} INVISIBLE ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} IN ALL DATABASE", email: userSave.email!, subtitle: "");
                          AdminService().invisibletoallprofile(value: widget.newUserModel.puid).whenComplete((){
                             showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Invisible for All Successfully",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                          }).whenComplete((){
                                 Get.to(MyProfile(
                                    userSave: widget.newUserModel,
                                    profilecomp: 50));
                                 
                              });;
                            
                        },
                        child: CustomSpecialButtom(
                          text: "Invisible for All",
                          bordercolor:
                              color == false ? Colors.black : Colors.blue,
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InvisibleProfile(newUserModel: widget.newUserModel,)));
                        },
                        child: CustomSpecialButtom(
                          text: "Invisible for Particular",
                          bordercolor:
                              color == false ? Colors.black : Colors.blue,
                        )),
                    InkWell(
                        onTap: () {
                            SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                      title: "${userSave.displayName} INVISIBLE ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} PROFILE TO NEARBY", email: userSave.email!, subtitle: "");
                       showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Invisible for Nearyby Successfully",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              }).whenComplete((){
                                 Get.to(MyProfile(
                                    userSave: widget.newUserModel,
                                    profilecomp: 50));
                                 
                              });
                          
                        },
                        child: CustomSpecialButtom(
                          text: "Invisible for Nearby 20 Km",
                          bordercolor:
                              color == false ? Colors.black : Colors.blue,
                        )),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
