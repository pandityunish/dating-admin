import 'package:matrimony_admin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../search.dart';

class SearchProfileError extends StatefulWidget {
  const SearchProfileError({Key? key}) : super(key: key);

  @override
  State<SearchProfileError> createState() => _SearchProfileErrorState();
}

class _SearchProfileErrorState extends State<SearchProfileError> {
  TextEditingController _searchController = TextEditingController();
  double _currentSliderValue = 0;
  double _startValue = 20.0;
  double _endValue = 90.0;

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
          middle: Row(
            children: [
              // Icon(
              //   Icons.chevron_left,
              //   size: 45,
              //   color: Colors.black,
              // ),
              BigText(
                text: "Search Profile",
                size: 20,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          previousPageTitle: "",
        ),
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
                          image:
                              AssetImage("images/icons/save_pref_error.png"))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 18, bottom: 120),
                  child: Text(
                      "Sorry! No Match Found. Please Change your Search Criteria for Better Results",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif')),
                ),
                new SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          // side: BorderSide(color: Colors.black),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text(
                      "Search Again",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            // ),
          ),
        ));
  }
}
