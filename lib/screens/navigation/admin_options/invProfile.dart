import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:matrimony_admin/screens/admin/Csp_Button_2.dart';
// import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';

// import '../../Assets/G_Sign.dart';
import '../../../Assets/Error.dart';
import '../../../globalVars.dart';
import '../../service/search_profile.dart';
import 'custom_spButton.dart';
import 'service/admin_service.dart';
// import '../../models/shared_pref.dart';
// import '../../models/user_model.dart';

//String? SmokeStatus;

class InvisibleProfile extends StatefulWidget {
  final NewUserModel newUserModel;
  const InvisibleProfile({Key? key, required this.newUserModel})
      : super(key: key);

  @override
  State<InvisibleProfile> createState() => _ReligionState();
}

class _ReligionState extends State<InvisibleProfile> {
  int value = 0;
  bool color = false;
  final TextEditingController controller = TextEditingController();
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
        appBar: CustomAppBar(
          title: "Invisible Profile",
          iconImage: "images/icons/invisible.png",
          height: 80,
        ),
        body: Column(
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
                        height: 48,
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
            InkWell(
              onTap: () async {
                if (controller.text.isEmpty) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: SnackBarContent(
                            error_text: "Please enter profile id",
                            appreciation: "",
                            icon: Icons.error,
                            sec: 3,
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        );
                      });
                } else {
                  NewUserModel newUserModel = await SearchProfile()
                      .searchuserdatabyid(puid: controller.text);
                  if (newUserModel.gender == widget.newUserModel.gender) {
                    Get.showSnackbar(const GetSnackBar(
                      title: "Same gender",
                      message: "Same gender cannot be added",
                      duration: Duration(seconds: 2),
                    ));
                  } else if (userSave.puid == controller.text) {
                    Get.showSnackbar(const GetSnackBar(
                      title: "Same uid",
                      message: "Same uid cannot be added",
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    SearchProfile().addtoadminnotification(
                        userid: widget.newUserModel.id!,
                        useremail: widget.newUserModel.email!,
                        userimage: widget.newUserModel.imageurls!.isEmpty
                            ? ""
                            : widget.newUserModel.imageurls![0],
                        title:
                            "${userSave.displayName} INVISIBLE ${widget.newUserModel.name.substring(0, 1).toUpperCase()} ${widget.newUserModel.surname.toLowerCase()} ${widget.newUserModel.puid}",
                        email: userSave.email!,
                        subtitle: "");
                    AdminService()
                        .invisibletouser(
                            value: widget.newUserModel.id,
                            puid: controller.text)
                        .whenComplete(() {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SnackBarContent(
                                error_text: "Invisible Successfully",
                                appreciation: "",
                                icon: Icons.done,
                                sec: 3,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            );
                          }).whenComplete(() {
                        Get.to(MyProfile(
                            userSave: widget.newUserModel,
                            profilecomp: 50));
                      });
                    }).whenComplete(() {});
                  }
                }
              },
              child: CustomSpecialButtom(
                text: "Invisible",
                onTap: () {},
                bordercolor: color == false ? Colors.black : Colors.blue,
              ),
            ),
                
          ],
        ));
  }
}
