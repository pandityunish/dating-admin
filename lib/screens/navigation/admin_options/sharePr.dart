import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:matrimony_admin/screens/admin/Csp_Button_2.dart';
// import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

// import '../../Assets/G_Sign.dart';
import 'custom_spButton.dart';
// import '../../models/shared_pref.dart';
// import '../../models/user_model.dart';

//String? SmokeStatus;

class ShareProfile extends StatefulWidget {
  final NewUserModel userSave;
  const ShareProfile({Key? key, required this.userSave}) : super(key: key);

  @override
  State<ShareProfile> createState() => _ReligionState();
}

class _ReligionState extends State<ShareProfile> {
  int value = 0;
  bool color = false;
  String error = "";
  List<String> profileid = [];
  TextEditingController controller = TextEditingController();
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
                      Icons.ios_share_sharp,
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
                      child: Text("Share Profile"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
     
        body: Column(
          children: [
           
            Expanded(
              child: Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            )),
                        child: TextFormField(
                          controller: controller,
                          textAlign: TextAlign.start,
                          cursorColor: main_color,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
                              border: InputBorder.none,
                              hintText: "Enter Profile ID",
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16)),
                          onFieldSubmitted: (value) async {
                        int status;
                        status = await AdminService().findprofile(value);
                        if (status == 200) {
                          NewUserModel newUserModel = await SearchProfile()
                              .searchuserdatabyid(puid: value);
                          if (newUserModel.gender ==
                              widget.userSave.gender) {
                                SearchProfile().addtoadminnotification(
                              userid: widget.userSave!.id!,
                              useremail: widget.userSave!.email!,
                              userimage: widget.userSave!.imageurls!.isEmpty
                                  ? ""
                                  : widget.userSave!.imageurls![0],
                              title:
                                  '${userSave.displayName} TRIED TO SHARE  ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave!.puid} (Error)',
                              email: userSave.email!,
                              subtitle: "");
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      child: SnackBarContent(
                                        error_text:
                                            "Same Gender Can't Be Added",
                                        appreciation: "",
                                        icon: Icons.error,
                                        sec: 3,
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } else if (widget.userSave.puid == value) {
                            SearchProfile().addtoadminnotification(
                              userid: widget.userSave!.id!,
                              useremail: widget.userSave!.email!,
                              userimage: widget.userSave!.imageurls!.isEmpty
                                  ? ""
                                  : widget.userSave!.imageurls![0],
                              title:
                                  '${userSave.displayName} TRIED TO SHARE PROFILE OF ${value} PROFILES TO ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave!.puid}',
                              email: userSave.email!,
                              subtitle: "");
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      child: SnackBarContent(
                                        error_text:
                                            "Same uid Cannot Be Added",
                                        appreciation: "",
                                        icon: Icons.error,
                                        sec: 3,
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } else if (newUserModel.status != "approved") {
                            SearchProfile().addtoadminnotification(
                              userid: widget.userSave!.id!,
                              useremail: widget.userSave!.email!,
                              userimage: widget.userSave!.imageurls!.isEmpty
                                  ? ""
                                  : widget.userSave!.imageurls![0],
                              title:
                                  '${userSave.displayName} TRIED TO SHARE PROFILE OF ${value} PROFILES TO ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave!.puid}',
                              email: userSave.email!,
                              subtitle: "");
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      child: SnackBarContent(
                                        error_text: "User is Not approved",
                                        appreciation: "",
                                        icon: Icons.error,
                                        sec: 3,
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } else {
                            profileid.add(value);
                            setState(() {});
                            controller.clear();
                          }
                        } else {
                           SearchProfile().addtoadminnotification(
                              userid: widget.userSave!.id!,
                              useremail: widget.userSave!.email!,
                              userimage: widget.userSave!.imageurls!.isEmpty
                                  ? ""
                                  : widget.userSave!.imageurls![0],
                              title:
                                  '${userSave.displayName} TRIED TO SHARE PROFILE OF ${value} PROFILES TO ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave!.puid}',
                              email: userSave.email!,
                              subtitle: "");
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    child: SnackBarContent(
                                      error_text: "User Not Found",
                                      appreciation: "",
                                      icon: Icons.error,
                                      sec: 3,
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        }
                      },
                    ),
                  ),)),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                    ),
                    shrinkWrap: true,
                    itemCount: profileid.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      profileid[index],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        profileid.remove(profileid[index]);
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
               
                 
                ],
              ),
                            ),
                          ),
            ),
                         InkWell(
                             onTap: () async {
                               // int status;
                               // status = await AdminService()
                               //     .findprofile(controller.text);
                               // if (status == 200) {
                               if (profileid.isEmpty) {
                                 showDialog(
                                     context: context,
                                     barrierDismissible: false,
                                     builder: (context) {
                                       return AlertDialog(
                                         content: SizedBox(
                                           child: SnackBarContent(
                                             error_text: "Please Enter Profile ID",
                                             appreciation: "",
                                             icon: Icons.error,
                                             sec: 3,
                                           ),
                                         ),
                                         backgroundColor: Colors.transparent,
                                         elevation: 0,
                                       );
                                     });
                               } else {
                                 SearchProfile().addtoadminnotification(
                                     userid: widget.userSave!.id!,
                                     useremail: widget.userSave!.email!,
                                     userimage: widget.userSave!.imageurls!.isEmpty
                                         ? ""
                                         : widget.userSave!.imageurls![0],
                                     title:
                                         '${userSave.displayName} SHARE PROFILE OF ${profileid} PROFILES TO ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname.toLowerCase()} ${widget.userSave!.puid}',
                                     email: userSave.email!,
                                     subtitle: "");
                                 for (var i = 0; i < profileid.length; i++) {
                                   AdminService()
                                       .boosttouser(
                                           value: widget.userSave.id,
                                           puid: profileid[i])
                                       .whenComplete(() {
                                     showDialog(
                                         context: context,
                                         barrierDismissible: false,
                                         builder: (context) {
                                           return AlertDialog(
                                             content: SizedBox(
                                               child: SnackBarContent(
                                                 error_text:
                                                     "Share Profile Successfully",
                                                 appreciation: "",
                                                 icon: Icons.done,
                                                 sec: 3,
                                               ),
                                             ),
                                             backgroundColor: Colors.transparent,
                                             elevation: 0,
                                           );
                                         }).whenComplete((){
                                            Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => MyProfile(
                                               profilecomp: 50,
                                               userSave: widget.userSave,
                                               isDelete: false,
                                             )));
                                         });
                                     profileid.clear();
                                     setState(() {});
                                   }).whenComplete((){
                               
                                   });
                                 }
                               
                                
                               }
                               // }else{
                               //    showDialog(
                               //     context: context,
                               //     barrierDismissible: false,
                               //     builder: (context) {
                               //       return AlertDialog(
                               //         content: SizedBox(
                               //           child: SnackBarContent(
                               //             error_text:
                               //                 "Please enter valid profile id",
                               //             appreciation: "",
                               //             icon: Icons.error,
                               //             sec: 3,
                               //           ),
                               //         ),
                               //         backgroundColor: Colors.transparent,
                               //         elevation: 0,
                               //       );
                               //     });
                               // }
                             },
                             child: CustomSpecialButtom(
                               text: "Share",
                               bordercolor:
                                   color == false ? Colors.black : Colors.blue,
                             )),
          ],
        ));
  }
}
