import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/editAdmin.dart';
import 'package:matrimony_admin/screens/profie_types/createAdmin.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../service/search_profile.dart';

class ManageAdmin extends StatefulWidget {
  const ManageAdmin({super.key});

  @override
  State<ManageAdmin> createState() => _ManageAdminState();
}

class _ManageAdminState extends State<ManageAdmin> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: Colors.white,
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
            // middle: Icon(
            //   Icons.supervised_user_circle_outlined,
            //   // color: ma/
            //   size: 30,
            // ),

            middle: Row(
              children: [
                BigText(
                  text: "Manage Admins",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),

            // TextSpan(
            //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),

            previousPageTitle: "",
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
               SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                          SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
  title: "${userSave.displayName} CLICK CREATE ADMIN", email: userSave.email!, subtitle: "");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAdmin(),
                            ));
                      },
                      child: Text(
                        "Create Admin",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(color: Colors.white))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                           SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!, userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
  title: "${userSave.displayName} CLICK EDIT ADMIN", email: userSave.email!, subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditAdmin(),
                          ));
                    },
                    child: Text(
                      "Edit Admin",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            EdgeInsets.symmetric(vertical: 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    side: BorderSide(color: Colors.white))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
