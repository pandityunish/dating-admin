import 'package:matrimony_admin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../search_preferences/saved_preferences.dart';
// import '../Assets/ayushWidget/big_text.dart';
// import 'search.dart';

class SavePreferencesError extends StatefulWidget {
  const SavePreferencesError({Key? key}) : super(key: key);

  @override
  State<SavePreferencesError> createState() => _SavePreferencesErrorState();
}

class _SavePreferencesErrorState extends State<SavePreferencesError> {
  TextEditingController _searchController = TextEditingController();
  double _currentSliderValue = 0;
  double _startValue = 20.0;
  double _endValue = 90.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // navigationBar: CupertinoNavigationBar(
        //   middle: Row(
        //     children: [
        //       // Icon(
        //       //   Icons.chevron_left,
        //       //   size: 45,
        //       //   color: Colors.black,
        //       // ),
        //       BigText(
        //         text: "Save Preferences",
        //         size: 20,
        //         color: main_color,
        //         fontWeight: FontWeight.w700,
        //       )
        //     ],
        //   ),
        //   previousPageTitle: "",
        // ),
        child: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 10, right: 15),
        // child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/images/search.png"))),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, bottom: 150),
              child: Text(
                "No record Found, Please Refresh",
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
                child: Text("Refresh"),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SearchPreferences(history_save_pref: [],newUserModel: ,)));
                },
              ),
            ),
          ],
        ),
        // ),
      ),
    ));
  }
}
