import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/data_collection/martial_status.dart';

import 'custom_spButton.dart';

class PrVerify extends StatefulWidget {
  const PrVerify({Key? key}) : super(key: key);

  @override
  State<PrVerify> createState() => _ReligionState();
}

class _ReligionState extends State<PrVerify> {
  int value = 0;
  bool color = false;
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightBlue, //change your color here
          ),
          title: Text("Profile Verified",
              style: GoogleFonts.poppins(color: Colors.blue)),
          //centerTitle: true,
          backgroundColor: Colors.white,
          // mainAxisAlignment: MainAxisAlignment.center,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Pending to approve",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    //fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: FloatingActionButton(
                    onPressed: onPressed,
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Uploaded 23 Dec 2022",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 200,
                ),
                Text(
                  "How to upload video seen 21 Dec 2022",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: CustomSpecialButtom(
                      text: "Approve",
                      bordercolor: color == false ? Colors.black : Colors.blue,
                    )),
                InkWell(
                    onTap: () {},
                    child: CustomSpecialButtom(
                      text: "Decline",
                      bordercolor: color == false ? Colors.black : Colors.blue,
                    )),
                InkWell(
                    onTap: () {},
                    child: CustomSpecialButtom(
                      text: "Download",
                      bordercolor: color == false ? Colors.black : Colors.blue,
                    )),
                InkWell(
                    onTap: () {},
                    child: CustomSpecialButtom(
                      text: "Delete",
                      bordercolor: color == false ? Colors.black : Colors.blue,
                    )),
              ],
            ),
          ),
        ));
  }
}
