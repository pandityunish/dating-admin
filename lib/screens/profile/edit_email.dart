
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

import '../../common/widgets/custom_special_button.dart';



class EditEmail extends StatefulWidget {
 final String email;
  const EditEmail({Key? key, required this.email, }) : super(key: key);

  @override
  State<EditEmail> createState() => _ReligionState();
}

class _ReligionState extends State<EditEmail> {
  int value = 0;
  bool color = false;
  final TextEditingController controller=TextEditingController();
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
    return CupertinoPageScaffold(
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
          middle: Container(
      
            child: DefaultTextStyle(
                style: GoogleFonts.poppins(color: main_color, fontSize: 25),
                child: Text("Edit Email")),
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
                    Material(
                      child: Card(
                        elevation: 5,
                        // shape: ,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          height: 50,
                          width: Get.width*0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(255, 223, 223, 223))),
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                                hintText: "Please Enter email"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                    ),
                    Material(
                      child: InkWell(
                          onTap: () {
                            print(controller.text);
                          SearchProfile().updateemail(email: widget.email, editemail: controller.text);
                          controller.clear();
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SnackBarContent(
                                      error_text: "Update Successfull",
                                      appreciation: "",
                                      icon: Icons.error,
                                      sec: 3,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                                Navigator.pop(context);
                          },
                          child: Card(
                               elevation: 5,
                        // shape: ,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            child: CustomSpecialButtom(
                              text: "Save",
                              button_pressed: null,
                              bordercolor:
                                  Colors.white,
                            ),
                          )),
                    ),
                   
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
