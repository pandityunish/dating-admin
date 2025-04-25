import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/home.dart';
import 'package:share_plus/share_plus.dart';
import '../../Assets/ayushWidget/big_text.dart';
import '../../Assets/calender.dart';
import '../../globalVars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class BioData extends StatefulWidget {
  final NewUserModel newUserModel;
  const BioData({super.key, required this.newUserModel});

  @override
  State<BioData> createState() => _BioDataState();
}

class _BioDataState extends State<BioData> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              Container(
                // margin: EdgeInsets.only(right: 10),
                child: BigText(
                  text: "Matrimonial Biodata",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // SizedBox(
              //   width: 20,
              // )
            ],
          ),
          titleSpacing: 5.0,
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
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   margin: EdgeInsets.only(top: 13),
              //   padding: EdgeInsets.only(top: 25, left: 20, bottom: 15),
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(right: 5),
              //         child: GestureDetector(
              //           onTap: () => Navigator.of(context).pop(),
              //           child: Icon(
              //             Icons.arrow_back_ios_rounded,
              //             color: main_color,
              //             size: 20,
              //           ),
              //         ),
              //       ),
              //       BigText(
              //         text: "Matrimonial Biodata",
              //         size: 20,
              //         color: main_color,
              //         fontWeight: FontWeight.w700,
              //       )
              //     ],
              //   ),
              // ),
              // resume_design()
              PdfDesign(
                userSave: widget.newUserModel,
              )
            ],
          ),
        ),
      ),
    );
  }
}
