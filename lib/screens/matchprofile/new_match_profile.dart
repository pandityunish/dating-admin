
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/matchprofile/match_perticular_profile.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/custom_spButton.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';

import '../../../Assets/Error.dart';
import '../../../models/history_save_pref.dart';
import '../../../models/new_user_model.dart';
import '../service/search_profile.dart';
import 'match_scroll.dart';



class NewMatchProfile extends StatefulWidget {
  final NewUserModel newUserModel;
  
  const NewMatchProfile({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<NewMatchProfile> createState() => _ReligionState();
}

class _ReligionState extends State<NewMatchProfile> {
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
        appBar:CustomAppBar(title: "Match Profile", iconImage: "images/person.png",height: 80,),
        body: Column(
          children: [
           
            SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                   
                          SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                        title: "${userSave.displayName} MATCH ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} WITH ALL PROFILES", email: userSave.email!, subtitle: "");
                                     Get.to(MatchSlideProfile(
                    userSave: widget.newUserModel,
                    notiPage: true));
                                    
                                  },
                                  child: CustomSpecialButtom(
                                    text: "Match To All",
                                    bordercolor:
              color == false ? Colors.black : Colors.blue,
                                  )),
                              InkWell(
                                  onTap: () async{
                                   SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                                                          title: "${userSave.displayName} MATCH ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} WITH ALL SAVED PREFERENCE", email: userSave.email!, subtitle: "");
                                            List<HistorySavePref> 
                                             history_save_pref =
                                await AdminService().getsavepref(id: widget.newUserModel.id);
                                // print(object)
                                if(history_save_pref.isEmpty){
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
                                                          Get.to(MatchSlideProfile(
                                                    userSave: widget.newUserModel,
                                                    notiPage: true));
                                }
                                          
                                                    
                                  },
                                  child: CustomSpecialButtom(
                                          text: "Match To Saved Preference",
                                          bordercolor:
                                              color == false ? Colors.black : Colors.blue,
                                  )),
                              InkWell(
                                  onTap: () {
                                   SearchProfile().addtoadminnotification(userid: widget.newUserModel!.id!, useremail:widget.newUserModel!.email!, userimage:widget.newUserModel!.imageurls!.isEmpty?"":widget.newUserModel!.imageurls![0], 
                        title: "${userSave.displayName} MATCH ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} WITH PERTICUALR PROFILE", email: userSave.email!, subtitle: "");
                                   Get.to(MatchPerticularProfile(
                    newUserModel: widget.newUserModel,
                   ));
                                  },
                                  child: CustomSpecialButtom(
                                    text: "Match To Particular Profile",
                                    bordercolor:
              color == false ? Colors.black : Colors.blue,
                                  )),
                            ],
                          ),
                        ),
            )
          ],
        ));
  }
}
