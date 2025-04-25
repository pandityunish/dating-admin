import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/admin_search_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';

import 'package:matrimony_admin/models/user_model.dart';
import 'package:matrimony_admin/screens/Search_profile/search_profiles.dart';
import 'package:matrimony_admin/screens/data_collection/smoke.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/search_service.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/user_search/circle_bar.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matrimony_admin/screens/profile/location_searching.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import '../Assets/Error.dart';
import '../Assets/ayushWidget/big_text.dart';
import '../globalVars.dart';
import '../models/searchFunctions.dart';
import 'ERRORs/search_profile_error.dart';
import 'Search_profile/functionSearch.dart';
import 'Search_profile/search_dynamic_pages.dart';
import 'profile/profileScroll.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'service/search_profile.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // ignore: prefer_final_fields
  TextEditingController _searchIDController = TextEditingController();
  TextEditingController _searchEmailController = TextEditingController();
  TextEditingController _searchNameController = TextEditingController();
  TextEditingController _searchSurnameController = TextEditingController();
  TextEditingController _searchphoneController = TextEditingController();

  // ignore: prefer_final_fields, unused_field
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentSliderValue = 0;
  // ignore: unused_field, prefer_final_fields
  double _startValue = 20.0;
  // ignore: unused_field, prefer_final_fields
  double _endValue = 90.0;
  var startValue = 0.0;
  var endValue = 0.0;
  bool searchingbool = false;
  bool ison = true;
  late String profileSearch = "";
  late String EmailSearch = "";
  late String NameSearch = "";
  late String SurnameSearch = "";
  late String phoneSearch = "";
  int currentPage = 1;
  int totalPages = 1; // Initialize totalPages
  bool isLoading = false;
  SearchDataList sdl = SearchDataList();
  List<AdminSearchModel> allsearches = [];
  void getallsearches() async {
    if (isLoading) return; // Prevent multiple calls while loading

    setState(() {
      isLoading = true;
    });
    log("current page $currentPage");
    final response = await SearchProfile().getAdminSearch(currentPage, 10);
    totalPages = response['totalPages'];
    List<AdminSearchModel> searches = (response['data'] as List)
        .map((item) => AdminSearchModel.fromJson(jsonEncode(item)))
        .toList();
    AdminSearchModel newsearch = AdminSearchModel(
      adminname: "hero324",
      searchemailprofile: "",
      searchnameprofile: "",
      searchphoneprofile: "",
      searchsurprofile: "",
      age: "[]",
      createdAt: DateTime.now().toString(),
      diet: "[]",
      disability: "[]",
      drink: "[]",
      education: "[]",
      height: "[]",
      income: "[]",
      kundlidosh: "[]",
      location: "[]",
      marital_status: "[]",
      profession: "[]",
      religion: "[]",
      searchDistance: "",
      searchidprofile: "",
      smoke: "[]",
    );
    setState(() {
      searches.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      allsearches = [newsearch, ...searches];
      isLoading = false;
    });
  }

  void _loadMoreData() async {
    // if ( !isLoading) {
    log("isloading ${isLoading}");
    currentPage++;
    //  getallsearches();
    final response = await SearchProfile().getAdminSearch(currentPage, 10);
    totalPages = response['totalPages'];
    List<AdminSearchModel> searches = (response['data'] as List)
        .map((item) => AdminSearchModel.fromJson(jsonEncode(item)))
        .toList();
    allsearches.addAll(searches);
    setState(() {});
    // }
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
                          fontSize: 14,
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
                                        fontSize: 14,
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
                                        fontSize: 14,
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
                          fontSize: 14,
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
                                fontSize: 14,
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
                                    fontSize: 14,
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
                                        fontSize: 14,
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
                                        fontSize: 14,
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : Text(
                                          (val[2].length > 1)
                                              ? "${val[2][0].toString()} +${val[2].length - 1}"
                                              : val[2][0].toString(),
                                          style: GoogleFonts.poppins(
                                              decoration: TextDecoration.none,
                                              color: Colors.black38,
                                              fontSize: 14,
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
                          fontSize: 14,
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
                                        fontSize: 14,
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
                                        fontSize: 14,
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

  bool forIos = false;
  bool forIos2 = false;
  SavedPref svp = SavedPref();
// List<String> heading = [
  List<String> AgeList = [];
  List<String> ReligionList = [];
  List<String> KundaliDoshList = [];
  List<String> MaritalStatusList = [];
  List<String> dietList = [];
  List<String> DrinkList = [];
  List<String> SmokeList = [];
  List<String> DisabilityList = [];
  List<String> HeightList = [];
  List<String> EducationList = [];
  List<String> ProfessionList = [];
  List<String> IncomeList = [];
  List<String> LocatioList = [];
  // ];
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
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: Row(
            children: [
              (val == "  ")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : SizedBox(
                      width: 65,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                val,
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.black38,
                                    fontSize: 14,
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

  nameContainerHeight1(icon, String head, Function tap, List<dynamic> val,
      List<dynamic> options) {
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
                          fontSize: 14,
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
                                        fontSize: 14,
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
                                        fontSize: 14,
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

  nameContainer4(icon, String head, Function tap, String val) {
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
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: Row(
            children: [
              (val == "[]")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : SizedBox(
                      width: 65,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                val.replaceAll(RegExp(r'[\[\]]'), ''),
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.black38,
                                    fontSize: 14,
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

  nameContainer6(icon, String head, Function tap, String val) {
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
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif'),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: Row(
            children: [
              (val == "[]")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : SizedBox(
                      width: 65,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                val
                                    .replaceAll(RegExp(r'[\[\]]'), '')
                                    .replaceAll(',', '-'),
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.black38,
                                    fontSize: 14,
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
                        fontSize: 18,
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
                          fontSize: 14,
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
                                    fontSize: 14,
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
  @override
  void initState() {
    getallsearches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SlideProfile(),
                    ));
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: main_color,
                size: 25,
              ),
            ),
            title: Row(
              children: [
                BigText(
                  text: "Search Profile",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
          body:
              isLoading &&
                      allsearches
                          .isEmpty // Show loading indicator only initially
                  ? Center(child: CircularProgressIndicator())
                  : allsearches.isEmpty
                      ? Center(child: Text("No data available."))
                      : SafeArea(
                          child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                log("object ${index}");

                                if (index == allsearches.length - 3) {
                                  log("selec object ${index}");
                                  _loadMoreData(); // Load more when reaching the last item
                                }
                              },
                              itemCount: allsearches.length,
                              itemBuilder: (BuildContext context, int index) {
                                List<String> result = [];
                                print("*******");
                                print(allsearches[index].location == "  ");
                                if (allsearches[index].height == "[]") {
                                  print("object");
                                } else {
                                  List<String> elements = allsearches[index]
                                      .height!
                                      .substring(1,
                                          allsearches[index].height!.length - 1)
                                      .split(',');

                                  // Trim whitespace and convert elements to strings
                                  result = elements
                                      .map((element) => element.trim())
                                      .toList();
                                  print(result);
                                }

                                if (allsearches[index].adminname == "hero324") {
                                  return SingleChildScrollView(
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 15),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Profile",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _searchIDController,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Profile Id',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchIDController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        // if (_searchIDController
                                                                        //             .text ==
                                                                        //         null ||
                                                                        //     _searchIDController
                                                                        //             .text ==
                                                                        //         "") {
                                                                        //   showDialog(
                                                                        //       context:
                                                                        //           context,
                                                                        //       builder:
                                                                        //           (context) {
                                                                        //         // Future.delayed(
                                                                        //         //     const Duration(seconds: 1), () {
                                                                        //         //   Navigator.of(context).pop(true);
                                                                        //         // });
                                                                        //         return const AlertDialog(
                                                                        //           content:
                                                                        //               SnackBarContent(
                                                                        //             error_text:
                                                                        //                 "Please Enter Profile ID",
                                                                        //             appreciation:
                                                                        //                 "",
                                                                        //             icon:
                                                                        //                 Icons.error,
                                                                        //             sec:
                                                                        //                 2,
                                                                        //           ),
                                                                        //           backgroundColor:
                                                                        //               Colors.transparent,
                                                                        //           elevation:
                                                                        //               0,
                                                                        //         );
                                                                        //       });
                                                                        // } else {
                                                                        // final data= await SearchProfile().addtosearchprofile(
                                                                        //       searchprofile:
                                                                        //           _searchIDController
                                                                        //               .text,
                                                                        //       email: userSave
                                                                        //           .email!,
                                                                        //       name: userSave
                                                                        //           .name!,
                                                                        //       searchemailprofile:
                                                                        //           _searchEmailController
                                                                        //               .text,
                                                                        //       searchnameprofile:
                                                                        //           _searchNameController
                                                                        //               .text,
                                                                        //       searchphoneprofile:
                                                                        //           _searchphoneController
                                                                        //               .text,
                                                                        //       searchsurprofile:
                                                                        //           _searchSurnameController
                                                                        //               .text,
                                                                        //       searchDistance:
                                                                        //           _currentSliderValue
                                                                        //               .toString(),
                                                                        //       age: svp.AgeList
                                                                        //           .toString(),
                                                                        //       religion: svp.ReligionList
                                                                        //           .toString(),
                                                                        //       kundalidosh:
                                                                        //           svp.KundaliDoshList
                                                                        //               .toString(),
                                                                        //       marital_status:
                                                                        //           svp.MaritalStatusList
                                                                        //               .toString(),
                                                                        //       diet: svp
                                                                        //           .dietList
                                                                        //           .toString(),
                                                                        //       smoke: svp.SmokeList
                                                                        //           .toString(),
                                                                        //       drink: svp.DrinkList.toString(),
                                                                        //       disability: svp.DisabilityList.toString(),
                                                                        //       height: svp.HeightList.toString(),
                                                                        //       education: svp.EducationList.toString(),
                                                                        //       profession: svp.ProfessionList.toString(),
                                                                        //       income: svp.IncomeList.toString(),
                                                                        //       location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                        //   getProfileSearchByProfile(data);
                                                                        // }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Email",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _searchEmailController,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Email Id',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchEmailController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (_searchEmailController.text ==
                                                                                null ||
                                                                            _searchEmailController.text ==
                                                                                "") {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                // Future.delayed(
                                                                                //     const Duration(seconds: 1), () {
                                                                                //   Navigator.of(context).pop(true);
                                                                                // });
                                                                                return const AlertDialog(
                                                                                  content: SnackBarContent(
                                                                                    error_text: "Please Enter Email ID",
                                                                                    appreciation: "",
                                                                                    icon: Icons.error,
                                                                                    sec: 2,
                                                                                  ),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  elevation: 0,
                                                                                );
                                                                              });
                                                                        } else {
                                                                          final data = await SearchProfile().addtosearchprofile(
                                                                              searchprofile: _searchIDController.text,
                                                                              email: userSave.email!,
                                                                              name: userSave.name!,
                                                                              searchemailprofile: _searchEmailController.text,
                                                                              searchnameprofile: _searchNameController.text,
                                                                              searchphoneprofile: _searchphoneController.text,
                                                                              searchsurprofile: _searchSurnameController.text,
                                                                              searchDistance: _currentSliderValue.toString(),
                                                                              age: svp.AgeList.toString(),
                                                                              religion: svp.ReligionList.toString(),
                                                                              kundalidosh: svp.KundaliDoshList.toString(),
                                                                              marital_status: svp.MaritalStatusList.toString(),
                                                                              diet: svp.dietList.toString(),
                                                                              smoke: svp.SmokeList.toString(),
                                                                              drink: svp.DrinkList.toString(),
                                                                              disability: svp.DisabilityList.toString(),
                                                                              height: svp.HeightList.toString(),
                                                                              education: svp.EducationList.toString(),
                                                                              profession: svp.ProfessionList.toString(),
                                                                              income: svp.IncomeList.toString(),
                                                                              location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                          getProfileSearchByEmail(
                                                                              data);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              //+9155556580544
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Contact No",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _searchphoneController,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Contact Number',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchphoneController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (_searchphoneController.text ==
                                                                                null ||
                                                                            _searchphoneController.text ==
                                                                                "") {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                // Future.delayed(
                                                                                //     const Duration(seconds: 1), () {
                                                                                //   Navigator.of(context).pop(true);
                                                                                // });
                                                                                return const AlertDialog(
                                                                                  content: SnackBarContent(
                                                                                    error_text: "Please Enter Phone No.",
                                                                                    appreciation: "",
                                                                                    icon: Icons.error,
                                                                                    sec: 2,
                                                                                  ),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  elevation: 0,
                                                                                );
                                                                              });
                                                                        } else {
                                                                          final data = await SearchProfile().addtosearchprofile(
                                                                              searchprofile: _searchIDController.text,
                                                                              email: userSave.email!,
                                                                              name: userSave.name!,
                                                                              searchemailprofile: _searchEmailController.text,
                                                                              searchnameprofile: _searchNameController.text,
                                                                              searchphoneprofile: _searchphoneController.text,
                                                                              searchsurprofile: _searchSurnameController.text,
                                                                              searchDistance: _currentSliderValue.toString(),
                                                                              age: svp.AgeList.toString(),
                                                                              religion: svp.ReligionList.toString(),
                                                                              kundalidosh: svp.KundaliDoshList.toString(),
                                                                              marital_status: svp.MaritalStatusList.toString(),
                                                                              diet: svp.dietList.toString(),
                                                                              smoke: svp.SmokeList.toString(),
                                                                              drink: svp.DrinkList.toString(),
                                                                              disability: svp.DisabilityList.toString(),
                                                                              height: svp.HeightList.toString(),
                                                                              education: svp.EducationList.toString(),
                                                                              profession: svp.ProfessionList.toString(),
                                                                              income: svp.IncomeList.toString(),
                                                                              location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                          getProfileSearchByPhone(
                                                                              data);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Name",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _searchNameController,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Name',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchNameController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (_searchNameController.text ==
                                                                                null ||
                                                                            _searchNameController.text ==
                                                                                "") {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return const AlertDialog(
                                                                                  content: SnackBarContent(
                                                                                    error_text: "Please Enter Name",
                                                                                    appreciation: "",
                                                                                    icon: Icons.error,
                                                                                    sec: 2,
                                                                                  ),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  elevation: 0,
                                                                                );
                                                                              });
                                                                        } else {
                                                                          final data = await SearchProfile().addtosearchprofile(
                                                                              searchprofile: _searchIDController.text,
                                                                              email: userSave.email!,
                                                                              name: userSave.name!,
                                                                              searchemailprofile: _searchEmailController.text,
                                                                              searchnameprofile: _searchNameController.text,
                                                                              searchphoneprofile: _searchphoneController.text,
                                                                              searchsurprofile: _searchSurnameController.text,
                                                                              searchDistance: _currentSliderValue.toString(),
                                                                              age: svp.AgeList.toString(),
                                                                              religion: svp.ReligionList.toString(),
                                                                              kundalidosh: svp.KundaliDoshList.toString(),
                                                                              marital_status: svp.MaritalStatusList.toString(),
                                                                              diet: svp.dietList.toString(),
                                                                              smoke: svp.SmokeList.toString(),
                                                                              drink: svp.DrinkList.toString(),
                                                                              disability: svp.DisabilityList.toString(),
                                                                              height: svp.HeightList.toString(),
                                                                              education: svp.EducationList.toString(),
                                                                              profession: svp.ProfessionList.toString(),
                                                                              income: svp.IncomeList.toString(),
                                                                              location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                          getProfileSearchByName(
                                                                              data);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Surname",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _searchSurnameController,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Suname',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchSurnameController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        print(userSave
                                                                            .name);
                                                                        if (_searchSurnameController.text ==
                                                                                null ||
                                                                            _searchSurnameController.text ==
                                                                                "") {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return const AlertDialog(
                                                                                  content: SnackBarContent(
                                                                                    error_text: "Please Enter Surname",
                                                                                    appreciation: "",
                                                                                    icon: Icons.error,
                                                                                    sec: 2,
                                                                                  ),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  elevation: 0,
                                                                                );
                                                                              });
                                                                        } else {
                                                                          final data = await SearchProfile().addtosearchprofile(
                                                                              // 9801564490 susan manandar new baneshor ktm
                                                                              searchprofile: _searchIDController.text,
                                                                              email: userSave.email!,
                                                                              name: userSave.name!,
                                                                              searchemailprofile: _searchEmailController.text,
                                                                              searchnameprofile: _searchNameController.text,
                                                                              searchphoneprofile: _searchphoneController.text,
                                                                              searchsurprofile: _searchSurnameController.text,
                                                                              searchDistance: _currentSliderValue.toString(),
                                                                              age: svp.AgeList.toString(),
                                                                              religion: svp.ReligionList.toString(),
                                                                              kundalidosh: svp.KundaliDoshList.toString(),
                                                                              marital_status: svp.MaritalStatusList.toString(),
                                                                              diet: svp.dietList.toString(),
                                                                              smoke: svp.SmokeList.toString(),
                                                                              drink: svp.DrinkList.toString(),
                                                                              disability: svp.DisabilityList.toString(),
                                                                              height: svp.HeightList.toString(),
                                                                              education: svp.EducationList.toString(),
                                                                              profession: svp.ProfessionList.toString(),
                                                                              income: svp.IncomeList.toString(),
                                                                              location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                          getProfileSearchBySurname(
                                                                              data);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),

                                                      const SizedBox(
                                                        height: 20,
                                                      ),

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                                "Search By Distance",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color:
                                                                        main_color,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'Sans-serif')),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Text(
                                                              "${_currentSliderValue} Km",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color:
                                                                      main_color,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _pageController
                                                                .nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .easeInOut,
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: main_color,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "0 km",
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            Text(
                                                              "200 km",
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "Within",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color:
                                                                      main_color,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Material(
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  SliderTheme(
                                                                data: SliderTheme.of(
                                                                        context)
                                                                    .copyWith(
                                                                  rangeThumbShape:
                                                                       CircleThumbShape(
                                                                        thumbColor:forIos? main_color:Colors.black12 ,
                                                                    thumbRadius:
                                                                        8.0, // Size of the thumb
                                                                  ),
                                                                  thumbColor: Colors
                                                                      .transparent, // Transparent fill for hollow center
                                                                  overlayColor:
                                                                      Colors
                                                                          .transparent, // No overlay when thumb is pressed
                                                                  activeTrackColor:
                                                                      main_color, // Track color for selected range
                                                                  inactiveTrackColor:
                                                                      main_color
                                                                          .withOpacity(
                                                                              0.3), // Track color for unselected range
                                                                  trackHeight:
                                                                      4.0, // Thickness of the track
                                                                ),
                                                                child:
                                                                    RangeSlider(
                                                                  activeColor:
                                                                      main_color,
                                                                  values:
                                                                      _currentRangeValues,
                                                                  max: 200,
                                                                  divisions: 10,
                                                                  onChanged:
                                                                      (forIos)
                                                                          ? (RangeValues
                                                                              values) {
                                                                              if (!mounted)
                                                                                return;

                                                                              // Enforce a minimum range of 20
                                                                              if ((values.end - values.start) >= 20) {
                                                                                setState(() {
                                                                                  _currentRangeValues = values;
                                                                                });
                                                                              } else {
                                                                                setState(() {
                                                                                  _currentRangeValues = RangeValues(
                                                                                    values.start,
                                                                                    values.start + 20 > 200 ? 200 : values.start + 20,
                                                                                  );
                                                                                });
                                                                              }
                                                                            }
                                                                          : null,
                                                                  labels:
                                                                      RangeLabels(
                                                                    _currentRangeValues
                                                                        .start
                                                                        .round()
                                                                        .toString(),
                                                                    _currentRangeValues
                                                                        .end
                                                                        .round()
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  height: 35,
                                                                  width: 55,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                  ),
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      // Track
                                                                      AnimatedContainer(
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: ison
                                                                              ? Colors.black12
                                                                              : main_color,
                                                                          borderRadius:
                                                                              BorderRadius.circular(30.0),
                                                                        ),
                                                                        width:
                                                                            55,
                                                                        height:
                                                                            28,
                                                                      ),
                                                                      // Thumb with text
                                                                      Align(
                                                                        alignment: ison
                                                                            ? Alignment.centerLeft
                                                                            : Alignment.centerRight,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            ison =
                                                                                !ison;
                                                                            setState(() =>
                                                                                forIos = !forIos);
                                                                          },
                                                                          child:
                                                                              AnimatedContainer(
                                                                            duration:
                                                                                const Duration(milliseconds: 200),
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              ison ? "Off" : "On",
                                                                              style: TextStyle(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   height: 30,
                                                                //   width: 55,
                                                                //   decoration:
                                                                //       BoxDecoration(
                                                                //     border: Border.all(
                                                                //         color: Colors
                                                                //             .black12),
                                                                //     borderRadius:
                                                                //         BorderRadius
                                                                //             .circular(
                                                                //                 30.0),
                                                                //   ),
                                                                //   child:
                                                                //       CupertinoSwitch(
                                                                //     // overrides the default green color of the track
                                                                //     activeColor:
                                                                //         Colors.white,
                                                                //     // color of the round icon, which moves from right to left
                                                                //     thumbColor: forIos
                                                                //         ? main_color
                                                                //         : Colors
                                                                //             .black12,
                                                                //     // when the switch is off
                                                                //     trackColor: forIos
                                                                //         ? Colors.white
                                                                //         : Colors
                                                                //             .black12,
                                                                //     // boolean variable value
                                                                //     value: forIos,
                                                                //     // changes the state of the switch
                                                                //     onChanged: (value) =>
                                                                //         setState(() =>
                                                                //             forIos =
                                                                //                 value),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets
                                                      //           .symmetric(
                                                      //           horizontal: 10,
                                                      //           vertical: 10),
                                                      //   child: SizedBox(
                                                      //     width: Get.width,
                                                      //     child: Row(
                                                      //       mainAxisAlignment:
                                                      //           MainAxisAlignment
                                                      //               .end,
                                                      //       children: [
                                                      //         IconButton(
                                                      //             icon: Icon(Icons
                                                      //                 .arrow_forward_ios),
                                                      //             onPressed:
                                                      //                 () => {
                                                      //                       _pageController.nextPage(
                                                      //                         duration: Duration(milliseconds: 500),
                                                      //                         curve: Curves.easeInOut,
                                                      //                       )
                                                      //                     }),
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Search By Category",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color:
                                                                      main_color,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Male",
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                              ),
                                                              child:
                                                                  CupertinoSwitch(
                                                                // overrides the default green color of the track
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                // color of the round icon, which moves from right to left
                                                                thumbColor: forIos2
                                                                    ? main_color
                                                                    : Colors
                                                                        .black12,
                                                                // when the switch is off
                                                                trackColor: forIos2
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black12,
                                                                // boolean variable value
                                                                value: forIos2,
                                                                // changes the state of the switch
                                                                onChanged: (value) =>
                                                                    setState(() =>
                                                                        forIos2 =
                                                                            value),
                                                              ),
                                                            ),
                                                            Text(
                                                              "Female",
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      nameContainer2(
                                                          'images/icons/calender.png',
                                                          "Age",
                                                          functions().AgeDialog,
                                                          svp.AgeList),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/religion.png',
                                                          "Religion",
                                                          svp.ReligionList,
                                                          sdl.Religion),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      (userSave.religion ==
                                                              "Hindu")
                                                          ? nameContainer(
                                                              'images/icons/kundli.png',
                                                              "Kundli Dosh",
                                                              svp.KundaliDoshList,
                                                              sdl.KundaliDosh)
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
                                                          'images/icons/food.png',
                                                          "Diet",
                                                          svp.dietList,
                                                          sdl.Diet),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/smoke.png',
                                                          "Smoke",
                                                          svp.SmokeList,
                                                          sdl.Smoke),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/drink.png',
                                                          "Drink",
                                                          svp.DrinkList,
                                                          sdl.Drink),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/disability.png',
                                                          "Disability With Person",
                                                          svp.DisabilityList,
                                                          sdl.Disability),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainerHeight(
                                                          'images/icons/height.png',
                                                          "Height",
                                                          functions()
                                                              .HeightDialog,
                                                          svp.HeightList,
                                                          sdl.Height),
                                                      // HeightList, sdl.Height),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/education.png',
                                                          "Education",
                                                          svp.EducationList,
                                                          sdl.Education),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/profession_suitcase.png',
                                                          "Profession",
                                                          svp.ProfessionList,
                                                          sdl.Profession),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer(
                                                          'images/icons/hand_rupee.png',
                                                          "Income",
                                                          svp.IncomeList,
                                                          sdl.Income),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer3(
                                                          'images/icons/location.png',
                                                          "Location",
                                                          functions()
                                                              .LocationDialog,
                                                          svp.LocatioList),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (searchingbool)
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child: CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      main_color))),
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 300,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shadowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    //side: BorderSide(color: Colors.black)
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              child: const Text(
                                                "Search Profile",
                                                style: TextStyle(
                                                  fontFamily: 'Serif',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final data = await SearchProfile().addtosearchprofile(
                                                    isSearch: forIos,
                                                    maxDistance: forIos == true
                                                        ? _currentRangeValues
                                                            .end
                                                            .toInt()
                                                        : 0,
                                                    minDistance: forIos == true
                                                        ? _currentRangeValues
                                                            .start
                                                            .toInt()
                                                        : 0,
                                                    searchprofile:
                                                        _searchIDController
                                                            .text,
                                                    email: userSave.email!,
                                                    name: userSave.name!,
                                                    searchemailprofile:
                                                        _searchEmailController
                                                            .text,
                                                    searchnameprofile:
                                                        _searchNameController
                                                            .text,
                                                    searchphoneprofile:
                                                        _searchphoneController
                                                            .text,
                                                    searchsurprofile:
                                                        _searchSurnameController
                                                            .text,
                                                    searchDistance:
                                                        _currentSliderValue
                                                            .toString(),
                                                    age: svp.AgeList.toString(),
                                                    religion:
                                                        svp.ReligionList.toString(),
                                                    kundalidosh: svp.KundaliDoshList.toString(),
                                                    marital_status: svp.MaritalStatusList.toString(),
                                                    diet: svp.dietList.toString(),
                                                    smoke: svp.SmokeList.toString(),
                                                    drink: svp.DrinkList.toString(),
                                                    disability: svp.DisabilityList.toString(),
                                                    height: svp.HeightList.toString(),
                                                    education: svp.EducationList.toString(),
                                                    profession: svp.ProfessionList.toString(),
                                                    income: svp.IncomeList.toString(),
                                                    location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                getProfileSearch(data);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 300,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shadowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    //side: BorderSide(color: Colors.black)
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              child: const Text(
                                                "Reset",
                                                style: TextStyle(
                                                  fontFamily: 'Serif',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                SearchProfile()
                                                    .addtoadminnotification(
                                                        userid: userSave.uid!,
                                                        useremail:
                                                            userSave.email!,
                                                        userimage: userSave
                                                                .imageUrls!
                                                                .isEmpty
                                                            ? ""
                                                            : userSave
                                                                .imageUrls![0]!,
                                                        title:
                                                            "${userSave.displayName} RESET ADMIN SEARCH PROFILE BAR ",
                                                        email: userSave.email!,
                                                        subtitle: "");
                                                _searchEmailController.clear();
                                                _searchIDController.clear();
                                                _searchEmailController.clear();
                                                _searchNameController.clear();
                                                _searchSurnameController
                                                    .clear();

                                                svp.AgeList.clear();
                                                svp.DisabilityList.clear();
                                                svp.DrinkList.clear();
                                                svp.EducationList.clear();
                                                svp.HeightList.clear();
                                                svp.IncomeList.clear();
                                                svp.KundaliDoshList.clear();
                                                svp.LocatioList[0].clear();
                                                svp.LocatioList[1].clear();
                                                svp.LocatioList[2].clear();
                                                svp.MaritalStatusList.clear();
                                                svp.ProfessionList.clear();
                                                svp.ReligionList.clear();
                                                svp.SmokeList.clear();
                                                svp.dietList.clear();
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SingleChildScrollView(
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 15),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Profile",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(text: allsearches[index].searchidprofile),
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Profile ID',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchIDController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Email",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(text: allsearches[index].searchemailprofile),
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Email Id',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchEmailController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Contact No",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(text: allsearches[index].searchphoneprofile),
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Phone',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchphoneController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              //+9155556580544
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Name",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(text: allsearches[index].searchnameprofile),
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Name',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchNameController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // if (_searchNameController
                                                                        //             .text ==
                                                                        //         null ||
                                                                        //     _searchNameController
                                                                        //             .text ==
                                                                        //         "") {
                                                                        //   showDialog(
                                                                        //       context:
                                                                        //           context,
                                                                        //       builder:
                                                                        //           (context) {
                                                                        //         return const AlertDialog(
                                                                        //           content:
                                                                        //               SnackBarContent(
                                                                        //             error_text:
                                                                        //                 "Please Enter Name",
                                                                        //             appreciation:
                                                                        //                 "",
                                                                        //             icon:
                                                                        //                 Icons.error,
                                                                        //             sec:
                                                                        //                 2,
                                                                        //           ),
                                                                        //           backgroundColor:
                                                                        //               Colors.transparent,
                                                                        //           elevation:
                                                                        //               0,
                                                                        //         );
                                                                        //       });
                                                                        // } else {
                                                                        //   SearchProfile().addtosearchprofile(
                                                                        //       searchprofile:
                                                                        //           _searchIDController
                                                                        //               .text,
                                                                        //       email: userSave
                                                                        //           .email!,
                                                                        //       name: userSave
                                                                        //           .name!,
                                                                        //       searchemailprofile:
                                                                        //           _searchEmailController
                                                                        //               .text,
                                                                        //       searchnameprofile:
                                                                        //           _searchNameController
                                                                        //               .text,
                                                                        //       searchphoneprofile:
                                                                        //           _searchphoneController
                                                                        //               .text,
                                                                        //       searchsurprofile:
                                                                        //           _searchSurnameController
                                                                        //               .text,
                                                                        //       searchDistance:
                                                                        //           _currentSliderValue
                                                                        //               .toString(),
                                                                        //       age: svp.AgeList
                                                                        //           .toString(),
                                                                        //       religion: svp.ReligionList
                                                                        //           .toString(),
                                                                        //       kundalidosh:
                                                                        //           svp.KundaliDoshList
                                                                        //               .toString(),
                                                                        //       marital_status:
                                                                        //           svp.MaritalStatusList
                                                                        //               .toString(),
                                                                        //       diet: svp
                                                                        //           .dietList
                                                                        //           .toString(),
                                                                        //       smoke: svp.SmokeList
                                                                        //           .toString(),
                                                                        //       drink: svp.DrinkList.toString(),
                                                                        //       disability: svp.DisabilityList.toString(),
                                                                        //       height: svp.HeightList.toString(),
                                                                        //       education: svp.EducationList.toString(),
                                                                        //       profession: svp.ProfessionList.toString(),
                                                                        //       income: svp.IncomeList.toString(),
                                                                        //       location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                        //   getProfileSearchByName();
                                                                        // }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.89,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "Search By Surname",
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            color:
                                                                                main_color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: 'Sans-serif'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(70)),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(text: allsearches[index].searchsurprofile),
                                                                          decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                                                                              hintText: 'Enter Suname',
                                                                              hintStyle: TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: main_color))),
                                                                          onChanged:
                                                                              (String) {
                                                                            profileSearch =
                                                                                _searchSurnameController.text;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(userSave
                                                                            .name);
                                                                        // if (_searchSurnameController
                                                                        //             .text ==
                                                                        //         null ||
                                                                        //     _searchSurnameController
                                                                        //             .text ==
                                                                        //         "") {
                                                                        //   showDialog(
                                                                        //       context:
                                                                        //           context,
                                                                        //       builder:
                                                                        //           (context) {
                                                                        //         return const AlertDialog(
                                                                        //           content:
                                                                        //               SnackBarContent(
                                                                        //             error_text:
                                                                        //                 "Please Enter Surname",
                                                                        //             appreciation:
                                                                        //                 "",
                                                                        //             icon:
                                                                        //                 Icons.error,
                                                                        //             sec:
                                                                        //                 2,
                                                                        //           ),
                                                                        //           backgroundColor:
                                                                        //               Colors.transparent,
                                                                        //           elevation:
                                                                        //               0,
                                                                        //         );
                                                                        //       });
                                                                        // } else {
                                                                        //   SearchProfile().addtosearchprofile(
                                                                        //       // 9801564490 susan manandar new baneshor ktm
                                                                        //       searchprofile: _searchIDController.text,
                                                                        //       email: userSave.email!,
                                                                        //       name: userSave.name!,
                                                                        //       searchemailprofile: _searchEmailController.text,
                                                                        //       searchnameprofile: _searchNameController.text,
                                                                        //       searchphoneprofile: _searchphoneController.text,
                                                                        //       searchsurprofile: _searchSurnameController.text,
                                                                        //       searchDistance: _currentSliderValue.toString(),
                                                                        //       age: svp.AgeList.toString(),
                                                                        //       religion: svp.ReligionList.toString(),
                                                                        //       kundalidosh: svp.KundaliDoshList.toString(),
                                                                        //       marital_status: svp.MaritalStatusList.toString(),
                                                                        //       diet: svp.dietList.toString(),
                                                                        //       smoke: svp.SmokeList.toString(),
                                                                        //       drink: svp.DrinkList.toString(),
                                                                        //       disability: svp.DisabilityList.toString(),
                                                                        //       height: svp.HeightList.toString(),
                                                                        //       education: svp.EducationList.toString(),
                                                                        //       profession: svp.ProfessionList.toString(),
                                                                        //       income: svp.IncomeList.toString(),
                                                                        //       location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                                        //   getProfileSearchBySurname();
                                                                        // }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: main_color),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .search,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),

                                                      const SizedBox(
                                                        height: 20,
                                                      ),

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                                "Search By Distance",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color:
                                                                        main_color,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'Sans-serif')),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10,
                                                        ),
                                                        child: SizedBox(
                                                          width: Get.width,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              index == 0
                                                                  ? Container()
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        _pageController
                                                                            .previousPage(
                                                                          duration:
                                                                              Duration(milliseconds: 500),
                                                                          curve:
                                                                              Curves.easeInOut,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_back_ios,
                                                                        color:
                                                                            main_color,
                                                                      ),
                                                                    ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  _pageController
                                                                      .nextPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .easeInOut,
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color:
                                                                      main_color,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                "0 Km",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'Sans-serif'),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                "200 Km",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'Sans-serif'),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "Within",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color:
                                                                      main_color,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          SliderTheme(
                                                              data: SliderTheme
                                                                      .of(
                                                                          context)
                                                                  .copyWith(
                                                                valueIndicatorColor:
                                                                    Colors
                                                                        .black, // This is what you are asking for
                                                                // Custom Gray Color
                                                              ),
                                                              child:
                                                                  RangeSlider(
                                                                activeColor:
                                                                    main_color,
                                                                values: RangeValues(
                                                                    (allsearches[index].minDistance ??
                                                                            0)
                                                                        .toDouble(),
                                                                    (allsearches[index].maxDistance ??
                                                                            0)
                                                                        .toDouble()),
                                                                max: 200,
                                                                divisions: 10,
                                                                onChanged: (allsearches[index]
                                                                            .isSearch ==
                                                                        true)
                                                                    ? (RangeValues
                                                                        values) {
                                                                        if (!mounted)
                                                                          return;

                                                                        // Enforce a minimum range of 20
                                                                        if ((values.end -
                                                                                values.start) >=
                                                                            20) {
                                                                          setState(
                                                                              () {
                                                                            _currentRangeValues =
                                                                                values;
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            _currentRangeValues =
                                                                                RangeValues(
                                                                              values.start,
                                                                              values.start + 20 > 200 ? 200 : values.start + 20,
                                                                            );
                                                                          });
                                                                        }
                                                                      }
                                                                    : null,
                                                                labels:
                                                                    RangeLabels(
                                                                  _currentRangeValues
                                                                      .start
                                                                      .round()
                                                                      .toString(),
                                                                  _currentRangeValues
                                                                      .end
                                                                      .round()
                                                                      .toString(),
                                                                ),
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  height: 35,
                                                                  width: 55,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                  ),
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      // Track
                                                                      AnimatedContainer(
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: allsearches[index].isSearch == false
                                                                              ? main_color
                                                                              : Colors.black12,
                                                                          borderRadius:
                                                                              BorderRadius.circular(30.0),
                                                                        ),
                                                                        width:
                                                                            55,
                                                                        height:
                                                                            28,
                                                                      ),
                                                                      // Thumb with text
                                                                      Align(
                                                                        alignment: allsearches[index].isSearch ==
                                                                                false
                                                                            ? Alignment.centerRight
                                                                            : Alignment.centerLeft,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // ison =
                                                                            //     !ison;
                                                                            // setState(() =>
                                                                            //     forIos = !forIos);
                                                                          },
                                                                          child:
                                                                              AnimatedContainer(
                                                                            duration:
                                                                                const Duration(milliseconds: 200),
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              allsearches[index].isSearch == true ? "On" : "Off",
                                                                              style: TextStyle(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   height: 30,
                                                                //   width: 55,
                                                                //   decoration:
                                                                //       BoxDecoration(
                                                                //     border: Border.all(
                                                                //         color: Colors
                                                                //             .black12),
                                                                //     borderRadius:
                                                                //         BorderRadius.circular(
                                                                //             30.0),
                                                                //   ),
                                                                //   child:
                                                                //       CupertinoSwitch(
                                                                //     // overrides the default green color of the track
                                                                //     activeColor:
                                                                //         Colors
                                                                //             .white,
                                                                //     // color of the round icon, which moves from right to left
                                                                //     thumbColor: forIos
                                                                //         ? main_color
                                                                //         : Colors
                                                                //             .black12,
                                                                //     // when the switch is off
                                                                //     trackColor: forIos
                                                                //         ? Colors
                                                                //             .white
                                                                //         : Colors
                                                                //             .black12,
                                                                //     // boolean variable value
                                                                //     value:
                                                                //         forIos,
                                                                //     // changes the state of the switch
                                                                //     onChanged: (value) =>
                                                                //         setState(() =>
                                                                //             forIos =
                                                                //                 value),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Search By Category",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color:
                                                                      main_color,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Male",
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                              ),
                                                              child:
                                                                  CupertinoSwitch(
                                                                // overrides the default green color of the track
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                // color of the round icon, which moves from right to left
                                                                thumbColor: forIos2
                                                                    ? main_color
                                                                    : Colors
                                                                        .black12,
                                                                // when the switch is off
                                                                trackColor: forIos2
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black12,
                                                                // boolean variable value
                                                                value: forIos2,
                                                                // changes the state of the switch
                                                                onChanged: (value) =>
                                                                    setState(() =>
                                                                        forIos2 =
                                                                            value),
                                                              ),
                                                            ),
                                                            Text(
                                                              "Female",
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Sans-serif'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      nameContainer6(
                                                          'images/icons/calender.png',
                                                          "Age",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .age!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/religion.png',
                                                          "Religion",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .religion!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/kundli.png',
                                                          "Kundli Dosh",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .kundlidosh!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/marital_status.png',
                                                          "Marital Status",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .marital_status!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/food.png',
                                                          "Diet",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .diet!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/smoke.png',
                                                          "Smoke",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .smoke!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/drink.png',
                                                          "Drink",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .drink!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/disability.png',
                                                          "Disability With Person",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .disability!),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      allsearches[index]
                                                                      .height ==
                                                                  null ||
                                                              allsearches[index]
                                                                  .height!
                                                                  .isEmpty ||
                                                              result.isEmpty
                                                          ? nameContainer4(
                                                              'images/icons/disability.png',
                                                              "Disability With Person",
                                                              functions()
                                                                  .AgeDialog,
                                                              allsearches[index]
                                                                  .height!)
                                                          : nameContainerHeight(
                                                              'images/icons/height.png',
                                                              "Height",
                                                              functions()
                                                                  .AgeDialog,
                                                              result,
                                                              sdl.Height),
                                                      // HeightList, sdl.Height),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/education.png',
                                                          "Education",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .education!),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/profession_suitcase.png',
                                                          "Profession",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .profession!),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer4(
                                                          'images/icons/hand_rupee.png',
                                                          "Income",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .income!),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      nameContainer5(
                                                          'images/icons/location.png',
                                                          "Location",
                                                          functions().AgeDialog,
                                                          allsearches[index]
                                                              .location!),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (searchingbool)
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child: CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      main_color))),
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 300,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shadowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    //side: BorderSide(color: Colors.black)
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              child: const Text(
                                                "Search",
                                                style: TextStyle(
                                                  fontFamily: 'Serif',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final data = await SearchProfile().addtosearchprofile(
                                                    isSearch: forIos,
                                                    searchprofile:
                                                        _searchIDController
                                                            .text,
                                                    email: userSave.email!,
                                                    name: userSave.name!,
                                                    searchemailprofile:
                                                        _searchEmailController
                                                            .text,
                                                    searchnameprofile:
                                                        _searchNameController
                                                            .text,
                                                    searchphoneprofile:
                                                        _searchphoneController
                                                            .text,
                                                    searchsurprofile:
                                                        _searchSurnameController
                                                            .text,
                                                    searchDistance:
                                                        _currentSliderValue
                                                            .toString(),
                                                    age: svp.AgeList.toString(),
                                                    religion: svp.ReligionList
                                                        .toString(),
                                                    kundalidosh:
                                                        svp.KundaliDoshList
                                                            .toString(),
                                                    marital_status:
                                                        svp.MaritalStatusList.toString(),
                                                    diet: svp.dietList.toString(),
                                                    smoke: svp.SmokeList.toString(),
                                                    drink: svp.DrinkList.toString(),
                                                    disability: svp.DisabilityList.toString(),
                                                    height: svp.HeightList.toString(),
                                                    education: svp.EducationList.toString(),
                                                    profession: svp.ProfessionList.toString(),
                                                    income: svp.IncomeList.toString(),
                                                    location: "${svp.LocatioList[0].isEmpty ? "" : svp.LocatioList[0][0]} ${svp.LocatioList[1].isEmpty ? "" : svp.LocatioList[1][0]} ${svp.LocatioList[2].isEmpty ? "" : svp.LocatioList[2][0]}");
                                                getProfileSearch(data);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 300,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shadowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.black),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    //side: BorderSide(color: Colors.black)
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              child: const Text(
                                                "Reset",
                                                style: TextStyle(
                                                  fontFamily: 'Serif',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                _searchEmailController.clear();
                                                _searchIDController.clear();
                                                _searchEmailController.clear();
                                                _searchNameController.clear();
                                                _searchSurnameController
                                                    .clear();

                                                svp.AgeList.clear();
                                                svp.DisabilityList.clear();
                                                svp.DrinkList.clear();
                                                svp.EducationList.clear();
                                                svp.HeightList.clear();
                                                svp.IncomeList.clear();
                                                svp.KundaliDoshList.clear();
                                                svp.LocatioList[0].clear();
                                                svp.LocatioList[1].clear();
                                                svp.LocatioList[2].clear();
                                                svp.MaritalStatusList.clear();
                                                svp.ProfessionList.clear();
                                                svp.ReligionList.clear();
                                                svp.SmokeList.clear();
                                                svp.dietList.clear();
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Seen by ${allsearches[index].adminname} on ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(allsearches[index].createdAt!).toLocal())}",
                                            style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Sans-serif'),
                                          ),
                                          Text(
                                            "(${allsearches[index].profileFound} Profile Found) (Seen-${allsearches[index].profileFound})",
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: main_color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Sans-serif'),
                                          ),
                                          SizedBox(height: 30),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),
                        )
          // : SingleChildScrollView(

          ),
    );
  }

  getProfileSearchByProfile(String id) async {
    try {
      // var a, b;
      // var fireStore = FirebaseFirestore.instance;
      if (profileSearch != null && profileSearch != "") {
        SearchProfile().addtoadminnotification(
            userid: userSave.uid!,
            useremail: userSave.email!,
            userimage:
                userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
            title:
                "${userSave.displayName} SEARCH ${profileSearch} BY PROFILE ID",
            email: userSave.email!,
            subtitle: "");
        // String name = (NameSearch.toUpperCase()).trim();
        // a = await fireStore
        //     .collection("user_data")
        //     .where('email', isEqualTo: profileSearch)
        //     .where('gender', isNotEqualTo: userSave.gender)
        //     .get();

        // Query<Map<String, dynamic>> qry = fireStore.collection("user_data");
        // qry = qry.where("puid", isEqualTo: name);
        // // qry = qry.where('gender', isNotEqualTo: userSave.gender);
        // b = await qry.get();
        List<NewUserModel> allusers = await SearchProfile()
            .getuserdatabyid(puid: profileSearch, email: userSave.email!);
        setState(() {});
        if (allusers != null && allusers.isNotEmpty) {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SlideProfile(
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
              title:
                  "${userSave.displayName} SEARCH  PROFILE  ${profileSearch} BY PROFILE ID (SEARCH BAR )",
              email: userSave.email!,
              subtitle: "");
          showDialog(
              context: context,
              builder: (context) {
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop(true);
                // });
                return const AlertDialog(
                  content: SnackBarContent(
                    error_text: "Please Enter Valid Profile ID",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              });
        }
      }
    } catch (e) {}
  }

  getProfileSearchByName(String id) async {
    try {
      if (NameSearch != null && _searchNameController.text != "") {
        SearchProfile().addtoadminnotification(
            userid: userSave.uid!,
            useremail: userSave.email!,
            userimage:
                userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
            title:
                "${userSave.displayName} SEARCH ${_searchNameController.text} BY NAME",
            email: userSave.email!,
            subtitle: "");
        List<NewUserModel> allusers = await SearchProfile()
            .getuserdatabyname(name: NameSearch, email: userSave.email!);
        setState(() {});
        if (allusers != null && allusers.isNotEmpty) {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SlideProfile(
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
              title:
                  "${userSave.displayName} SEARCH ${_searchNameController.text} BY NAME (WRONG)",
              email: userSave.email!,
              subtitle: "");
          showDialog(
              context: context,
              builder: (context) {
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop(true);
                // });
                return const AlertDialog(
                  content: SnackBarContent(
                    error_text: "Please Enter Valid Name",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              });
        }
      }
    } catch (e) {}
  }

  getProfileSearchByPhone(String id) async {
    try {
      if (phoneSearch != null && _searchphoneController.text != "") {
        SearchProfile().addtoadminnotification(
            userid: userSave.uid!,
            useremail: userSave.email!,
            userimage:
                userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
            title:
                "${userSave.displayName} SEARCH  ${_searchphoneController.text} BY PHONE NUMBER",
            email: userSave.email!,
            subtitle: "");
        if (phoneSearch.contains("+91")) {
        } else {
          phoneSearch = "+91$phoneSearch";
          print("+91" + phoneSearch);
          setState(() {});
        }
        List<NewUserModel> allusers = await SearchProfile()
            .getuserdatabyphone(phone: phoneSearch, email: userSave.email!);
        setState(() {});
        if (allusers != null && allusers.isNotEmpty) {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SlideProfile(
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
              title:
                  "${userSave.displayName} SEARCH  ${_searchphoneController.text} BY PHONE NUMBER (WRONG)",
              email: userSave.email!,
              subtitle: "");
          showDialog(
              context: context,
              builder: (context) {
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop(true);
                // });
                return const AlertDialog(
                  content: SnackBarContent(
                    error_text: "Please Enter Valid Number",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              });
        }
      }
    } catch (e) {}
  }

  getProfileSearchBySurname(String id) async {
    try {
      if (SurnameSearch != null && SurnameSearch != "") {
        SearchProfile().addtoadminnotification(
            userid: userSave.uid!,
            useremail: userSave.email!,
            userimage:
                userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
            title: "${userSave.displayName} SEARCH ${SurnameSearch} BY SURNAME",
            email: userSave.email!,
            subtitle: "");
        List<NewUserModel> allusers = await SearchProfile()
            .getuserdatabysurname(
                surname: SurnameSearch, email: userSave.email!);
        setState(() {});
        print(allusers);
        if (allusers != null && allusers.isNotEmpty) {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SearchSlideProfile(
                        lat: userSave.latitude!,
                        lng: userSave.longitude!,
                        ages: svp.AgeList,
                        religionList: svp.ReligionList,
                        kundaliDoshList: svp.KundaliDoshList,
                        maritalStatusList: svp.MaritalStatusList,
                        dietList: svp.dietList,
                        drinkList: svp.DrinkList,
                        smokeList: svp.SmokeList,
                        disabilityList: svp.DisabilityList,
                        heightList: svp.HeightList.isEmpty
                            ? []
                            : [
                                sdl.Height[int.parse(svp.HeightList[0])],
                                sdl.Height[int.parse(svp.HeightList[1])]
                              ],
                        educationList: svp.EducationList,
                        professionList: svp.ProfessionList,
                        incomeList: svp.IncomeList,
                        citylocation: svp.LocatioList[2],
                        statelocation: svp.LocatioList[1],
                        location: svp.LocatioList[0],
                        currentSliderValue: _currentSliderValue.toInt(),
                        forIos: forIos2,
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
              title:
                  "${userSave.displayName} SEARCH ${SurnameSearch} BY SURNAME (WRONG)",
              email: userSave.email!,
              subtitle: "");
          showDialog(
              context: context,
              builder: (context) {
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop(true);
                // });
                return const AlertDialog(
                  content: SnackBarContent(
                    error_text: "Please Enter Valid Surname",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              });
        }
      }
    } catch (e) {}
  }

  deletedProfile() async {
    print('deletedprofile running');
    try {
      var a, b;
      var fireStore = FirebaseFirestore.instance;
      // .collection("deleted_account")
      // .doc()
      // .get();
      // if (SurnameSearch != null && SurnameSearch != "") {
      // String name = (SurnameSearch.substring(0, 1).toUpperCase() +
      //     SurnameSearch.substring(1).toLowerCase()).trim();
      Query<Map<String, dynamic>> qry = fireStore.collection("deleted_account");
      qry = qry.where("gender", isNotEqualTo: "abcr");
      // qry = qry.where('gender', isNotEqualTo: userSave.gender);
      b = await qry.get();
      try {
        print(b.docs);
        print("hello");
      } catch (e) {}

      if (b != null && b.docs.isNotEmpty) {
        print("push page running");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (builder) => SlideProfile(
                      user_data: b,
                      isdelete: true,
                    )),
            (route) => false);
      } else {
        print("push page not running");
        showDialog(
            context: context,
            builder: (context) {
              // Future.delayed(const Duration(seconds: 1), () {
              //   Navigator.of(context).pop(true);
              // });
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Valid Surname",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
        // }
      }
    } catch (e) {}
  }

  getProfileSearchByEmail(String id) async {
    try {
      // var a, b;
      // var fireStore = FirebaseFirestore.instance;
      if (EmailSearch != null && EmailSearch != "" ||
          _searchEmailController.text.isNotEmpty) {
        // Query<Map<String, dynamic>> qry = fireStore.collection("user_data");
        // qry = qry.where("email", isEqualTo: _searchEmailController);
        // // qry = qry.where('gender', isNotEqualTo: userSave.gender);
        // b = await qry.get();
        List<NewUserModel> allusers = await SearchProfile().getuserdatabyemail(
            searchemail: _searchEmailController.text, email: userSave.email!);
        setState(() {});

        if (allusers.isNotEmpty) {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          SearchProfile().addtoadminnotification(
              userid: allusers[0].id!,
              useremail: allusers[0].email!,
              userimage: allusers[0].imageurls.isEmpty
                  ? ""
                  : allusers[0].imageurls![0]!,
              title:
                  "${userSave.displayName} SEARCH ${_searchEmailController.text} BY EMAIL",
              email: userSave.email!,
              subtitle: "");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SlideProfile(
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
          SearchProfile().addtoadminnotification(
              userid: " userSave.uid!",
              useremail: "userSave.email!",
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0]!,
              title:
                  "${userSave.displayName} SEARCH ${_searchEmailController.text} BY EMAIL",
              email: userSave.email!,
              subtitle: "");
          showDialog(
              context: context,
              builder: (context) {
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop(true);
                // });
                return const AlertDialog(
                  content: SnackBarContent(
                    error_text: "Please Enter Valid Email",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              });
        }
      }
    } catch (e) {}
  }

  getProfileSearch(String id) async {
    print(userSave.longitude);
    print(userSave.latitude);
    if (!mounted) return;
    setState(() {
      searchingbool = true;
    });

    try {
      // var fireStore = FirebaseFirestore.instance;
      // var abc;
      // var a, b, c, d, e, f, g, h, i, j, k, l, m;
      var gen;

      if (userSave.gender == "male") {
        gen = "female";
      } else {
        gen = "male";
      }

      // List<User> finalquery = [];
      // List<User> temp = [];
      if (svp.AgeList.isNotEmpty ||
          svp.ReligionList.isNotEmpty ||
          svp.KundaliDoshList.isNotEmpty ||
          svp.dietList.isNotEmpty ||
          svp.MaritalStatusList.isNotEmpty ||
          svp.SmokeList.isNotEmpty ||
          svp.DisabilityList.isNotEmpty ||
          svp.HeightList.isNotEmpty ||
          svp.EducationList.isNotEmpty ||
          svp.ProfessionList.isNotEmpty ||
          svp.IncomeList.isNotEmpty ||
          //  svp.LocatioList.isNotEmpty||
          svp.LocatioList[0].isNotEmpty ||
          svp.LocatioList[1].isNotEmpty ||
          svp.LocatioList[2].isNotEmpty ||
          _currentRangeValues.end != 0.0) {
        List<NewUserModel> allusers = await SearchProfile().searchuserdata(
            maxDistanceKm: _currentRangeValues.end.toInt(),
            lat: userSave.latitude!,
            lng: userSave.longitude!,
            gender: forIos2 == false ? "male" : "female",
            email: userSave.email!,
            religion: userSave.email!,
            page: 1,
            ages: svp.AgeList,
            religionList: svp.ReligionList,
            kundaliDoshList: svp.KundaliDoshList,
            maritalStatusList: svp.MaritalStatusList,
            dietList: svp.dietList,
            drinkList: svp.DrinkList,
            smokeList: svp.SmokeList,
            disabilityList: svp.DisabilityList,
            heightList: svp.HeightList.isEmpty
                ? []
                : [
                    sdl.Height[int.parse(svp.HeightList[0])],
                    sdl.Height[int.parse(svp.HeightList[1])]
                  ],
            educationList: svp.EducationList,
            professionList: svp.ProfessionList,
            incomeList: svp.IncomeList,
            citylocation: svp.LocatioList[2],
            statelocation: svp.LocatioList[1],
            location: svp.LocatioList[0]);
        print(allusers);
        if (_currentRangeValues.end != 0.0) {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
              title:
                  "${userSave.displayName} SEARCH ${forIos2 == true ? "MALE" : "FEMALE"} PROFILE BY WITHIN ${_currentRangeValues.end} KM",
              email: userSave.email!,
              subtitle: "");
        } else {
          SearchProfile().addtoadminnotification(
              userid: userSave.uid!,
              useremail: userSave.email!,
              userimage:
                  userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
              title:
                  "${userSave.displayName} SEARCH ${forIos2 == true ? "MALE" : "FEMALE"} PROFILE BY PARAMETERS",
              email: userSave.email!,
              subtitle: "");
        }

        //  print()
        if (allusers.isEmpty) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchProfileError()));
        } else {
          SearchProfile()
              .increaseSearchProfileFound(id: id, number: allusers.length);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchSlideProfile(
                    ages: svp.AgeList,
                    religionList: svp.ReligionList,
                    lat: userSave.latitude!,
                    lng: userSave.longitude!,
                    kundaliDoshList: svp.KundaliDoshList,
                    maritalStatusList: svp.MaritalStatusList,
                    dietList: svp.dietList,
                    drinkList: svp.DrinkList,
                    smokeList: svp.SmokeList,
                    disabilityList: svp.DisabilityList,
                    heightList: svp.HeightList.isEmpty
                        ? []
                        : [
                            sdl.Height[int.parse(svp.HeightList[0])],
                            sdl.Height[int.parse(svp.HeightList[1])]
                          ],
                    educationList: svp.EducationList,
                    professionList: svp.ProfessionList,
                    incomeList: svp.IncomeList,
                    citylocation: svp.LocatioList[2],
                    statelocation: svp.LocatioList[1],
                    location: svp.LocatioList[0],
                    currentSliderValue: _currentRangeValues.end.toInt(),
                    forIos: forIos2,
                    user_data: allusers,
                  )));
        }
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              // Future.delayed(const Duration(seconds: 1), () {
              //   Navigator.of(context).pop(true);
              // });
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Data",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      searchingbool = false;
    });
    // ProfilePage(userSave: User.fromdoc(element))));
    // num = userlist.length;
    // }
    // );
    // }
    // );
  }

  searchByDistance() async {
    // var gen;

    // if (userSave.gender == "male") {
    //   gen = "female";
    // } else {
    //   gen = "male";
    // }
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection("user_data");
    // query = query.where('gender', isEqualTo: gen);
    var listUid = await LocationSearchByDistance.searchUids(
        _currentRangeValues.end * 1000, query);
    Set commonData = listUid.toSet();
    if (commonData.isEmpty) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SearchProfileError()));
    } else {
      var query3 = FirebaseFirestore.instance.collection("user_data");

      var result = await SearchFunctions()
          .largeWherein(query3, 'uid', commonData.toList());
      if (result != null && result.isNotEmpty) {
        print("try comp");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SlideProfile(user_list: result)));

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (builder) => SlideProfile(notiPage: false,user_list: result)),
        //     (route) => false);
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchProfileError()));
      }
    }
  }

  queryintersect(List<User> a, List<User> b) {
    Set<User> set1 = a.toSet();
    Set<User> set2 = b.toSet();
    Set<User> intersection;
    // if (a.isNotEmpty && b.isNotEmpty) {
    intersection = set1.intersection(set2);
    // }
    List<User> result = intersection.toList();
    return result;
  }

  getLocationSearch() async {
    var fireStore = FirebaseFirestore.instance;
    var user_data = await fireStore
        .collection("user_data")
        .where('uid', isEqualTo: profileSearch)
        .get();
    // await fireStore
    //     .collection("user_data")
    //     .where("gender" == "male")
    //     .limit(10)
    //     .snapshots();
    // print();
    setState(() {
      // userlist=user_data.docs.map((e) => e.data())()
      user_data.docs.forEach((element) {
        // print(element..toString());
        // profilelist.add(User.fromdoc(element));
        // num = userlist.length;
      });
    });
  }
}
