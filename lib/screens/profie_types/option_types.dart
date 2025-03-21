// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:matrimony_admin/screens/profile/profileTypes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/Assets/Error.dart';

import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip.dart';
import 'package:matrimony_admin/screens/profie_types/profile_type_scroll.dart';
import 'package:matrimony_admin/screens/profie_types/send_all_notifictaion.dart';
import 'package:matrimony_admin/screens/profie_types/send_link_selected.dart';
import '../../globalVars.dart';
import '../../models/user_model.dart';
import '../ERRORs/search_profile_error.dart';
import '../Search_profile/functionSearch.dart';
import '../Search_profile/search_dynamic_pages.dart';
import '../service/search_profile.dart';

class OptionTypesProfiles extends StatefulWidget {
  final String? searchText;
  final String? title;
  const OptionTypesProfiles({
    Key? key,
    this.searchText,
    this.title,
  }) : super(key: key);

  @override
  State<OptionTypesProfiles> createState() => _ReligionState();
}

class _ReligionState extends State<OptionTypesProfiles> {
  int value = 0;
  String dropdownvalue = 'Action';
  var items = [
    'Action',
    'Profile View',
    'Download Excel',
    'Download Biodata',
    'Send OTP',
    'Send Link'
  ];
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  nameContainer(icon, String head, List<String> val, List<String> options) {
    //val for return value list and options for showing options in dialog
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 25,
                color: main_color,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    head,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sans-serif'),
                  ))
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var ds = await Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => DynamicPage(
                    icon: icon,
                    head: head,
                    options: options,
                    selectedopt: val)));

            if (ds != null) {
              setState(() {
                val.clear();
              });
              for (var i = 0; i < ds.length; i++) {
                setState(() {
                  val.add(ds[i]);
                });
              }
            }
          },
          child: Row(
            children: [
              (val.isEmpty)
                  ? const Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : SizedBox(
                      width: 80,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                val
                                    .toString()
                                    .substring(1, val.toString().length - 1),
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.black38,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 20,
              )
            ],
          ),
        )
      ],
    );
  }

  nameContainer2(icon, String head, Function tap, List<String> val) {
    // onTap = AgeDialog();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 25,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var ds = await tap(context);
            print(ds.toString());
            if (ds != null) {
              // setState(() {
              val.clear();
              // });
              for (var i = 0; i < ds.length; i++) {
                setState(() {
                  val.add(ds[i]);
                });
              }
            }
          },
          child: Row(
            children: [
              (val.isEmpty)
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : (head == "Location")
                      ? Container(
                          width: 150,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    val.toString().substring(
                                        1, val.toString().length - 1),
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        )
                      : SizedBox(
                          width: 65,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "${val[0]} - ${val[1]}",
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 20,
              )
            ],
          ),
        )
      ],
    );
  }

  nameContainer3(icon, String head, Function tap, List<dynamic> val) {
    // onTap = AgeDialog();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 25,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var ds = await tap(context, val);
            print(ds.toString());
            if (ds != null) {
              if (!mounted) return;
              setState(() {
                val.clear();
              });
              for (var element in ds) {
                if (!mounted) return;

                setState(() {
                  val.add(element);
                });
              }
              // setState(() {
              //   val.add(ds[]);
              // });
              // }
            }
          },
          child: Row(
            children: [
              (val[0].isEmpty && val[1].isEmpty && val[2].isEmpty)
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : (val[0].isNotEmpty &&
                          val[1].isNotEmpty &&
                          val[2].isNotEmpty)
                      ? SizedBox(
                          width: Get.width * 0.2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "${val[0][0].toString()},${val[1][0].toString()},${val[2][0].toString()}",
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black38,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : (val[0].isNotEmpty && val[1].isNotEmpty)
                          ? SizedBox(
                              width: Get.width * 0.2,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "${val[0][0].toString()},${val[1][0].toString()}",
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.black38,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          : (val[0].isNotEmpty && val[2].isNotEmpty)
                              ? SizedBox(
                                  width: Get.width * 0.2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "${val[0][0].toString()},${val[2][0].toString()}",
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              : (val[0].isNotEmpty)
                                  ? Text(
                                      (val[0].length > 1)
                                          ? "${val[0][0].toString()} +${val[0].length - 1}"
                                          : val[0][0].toString(),
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : (val[1].isNotEmpty)
                                      ? Text(
                                          (val[1].length > 1)
                                              ? "${val[1][0].toString()} +${val[1].length - 1}"
                                              : val[1][0].toString(),
                                          style: GoogleFonts.poppins(
                                              decoration: TextDecoration.none,
                                              color: Colors.black38,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : Text(
                                          (val[2].length > 1)
                                              ? "${val[2][0].toString()} +${val[2].length - 1}"
                                              : val[2][0].toString(),
                                          style: GoogleFonts.poppins(
                                              decoration: TextDecoration.none,
                                              color: Colors.black38,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 20,
              )
            ],
          ),
        )
      ],
    );
  }

  SavedPref svp = SavedPref();

  nameContainerHeight(
      icon, String head, Function tap, List<String> val, List<String> options) {
    // onTap = AgeDialog();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 25,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var ds = await tap(context);
            print(ds.toString());
            if (ds != null) {
              // setState(() {
              val.clear();
              // });
              for (var i = 0; i < ds.length; i++) {
                setState(() {
                  val.add(ds[i]);
                });
              }
            }
          },
          child: Row(
            children: [
              (val.isEmpty)
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : (head == "Location")
                      ? Container(
                          width: 150,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    val.toString().substring(
                                        1, val.toString().length - 1),
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        )
                      : SizedBox(
                          width: 110,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "${options[int.parse(val[0])].substring(0, 4)}-${options[int.parse(val[1])]}",
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 20,
              )
            ],
          ),
        )
      ],
    );
  }

  double _currentSliderValue = 0;

  bool isloading = false;
  SearchDataList sdl = SearchDataList();
  bool forIos = false;
  bool forIos2 = false;
  @override
  Widget build(BuildContext context) {
    bool borderColor = false;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
          title:
             Text(
              "Option Types ",
              style: TextStyle(color: main_color, fontSize: 23,fontWeight: FontWeight.bold),
            
          ),
    
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Within",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: main_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Sans-serif'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Material(
                    //   child: Slider(
                    //     activeColor: main_color,
                    //     value: _currentSliderValue,
                    //     max: 200,
                    //     divisions: 10,
                    //     label: _currentSliderValue.round().toString(),
                    //     onChanged: (forIos)
                    //         ? (double value) {
                    //             if (!mounted) return;
                    //             setState(() {
                    //               _currentSliderValue = value;
                    //             });
                    //           }
                    //         : null,
                    //   ),
                    // ),
                     Material(
                                    color: Colors.white,
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        valueIndicatorColor:
                                            Colors.black, // Custom Gray Color
                                      ),
                                      child: RangeSlider(
                                        activeColor: main_color,
                                        values: _currentRangeValues,
                                        min: 0,
                                        max: 200,
                                        divisions: 10,
                                        labels: RangeLabels(
                                          _currentRangeValues.start
                                              .round()
                                              .toString(),
                                          _currentRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChanged: (forIos)
                                            ? (RangeValues values) {
                                                if (!mounted) return;

                                                // Enforce a minimum range of 20
                                                if ((values.end -
                                                        values.start) >=
                                                    20) {
                                                  setState(() {
                                                    _currentRangeValues =
                                                        values;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _currentRangeValues =
                                                        RangeValues(
                                                      values.start,
                                                      values.start + 20 > 200
                                                          ? 200
                                                          : values.start + 20,
                                                    );
                                                  });
                                                }
                                              }
                                            : null,
                                      ),
                                    ),
                                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 35,
                          width: 55,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: CupertinoSwitch(
                            // overrides the default green color of the track
                            activeColor: Colors.white,
                            // color of the round icon, which moves from right to left
                            thumbColor: forIos ? main_color : Colors.black12,
                            // when the switch is off
                            trackColor:
                                forIos ? Colors.white : Colors.black12,
                            // boolean variable value
                            value: forIos,
                            // changes the state of the switch
                            onChanged: (value) =>
                                setState(() => forIos = value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
      
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Search By Category",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: main_color,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Sans-serif'),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                
      
                nameContainer2('images/icons/calender.png', "Age",
                    functions().AgeDialog, svp.AgeList),
                const SizedBox(
                  height: 2,
                ),
                nameContainer('images/icons/religion.png', "Religion",
                    svp.ReligionList, sdl.Religion),
                const SizedBox(
                  height: 2,
                ),
                (userSave.religion == "Hindu")
                    ? nameContainer('images/icons/kundli.png', "Kundli Dosh",
                        svp.KundaliDoshList, sdl.KundaliDosh)
                    : Container(),
                const SizedBox(
                  height: 2,
                ),
                nameContainer(
                    'images/icons/marital_status.png',
                    "Marital Status",
                    svp.MaritalStatusList,
                    sdl.MaritalStatus),
                const SizedBox(
                  height: 2,
                ),
                nameContainer(
                    'images/icons/food.png', "Diet", svp.dietList, sdl.Diet),
                const SizedBox(
                  height: 2,
                ),
                nameContainer('images/icons/smoke.png', "Smoke",
                    svp.SmokeList, sdl.Smoke),
                const SizedBox(
                  height: 2,
                ),
                nameContainer('images/icons/drink.png', "Drink",
                    svp.DrinkList, sdl.Drink),
                const SizedBox(
                  height: 2,
                ),
                nameContainer('images/icons/disability.png', "Disability",
                    svp.DisabilityList, sdl.Disability),
                const SizedBox(
                  height: 2,
                ),
                nameContainerHeight('images/icons/height.png', "Height",
                    functions().HeightDialog, svp.HeightList, sdl.Height),
                // HeightList, sdl.Height),
                const SizedBox(
                  height: 1,
                ),
                nameContainer('images/icons/education.png', "Education",
                    svp.EducationList, sdl.Education),
                const SizedBox(
                  height: 1,
                ),
                nameContainer('images/icons/profession_suitcase.png',
                    "Profession", svp.ProfessionList, sdl.Profession),
                const SizedBox(
                  height: 1,
                ),
                nameContainer('images/icons/hand_rupee.png', "Income",
                    svp.IncomeList, sdl.Income),
                const SizedBox(
                  height: 1,
                ),
                nameContainer3('images/icons/location.png', "Location",
                    functions().LocationDialog, svp.LocatioList),
                const SizedBox(
                  height: 1,
                ),
                // nameContainer2(
                //     'images/icons/location.png',
                //     "Location",
                //     functions().LocationDialog,
                //     svp.LocatioList),
                const SizedBox(
                  height: 1,
                ),
      
                SizedBox(
                  height: 50,
                ),
               
                isloading == false
                    ? Container()
                    : Center(child: Text("Downloading")),
                SizedBox(
                  height: 20,
                ),
                 Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    side: BorderSide(
                                      color: borderColor
                                          ? main_color
                                          : Colors.white,
                                    ))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white)),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    side: BorderSide(
                                      color: borderColor
                                          ? main_color
                                          : Colors.white,
                                    ))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white)),
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
