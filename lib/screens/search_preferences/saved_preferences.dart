import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/models/history_save_pref.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import '../../Assets/Error.dart';
import '../../Assets/ayushWidget/big_text.dart';
import '../../models/user_model.dart';
import '../../sendUtils/notiFunction.dart';
import '../Search_profile/functionSearch.dart';
import '../Search_profile/search_dynamic_pages.dart';
import '../profile/profileScroll.dart';

class SearchPreferences extends StatefulWidget {
  final NewUserModel newUserModel;
  final List<HistorySavePref> history_save_pref;
  const SearchPreferences(
      {Key? key, required this.history_save_pref, required this.newUserModel})
      : super(key: key);

  @override
  State<SearchPreferences> createState() => _SearchPreferencesState();
}

class _SearchPreferencesState extends State<SearchPreferences> {
  var startValue = 0.0;
  SearchDataList sdl = SearchDataList();
  SavedPref svp = SavedPref();
  var endValue = 0.0;

  @override
  void initState() {
    super.initState();
    setsvp();
    borderColor = false;
    borderColor2 = false;
  }

  bool borderColor = false;
  bool borderColor2 = false;
  setsvp() async {
    var json = await sharedPref.read("savedPref");
    if (json != null) {
      setState(() {
        svp = SavedPref.fromJson(json);
      });
    }
  }

  nameContainer(icon, String head, List<dynamic> val, List<String> options) {
    //val for return value list and options for showing options in dialog
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side with icon and heading
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 20,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Right side with values and arrow
        GestureDetector(
          onTap: () async {
            var ds = await Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => DynamicPage(
                    icon: icon,
                    head: head,
                    options: options,
                    selectedopt: val)));
            if (ds != "cancel") {
              if (!mounted) return;
              setState(() {
                val.clear();
              });
              for (var i = 0; i < ds.length; i++) {
                if (!mounted) return;
                setState(() {
                  val.add(ds[i]);
                });
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Value display container
              Container(
                width: 100,
                child: (val.isEmpty)
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.black38,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    )
                    : val.contains("Any")
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Any",
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black38,
                                fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                val.join(
                                    ', '), // Better formatting than toString()
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.black38,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                             ),
                          )),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  nameContainer5(icon, String head, Function tap, String val) {
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
                size: 20,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
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
          },
          child: Row(
            children: [
              (val == "")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : SizedBox(
                      width: Get.width * 0.3,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                val,
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

  nameContainer2(icon, String head, Function tap, List<dynamic> val) {
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
                size: 20,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
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
                  ? Text(
                      "Add",
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
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

  final PageController _pageController = PageController(initialPage: 0);
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
                size: 20,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
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
                          fontSize: 20,
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
                                        fontSize: 20,
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
                                        fontSize: 20,
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
                size: 20,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  head,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
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
                          fontSize: 20,
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
                                fontSize: 20,
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: CustomAppBar(
              title: "Saved Preference", iconImage: "images/icons/filter.png"),
          body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    selectedCity!.clear();
                    selectedCounty!.clear();
                    selectedState!.clear();
                    if (widget.history_save_pref[index].ageList.contains(1)) {
                      for (var i = 0; i < svp.LocatioList[1].length; i++) {
                        selectedCity!.add({"name": svp.LocatioList[1][i]});
                      }
                      for (var i = 0; i < svp.LocatioList[0].length; i++) {
                        selectedCounty!.add({"name": svp.LocatioList[0][i]});
                      }
                      for (var i = 0; i < svp.LocatioList[2].length; i++) {
                        selectedState!.add({"name": svp.LocatioList[2][i]});
                      }
                    } else {
                      for (var i = 0;
                          i <
                              widget
                                  .history_save_pref[index].citylocation.length;
                          i++) {
                        selectedCity!.add({
                          "name":
                              widget.history_save_pref[index].citylocation[i]
                        });
                      }
                      for (var i = 0;
                          i < widget.history_save_pref[index].location.length;
                          i++) {
                        selectedCounty!.add({
                          "name": widget.history_save_pref[index].location[i]
                        });
                      }
                      for (var i = 0;
                          i <
                              widget.history_save_pref[index].statelocation
                                  .length;
                          i++) {
                        selectedState!.add({
                          "name":
                              widget.history_save_pref[index].statelocation[i]
                        });
                      }
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.history_save_pref[index].ageList.contains(1)) {
                      selectedCity!.clear();
                      selectedCounty!.clear();
                      selectedState!.clear();
                      for (var i = 0; i < svp.LocatioList[2].length; i++) {
                        selectedCity!.add({"name": svp.LocatioList[2][i]});
                      }
                      for (var i = 0; i < svp.LocatioList[0].length; i++) {
                        selectedCounty!.add({"name": svp.LocatioList[0][i]});
                      }
                      for (var i = 0; i < svp.LocatioList[1].length; i++) {
                        selectedState!.add({"name": svp.LocatioList[1][i]});
                      }
                    }
                    if (widget.history_save_pref[index].ageList.contains(1)) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (widget.newUserModel.gender == "male") ...[
                                  nameContainer2(
                                      'images/icons/calender.png',
                                      "Age",
                                      functions().AgeDialog,
                                      svp.AgeList),
                                ] else ...[
                                  nameContainer2(
                                      'images/icons/calender.png',
                                      "Age",
                                      functions().FemaleAgeDialog,
                                      svp.AgeList),
                                ],

                                nameContainer('images/icons/religion.png',
                                    "Religion", svp.ReligionList, sdl.Religion),
                                (widget.newUserModel.religion == "Hindu")
                                    ? nameContainer(
                                        'images/icons/kundli.png',
                                        "Kundli Dosh",
                                        svp.KundaliDoshList,
                                        sdl.KundaliDosh)
                                    : Container(),
                                nameContainer(
                                    'images/icons/marital_status.png',
                                    "Marital Status",
                                    svp.MaritalStatusList,
                                    sdl.MaritalStatus),
                                nameContainer('images/icons/food.png', "Diet",
                                    svp.dietList, sdl.Diet),
                                nameContainer('images/icons/smoke.png', "Smoke",
                                    svp.SmokeList, sdl.Smoke),
                                nameContainer('images/icons/drink.png', "Drink",
                                    svp.DrinkList, sdl.Drink),
                                nameContainer(
                                    'images/icons/disability.png',
                                    "Disability With Person",
                                    svp.DisabilityList,
                                    sdl.Disability),
                                nameContainerHeight(
                                    'images/icons/height.png',
                                    "Height",
                                    functions().HeightDialog,
                                    svp.HeightList,
                                    sdl.Height),

                                nameContainer(
                                    'images/icons/education.png',
                                    "Education",
                                    svp.EducationList,
                                    sdl.Education),
                                nameContainer(
                                    'images/icons/profession_suitcase.png',
                                    "Profession",
                                    svp.ProfessionList,
                                    sdl.Profession),
                                nameContainer(
                                    'images/icons/hand_rupee.png',
                                    "Annual Income",
                                    svp.IncomeList,
                                    sdl.Income),
                                nameContainer3(
                                    'images/icons/location.png',
                                    "Location",
                                    functions().LocationDialog,
                                    svp.LocatioList),
                                // SizedBox(
                                //   height: 100,
                                // ),
                                widget.history_save_pref.length > 1
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: SizedBox(
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.arrow_forward_ios),
                                                  onPressed: () => {
                                                        _pageController
                                                            .nextPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve:
                                                              Curves.easeInOut,
                                                        )
                                                      }),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Center(),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shadowColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.black),
                                    // padding:
                                    //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                    //         EdgeInsets.symmetric(vertical: 17)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            side: BorderSide(
                                              color: borderColor
                                                  ? main_color
                                                  : Colors.white,
                                            ))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
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
                                onPressed: () async {
                                  borderColor2 = true;
                                  print(svp.AgeList);
                                  if (svp.LocatioList[2]
                                      .contains("United States")) {
                                    svp.LocatioList[2].clear();
                                    svp.LocatioList[2].add("USA");
                                    setState(() {});
                                  }

                                  SearchProfile().addtoadminnotification(
                                      userid: widget.newUserModel!.id!,
                                      useremail: widget.newUserModel!.email!,
                                      userimage: widget
                                              .newUserModel!.imageurls!.isEmpty
                                          ? ""
                                          : widget.newUserModel!.imageurls![0],
                                      title:
                                          "${userSave.displayName} SAVE ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} PREFERENCE",
                                      email: userSave.email!,
                                      subtitle: "");
                                  HomeService().createsavepref(
                                      ageList: svp.AgeList,
                                      religionList: svp.ReligionList,
                                      citylocation: svp.LocatioList[2].isEmpty
                                          ? []
                                          : svp.LocatioList[2],
                                      statelocation: svp.LocatioList[1].isEmpty
                                          ? []
                                          : svp.LocatioList[1],
                                      kundaliDoshList: svp.KundaliDoshList,
                                      email: widget.newUserModel.email,
                                      maritalStatusList: svp.MaritalStatusList,
                                      heightList: svp.HeightList.isEmpty
                                          ? []
                                          : [
                                              "${sdl.Height[int.parse(svp.HeightList[0])].substring(0, 4)}Feet",
                                              "${sdl.Height[int.parse(svp.HeightList[1])]}"
                                            ],
                                      smokeList: svp.SmokeList,
                                      drinkList: svp.DrinkList,
                                      disabilityList: svp.DisabilityList,
                                      dietList: svp.dietList,
                                      educationList: svp.EducationList,
                                      professionList: svp.ProfessionList,
                                      incomeList: svp.IncomeList,
                                      location: svp.LocatioList[0].isEmpty
                                          ? []
                                          : svp.LocatioList[0]);
                                  HomeService().addtosavedprefprofile(
                                      ageList: svp.AgeList,
                                      religionList: svp.ReligionList,
                                      email: widget.newUserModel.email,
                                      uid: widget.newUserModel.id,
                                      name: "${userSave.name}",
                                      citylocation: svp.LocatioList[2].isEmpty
                                          ? []
                                          : svp.LocatioList[2],
                                      statelocation: svp.LocatioList[1].isEmpty
                                          ? []
                                          : svp.LocatioList[1],
                                      kundaliDoshList: svp.KundaliDoshList,
                                      maritalStatusList: svp.MaritalStatusList,
                                      heightList: svp.HeightList.isEmpty
                                          ? []
                                          : [
                                              "${sdl.Height[int.parse(svp.HeightList[0])].substring(0, 4)}Feet",
                                              "${sdl.Height[int.parse(svp.HeightList[1])]}"
                                            ],
                                      smokeList: svp.SmokeList,
                                      drinkList: svp.DrinkList,
                                      disabilityList: svp.DisabilityList,
                                      dietList: svp.dietList,
                                      educationList: svp.EducationList,
                                      professionList: svp.ProfessionList,
                                      incomeList: svp.IncomeList,
                                      location: svp.LocatioList[0].isEmpty
                                          ? []
                                          : svp.LocatioList[0]);
                                  await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SnackBarContent(
                                            error_text:
                                                "Preference Save Successfully",
                                            appreciation: "",
                                            icon: Icons.check_circle,
                                            sec: 3,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        );
                                      });
                                  // // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainAppContainer(notiPage: false,)));

                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shadowColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.black),
                                    // padding:
                                    //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                    //         EdgeInsets.symmetric(vertical: 17)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            side: BorderSide(
                                              color: borderColor
                                                  ? main_color
                                                  : Colors.white,
                                            ))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
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
                                onPressed: () async {
                                  SearchProfile().addtoadminnotification(
                                      userid: widget.newUserModel!.id!,
                                      useremail: widget.newUserModel!.email!,
                                      userimage: widget
                                              .newUserModel!.imageurls!.isEmpty
                                          ? ""
                                          : widget.newUserModel!.imageurls![0],
                                      title:
                                          "${userSave.displayName} RESET ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} PREFERENCE",
                                      email: userSave.email!,
                                      subtitle: "");
                                  HomeService().createsavepref(
                                      ageList: [],
                                      religionList: [],
                                      citylocation: [],
                                      statelocation: [],
                                      kundaliDoshList: [],
                                      disabilityList: [],
                                      educationList: [],
                                      email: widget.newUserModel.email,
                                      maritalStatusList: [],
                                      heightList: [],
                                      smokeList: [],
                                      drinkList: [],
                                      dietList: [],
                                      professionList: [],
                                      incomeList: [],
                                      location: []);
                                  HomeService().addtosavedprefprofile(
                                      ageList: [],
                                      religionList: [],
                                      email: widget.newUserModel.email,
                                      uid: widget.newUserModel.id,
                                      citylocation: [],
                                      statelocation: [],
                                      name: "${userSave.name} reset",
                                      kundaliDoshList: [],
                                      maritalStatusList: [],
                                      heightList: [],
                                      smokeList: [],
                                      drinkList: [],
                                      disabilityList: [],
                                      dietList: [],
                                      educationList: [],
                                      professionList: [],
                                      incomeList: [],
                                      location: []);
                                  // saveData();
                                  // print(svp.ReligionList);
                                  //  homeservice.createsavepref(ageList:[],
                                  //   religionList: [], kundaliDoshList:[],
                                  //    maritalStatusList:[],
                                  //    citylocation: [],
                                  //    statelocation: [],
                                  //     heightList:[], smokeList:[],
                                  //      drinkList:[], disabilityList:[],
                                  //       dietList:[], educationList:[],
                                  //       professionList:[], incomeList:[],
                                  //        location:[]);
                                  await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SnackBarContent(
                                            error_text:
                                                "Preference Reset Successfully",
                                            appreciation: "",
                                            icon: Icons.check,
                                            sec: 3,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        );
                                      });
                                  Navigator.pop(context);
                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => MainAppContainer(
                                  //               notiPage: false,
                                  //             )),
                                  //     (route) => false);

                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SlideProfile(
                                  //               notiPage: false,
                                  //             )),
                                  //     (route) => false);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: main_color,
                                  )),
                              SizedBox(
                                width: Get.width * 0.82,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    nameContainer2(
                                        'images/icons/calender.png',
                                        "Age",
                                        functions().AgeDialog,
                                        widget
                                            .history_save_pref[index].ageList),
                                    nameContainer(
                                        'images/icons/religion.png',
                                        "Religion",
                                        widget.history_save_pref[index]
                                            .religionList,
                                        sdl.Religion),
                                    nameContainer(
                                        'images/icons/kundli.png',
                                        "Kundli Dosh",
                                        widget.history_save_pref[index]
                                            .kundaliDoshList,
                                        sdl.KundaliDosh),
                                    nameContainer(
                                        'images/icons/marital_status.png',
                                        "Marital Status",
                                        widget.history_save_pref[index]
                                            .maritalStatusList,
                                        sdl.MaritalStatus),
                                    nameContainer(
                                        'images/icons/food.png',
                                        "Diet",
                                        widget
                                            .history_save_pref[index].dietList,
                                        sdl.Diet),
                                    nameContainer(
                                        'images/icons/smoke.png',
                                        "Smoke",
                                        widget
                                            .history_save_pref[index].smokeList,
                                        sdl.Smoke),
                                    nameContainer(
                                        'images/icons/drink.png',
                                        "Drink",
                                        widget
                                            .history_save_pref[index].drinkList,
                                        sdl.Drink),
                                    nameContainer(
                                        'images/icons/disability.png',
                                        "Disability With Person",
                                        widget.history_save_pref[index]
                                            .disabilityList,
                                        sdl.Disability),
                                    nameContainer2(
                                        'images/icons/height.png',
                                        "Height",
                                        functions().HeightDialog,
                                        widget.history_save_pref[index]
                                            .heightList),
                                    nameContainer(
                                        'images/icons/education.png',
                                        "Education",
                                        widget.history_save_pref[index]
                                            .educationList,
                                        sdl.Education),
                                    nameContainer(
                                        'images/icons/profession_suitcase.png',
                                        "Profession",
                                        widget.history_save_pref[index]
                                            .professionList,
                                        sdl.Profession),
                                    nameContainer(
                                        'images/icons/hand_rupee.png',
                                        "Income",
                                        widget.history_save_pref[index]
                                            .incomeList,
                                        sdl.Income),
                                    nameContainer5(
                                        'images/icons/location.png',
                                        "Location",
                                        functions().LocationDialog,
                                        "${widget.history_save_pref[index].citylocation.isEmpty ? "" : "${widget.history_save_pref[index].citylocation[0]} ${widget.history_save_pref[index].citylocation.length > 1 ? "+${widget.history_save_pref[index].citylocation.length - 1}" : ""}"}${widget.history_save_pref[index].statelocation.isEmpty ? "" : ",${widget.history_save_pref[index].statelocation[0]} ${widget.history_save_pref[index].statelocation.length > 1 ? "+${widget.history_save_pref[index].statelocation.length - 1}" : ""}"}${widget.history_save_pref[index].location.isEmpty ? "" : ",${widget.history_save_pref[index].location[0]}${widget.history_save_pref[index].location.length > 1 ? "+${widget.history_save_pref[index].location.length - 1}" : ""} "}"),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: main_color)),
                            ],
                          ),
                        ),
                        
                      
                        Text(
                          widget.history_save_pref[index].name
                                  .contains("reset")
                              ? "Reset by ${widget.history_save_pref[index].name.split(' ')[0]} ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(widget.history_save_pref[index].createdAt!).toLocal())}"
                              : "Saved by ${widget.history_save_pref[index].name} ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(widget.history_save_pref[index].createdAt!).toLocal())}",
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Sans-serif'),
                        ),
                       SizedBox(height: 10,),
                      ],
                    );
                  },
                  itemCount: widget.history_save_pref.length,
                )),
          )),
    );
  }

  saveData() async {
    sharedPref.save("savedPref", svp);
    var json = svp.toJson();
    try {
      final docUser = await FirebaseFirestore.instance
          .collection('block_list')
          .doc(uid)
          .get();

      if (docUser.exists) {
        FirebaseFirestore.instance
            .collection("saved_pref")
            .doc(uid)
            .update(json)
            .then((value) async {});

        Navigator.of(context).pop();
        setState(() {
          borderColor = false;
          borderColor2 = false;
        });
      } else {
        FirebaseFirestore.instance
            .collection("saved_pref")
            .doc(uid)
            .set(json)
            .then((value) async {});
        // await showDialog(
        //     context: context,
        //     builder: (context) {
        //       return const AlertDialog(
        //         content: SnackBarContent(
        //             error_text: "Preference Saved Successfully",
        //             appreciation: "",
        //             icon: Icons.check),
        //         backgroundColor: Colors.transparent,
        //         elevation: 0,
        //       );
        //     });

        Navigator.of(context).pop();
        setState(() {
          borderColor = false;
          borderColor2 = false;
        });
      }

      FirebaseFirestore.instance.collection("saved_pref").doc(uid).update(json);
      NotificationFunction.setNotification(
        "admin",
        "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} SAVED PREFERENCE",
        'savepreference',
      );
      NotificationFunction.setNotification(
        "user1",
        "PREFERENCE SAVED SUCCESSFULLY ",
        'savepreference',
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
