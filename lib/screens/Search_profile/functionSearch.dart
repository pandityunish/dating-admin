import 'package:matrimony_admin/screens/Search_profile/age_female_selection.dart';
import 'package:matrimony_admin/screens/Search_profile/drink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Assets/countryModel/country_state_city_picker.dart';
import '../../globalVars.dart';
import '../../models/new_user_model.dart';
import 'age_search.dart';
import 'height_Screen.dart';
import 'locationSearch.dart';

class functions {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentSliderValue = 0;
  double _startValue = 20.0;
  double _endValue = 90.0;
  var startValue = 0.0;
  var endValue = 0.0;
  int value = 2;
  List<int> valueList = [];
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        // set
        // setState(() {
        //   // DrinkStatus = text;
        //   value = index;
        //   // setData().then({Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Smoke()))});
        // });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? main_color : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  Future<void> AgeDialog(BuildContext context)async {
    var res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => AgeSelectionScreen()));
    return res;
  }
Future<void> FemaleAgeDialog(BuildContext context)async {
    var res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => FemaleAgeSelectionScreen()));
    return res;
  }
  Future<void> HeightDialog(BuildContext context) async {
    var res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => HeightScreens()));
    return res;
  }

  Future LocationDialog(BuildContext context, var locationlist) async {
    var res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (builder) => SelectStateData(list: locationlist)));
    return res;
  }

  Future<void> DrinkDialog(BuildContext context, IconData icon, String head,
      List<String> options, List<String> selectedopt) async {
    if (selectedopt.isNotEmpty) {
      for (var i = 0; i < selectedopt.length; i++) {
        valueList.add(
            options.indexWhere((element) => selectedopt[i] == element) + 1);
      }
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return
            // Flexible(
            //   child:
            StatefulBuilder(builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    head,
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  Icon(
                    icon,
                    color: Colors.black38,
                  )
                ],
              ),

              // content: Text('Drag the age bar to select your desired age group '),

              content: Drink(value: valueList, option: options),

              actions: [
                new SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                      // textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop("cancel");
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.black))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white))),
                ),
                new SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                      // textColor: Colors.black,
                      onPressed: () {
                        List<String> ds = [];
                        for (var i = 0; i < valueList.length; i++) {
                          ds.add(options[valueList[i] - 1]);
                        }
                        Navigator.of(context).pop(ds);
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.black))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white))),
                ),
              ],
            ),
          );
        });

        // );
      },
    );
  }
}
