import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';

import '../../data_collection/custom_app_bar.dart';
import '../../service/search_profile.dart';
import 'custom_spButton.dart';

class BoostProfile extends StatefulWidget {
  final NewUserModel newUserModel;
  const BoostProfile({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<BoostProfile> createState() => _ReligionState();
}

class _ReligionState extends State<BoostProfile> {
  int value = 0;
  bool color = false;
  final TextEditingController controller = TextEditingController();
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          //SmokeStatus = text;
          value = index;
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
        appBar: PreferredSize(
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
        // navigationBar: CupertinoNavigationBar(

        //       leading: GestureDetector(
        //       onTap: () {
        //         Navigator.of(context).pop();

        //       },
        //       child: Icon(
        //         Icons.arrow_back_ios_new,
        //         color: main_color,
        //         size: 25,
        //       ),
        //     ),
        //   middle: Container(
        //     margin: EdgeInsets.only(right: 20),
        //     child: DefaultTextStyle(
        //         style: GoogleFonts.poppins(color: main_color, fontSize: 25),
        //         child: Text("Boost Profile             ")),
        //   ),
        //   previousPageTitle: "",
        // ),
        body: Column(
          children: [
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  Expanded(
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
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
                                    border: InputBorder.none,
                                    hintText: "Enter Profile ID",
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSpecialButtom(
                    text: "Boost",
                    onTap: ()async {
                      if (controller.text.isEmpty) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: SnackBarContent(
                                error_text: "Please Enter Profile ID",
                                appreciation: "",
                                icon: Icons.error,
                                sec: 3,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            );
                          });
                    } else {
                      int status;
                      status =
                          await AdminService().findprofile(controller.text);
                      if (status == 200) {
                        NewUserModel newUserModel = await SearchProfile()
                            .searchuserdatabyid(puid: controller.text);
                        if (newUserModel.gender ==
                            widget.newUserModel.gender) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Please Enter Valid Gender",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        } else if (widget.newUserModel.puid ==
                            controller.text) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: SnackBarContent(
                                    error_text: "Please Enter Different ID",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        } else if (newUserModel.status != "approved") {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: SnackBarContent(
                                    error_text:
                                        "Profile Should Be Approved",
                                    appreciation: "",
                                    icon: Icons.error,
                                    sec: 3,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                        } else {
                          SearchProfile().addtoadminnotification(
                              userid: widget.newUserModel!.id!,
                              useremail: widget.newUserModel!.email!,
                              userimage:
                                  widget.newUserModel!.imageurls!.isEmpty
                                      ? ""
                                      : widget.newUserModel!.imageurls![0],
                              title:
                                  "${userSave.displayName} BOOST ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid}",
                              email: userSave.email!,
                              subtitle: "");
                  
                          if (widget.newUserModel.boostprofile!
                              .contains(controller.text)) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: SnackBarContent(
                                      error_text: "Profile Already Boosted",
                                      appreciation: "",
                                      icon: Icons.done,
                                      sec: 3,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          } else {
                            AdminService()
                                .boosttouser(
                                    puid: widget.newUserModel.puid,
                                    value: newUserModel.id)
                                .whenComplete(() {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: SnackBarContent(
                                        error_text: "Boost Successfull",
                                        appreciation: "",
                                        icon: Icons.done,
                                        sec: 3,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    );
                                  });
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfile(
                                          profilecomp: 50,
                                          userSave: widget.newUserModel!,
                                          isDelete: false,
                                        )));
                          }
                        }
                      } else {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: SnackBarContent(
                                  error_text:
                                      "Please Enter Valid Profile ID",
                                  appreciation: "",
                                  icon: Icons.error,
                                  sec: 3,
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                            });
                      }
                    }
                    
                    },
                    bordercolor:
                        color == false ? Colors.black : Colors.blue,
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => BoostProfile(
                  //                 newUserModel: widget.newUserModel,
                  //               )));
                  //     },
                  //     child: CustomSpecialButtom(
                  //       text: "Cancel",
                  //       bordercolor:
                  //           color == false ? Colors.black : Colors.blue,
                  //     )),
                ],
              ),
            ))
          ],
        ));
  }
}
