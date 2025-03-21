import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:matrimony_admin/screens/admin/Csp_Button_2.dart';
// import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/disability.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/Charts/all_admins.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/Charts/nextchart_screen.dart';

import '../../../../common/widgets/custom_special_button.dart';

// import '../../Assets/G_Sign.dart';

// import '../../models/shared_pref.dart';
// import '../../models/user_model.dart';

//String? SmokeStatus;

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ReligionState();
}

class _ReligionState extends State<ChartsScreen> {
  int value = 0;
  bool color = false;
  // ignore: non_constant_identifier_names
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
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
              const EdgeInsets.symmetric(vertical: 20)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? Colors.blue : Colors.white))),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title:  Text("Manage Charts",  style: TextStyle(color: main_color, fontSize: 23,fontWeight: FontWeight.bold),),
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
             
              Center(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: CustomSpecialButtom(
                            button_pressed: () {
                              Get.to(() => const NextchartScreen(
                                    title: "User Chart",
                                  ));
                            },
                            text: "User Charts",
                            bordercolor:
                                color == false ? Colors.black : Colors.blue,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {},
                          child: CustomSpecialButtom(
                            button_pressed: () {
                              Get.to(() => const AllAdmins());
                            },
                            text: "Admin Charts",
                            bordercolor:
                                color == false ? Colors.black : Colors.blue,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
