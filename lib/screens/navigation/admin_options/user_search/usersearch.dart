import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/user_search.dart';
import 'package:matrimony_admin/screens/ERRORs/search_profile_error.dart';
import 'package:matrimony_admin/screens/Search_profile/functionSearch.dart';
import 'package:matrimony_admin/screens/Search_profile/search_dynamic_pages.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/user_search/circle_bar.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';

import '../../../../Assets/ayushWidget/big_text.dart';
import '../../../../models/new_user_model.dart';
import '../../../../models/user_model.dart';
import '../../../Search_profile/search_profiles.dart';
import '../../../service/search_profile.dart';

class UserSearch extends StatefulWidget {
  final NewUserModel userSave;
  final List<UserSearchModel> searchs;
  UserSearch({super.key, required this.searchs, required this.userSave});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  SavedPref svp = SavedPref();
  double _currentSliderValue = 0;
  @override
  bool forIos = false;
  bool searchingbool = false;
  late String profileSearch = "";

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  SearchDataList sdl = SearchDataList();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  TextEditingController _searchIDController = TextEditingController();
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
                  ))
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            // var ds = await Navigator.of(context).push(MaterialPageRoute(
            //     builder: (builder) => DynamicPage(
            //         icon: icon,
            //         head: head,
            //         options: options,
            //         selectedopt: val)));

            // if (ds != null) {
            //   setState(() {
            //     val.clear();
            //   });
            //   for (var i = 0; i < ds.length; i++) {
            //     setState(() {
            //       val.add(ds[i]);
            //     });
            //   }
            // }
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
                size: 18,
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
          onTap: () async {},
          child: Row(
            children: [
              (val == "[]")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 18,
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
            // var ds = await tap(context);
            // print(ds.toString());
            // if (ds != null) {
            //   // setState(() {
            //   val.clear();
            //   // });
            //   for (var i = 0; i < ds.length; i++) {
            //     setState(() {
            //       val.add(ds[i]);
            //     });
            //   }
            // }
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
                size: 18,
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
            // var ds = await tap(context, val);
            // print(ds.toString());
            // if (ds != null) {
            //   if (!mounted) return;
            //   setState(() {
            //     val.clear();
            //   });
            //   for (var element in ds) {
            //     if (!mounted) return;

            //     setState(() {
            //       val.add(element);
            //     });
            //   }
            //   // setState(() {
            //   //   val.add(ds[]);
            //   // });
            //   // }
            // }
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
                size: 18,
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
            // var ds = await tap(context);
            // print(ds.toString());
            // if (ds != null) {
            //   // setState(() {
            //   val.clear();
            //   // });
            //   for (var i = 0; i < ds.length; i++) {
            //     setState(() {
            //       val.add(ds[i]);
            //     });
            //   }
            // }
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
                size: 18,
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
          onTap: () async {},
          child: Row(
            children: [
              (val == "[]")
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans-serif'),
                    )
                  : val.contains("Any")
                      ? Text(
                          "Any",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black38,
                              fontSize: 18,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black38,
                size: 18,
              )
            ],
          ),
        )
      ],
    );
  }

  nameContainer5(icon, String head, Function tap, List<dynamic>? val,
      List<dynamic>? city, List<dynamic>? state) {
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
//  var ds = await tap(context, val);
            print(val);
          },
          child: Row(
            children: [
              (val!.isEmpty && city!.isEmpty && state!.isEmpty)
                  ? Text(
                      "Add",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: 18,
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
                                "${val.isNotEmpty ? val[0] : ""},${state!.isNotEmpty ? state[0] : ""},${city!.isNotEmpty ? city[0] : ""}",
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
                size: 18,
              )
            ],
          ),
        )
      ],
    );
  }

  final PageController _pageController = PageController(initialPage: 0);
  bool forIos2 = false;

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Search Profile",
          iconImage: "images/icons/search.png",
          onBackButtonPressed: () {
            Navigator.of(context).pop();
            widget.searchs.removeAt(0);
          },
        ),
        body: SafeArea(
          child: widget.searchs.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
              : PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    print(widget.searchs[index].location);
                    selectedCity!.clear();
                    selectedCounty!.clear();
                    selectedState!.clear();
                    if (widget.searchs[index].userid == "12") {
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
                          i < widget.searchs[index].citylocation!.length;
                          i++) {
                        selectedCity!.add(
                            {"name": widget.searchs[index].citylocation![i]});
                      }
                      for (var i = 0;
                          i < widget.searchs[index].location1!.length;
                          i++) {
                        selectedCounty!
                            .add({"name": widget.searchs[index].location1![i]});
                      }
                      for (var i = 0;
                          i < widget.searchs[index].statelocation!.length;
                          i++) {
                        selectedState!.add(
                            {"name": widget.searchs[index].statelocation![i]});
                      }
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    print(widget.searchs[index].searchDistance);
                    _searchIDController.text =
                        widget.searchs[index].searchidprofile!;
                    if (widget.searchs[index].userid == "12") {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 10, right: 15),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        "Search By Profile",
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: main_color,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Sans-serif'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            70)),
                                                            child: Material(
                                                              color:
                                                                  Colors.white,
                                                              child: TextField(
                                                                controller:
                                                                    _searchIDController,
                                                                decoration: InputDecoration(
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            left:
                                                                                10),
                                                                    hintText:
                                                                        'Enter Profile Id',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            30),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                main_color)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            30),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                main_color)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        borderSide:
                                                                            BorderSide(color: main_color))),
                                                                onChanged:
                                                                    (String) {
                                                                  profileSearch =
                                                                      _searchIDController
                                                                          .text;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      main_color),
                                                              child: const Icon(
                                                                Icons.search,
                                                                size: 30.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //     if (_searchIDController.text ==
                                                    //             null ||
                                                    //         _searchIDController.text ==
                                                    //             "") {
                                                    //       showDialog(
                                                    //           context: context,
                                                    //           builder: (context) {
                                                    //             // Future.delayed(
                                                    //             //     const Duration(seconds: 1), () {
                                                    //             //   Navigator.of(context).pop(true);
                                                    //             // });
                                                    //             return const AlertDialog(
                                                    //               content: SnackBarContent(
                                                    //                 error_text:
                                                    //                     "Please Enter Profile ID",
                                                    //                 appreciation: "",
                                                    //                 icon: Icons.error,
                                                    //                 sec: 2,
                                                    //               ),
                                                    //               backgroundColor:
                                                    //                   Colors.transparent,
                                                    //               elevation: 0,
                                                    //             );
                                                    //           });
                                                    //     } else {
                                                    //       getProfileSearchByProfile();
                                                    //     }
                                                    //   },
                                                    //   child: Container(
                                                    //     decoration: BoxDecoration(
                                                    //         shape: BoxShape.circle,
                                                    //         color: main_color),
                                                    //     child: const Icon(
                                                    //       Icons.search,
                                                    //       size: 30.0,
                                                    //       color: Colors.white,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),

                                                //+9155556580544
                                              ],
                                            )),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text("Search By Distance",
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: main_color,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          'Sans-serif')),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      "${_currentSliderValue} Km",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Sans-serif'),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      "200 Km",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Sans-serif'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Within",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: main_color,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Sans-serif'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Material(
                                              color: Colors.white,
                                              child: SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  rangeThumbShape:
                                                       CircleThumbShape(
                                                         thumbColor: forIos
                                                      ? main_color
                                                      : Colors.black12,
                                                    thumbRadius:
                                                        8.0, // Size of the thumb
                                                  ),
                                                  thumbColor: Colors
                                                      .transparent, // Transparent fill for hollow center
                                                  overlayColor: Colors
                                                      .transparent, // No overlay when thumb is pressed
                                                  activeTrackColor:
                                                      main_color, // Track color for selected range
                                                  inactiveTrackColor:
                                                      main_color.withOpacity(
                                                          0.3), // Track color for unselected range
                                                  trackHeight:
                                                      4.0, // Thickness of the track
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
                                                  onChanged: forIos
                                                      ? (RangeValues values) {
                                                          if (!mounted) return;

                                                          setState(() {
                                                            // Adjust values to maintain a minimum gap of 20
                                                            double newStart =
                                                                values.start;
                                                            double newEnd =
                                                                values.end;

                                                            // If the range is less than 20, adjust the appropriate thumb
                                                            if (newEnd -
                                                                    newStart <
                                                                20) {
                                                              // If the user is moving the start thumb
                                                              if ((values.start -
                                                                          _currentRangeValues
                                                                              .start)
                                                                      .abs() >
                                                                  (values.end -
                                                                          _currentRangeValues
                                                                              .end)
                                                                      .abs()) {
                                                                newEnd =
                                                                    newStart +
                                                                        20;
                                                                if (newEnd >
                                                                    200) {
                                                                  newEnd = 200;
                                                                  newStart =
                                                                      200 - 20;
                                                                }
                                                              }
                                                              // If the user is moving the end thumb
                                                              else {
                                                                newStart =
                                                                    newEnd - 20;
                                                                if (newStart <
                                                                    0) {
                                                                  newStart = 0;
                                                                  newEnd = 20;
                                                                }
                                                              }
                                                            }

                                                            _currentRangeValues =
                                                                RangeValues(
                                                                    newStart,
                                                                    newEnd);
                                                          });
                                                        }
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            // SliderTheme(
                                            //   data: SliderTheme.of(context)
                                            //       .copyWith(
                                            //     valueIndicatorColor: Colors
                                            //         .black, // Custom Gray Color
                                            //   ),
                                            //   child: RangeSlider(
                                            //     activeColor: main_color,
                                            //     values: _currentRangeValues,
                                            //     min: 0,
                                            //     max: 200,
                                            //     divisions: 10,
                                            //     labels: RangeLabels(
                                            //       _currentRangeValues.start
                                            //           .round()
                                            //           .toString(),
                                            //       _currentRangeValues.end
                                            //           .round()
                                            //           .toString(),
                                            //     ),
                                            //     onChanged: (forIos)
                                            //         ? (RangeValues values) {
                                            //             if (!mounted) return;
                                            //             setState(() {
                                            //               _currentRangeValues =
                                            //                   values;
                                            //             });
                                            //           }
                                            //         : null,
                                            //   ),
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: CupertinoSwitch(
                                                    // overrides the default green color of the track
                                                    activeColor: Colors.white,
                                                    // color of the round icon, which moves from right to left
                                                    thumbColor: forIos
                                                        ? main_color
                                                        : Colors.black12,
                                                    // when the switch is off
                                                    trackColor: forIos
                                                        ? Colors.white
                                                        : Colors.black12,
                                                    // boolean variable value
                                                    value: forIos,
                                                    // changes the state of the switch
                                                    onChanged: (value) =>
                                                        setState(() =>
                                                            forIos = value),
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
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: main_color,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Sans-serif'),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.88,
                                              child: Column(
                                                children: [
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
                                                  (widget.userSave.religion ==
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
                                                      functions().HeightDialog,
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
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _pageController.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 18,
                                                  color: main_color,
                                                ))
                                          ],
                                        ),
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
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
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
                            // SizedBox(
                            //   height: 50,
                            //   width: 300,
                            //   child: ElevatedButton(
                            //     style: ButtonStyle(
                            //         shadowColor: MaterialStateColor.resolveWith(
                            //             (states) => Colors.black),
                            //         shape: MaterialStateProperty.all<
                            //                 RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(30.0),
                            //           //side: BorderSide(color: Colors.black)
                            //         )),
                            //         backgroundColor:
                            //             MaterialStateProperty.all<Color>(
                            //                 Colors.white)),
                            //     child: const Text(
                            //       "Search",
                            //       style: TextStyle(
                            //         fontFamily: 'Serif',
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: 20,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     onPressed: () {
                            //       getProfileSearch();
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 10, right: 15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      "Search By Profile",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: main_color,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Sans-serif'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          70)),
                                                          child: Material(
                                                            color: Colors.white,
                                                            child: TextField(
                                                              controller:
                                                                  _searchIDController,
                                                              decoration: InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          top:
                                                                              5,
                                                                          left:
                                                                              10),
                                                                  hintText:
                                                                      'Enter Profile Id',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              main_color)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              main_color)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      borderSide:
                                                                          BorderSide(color: main_color))),
                                                              onChanged:
                                                                  (String) {
                                                                profileSearch =
                                                                    _searchIDController
                                                                        .text;
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    main_color),
                                                            child: const Icon(
                                                              Icons.search,
                                                              size: 30.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              //+9155556580544
                                            ],
                                          )),

                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Divider(),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text("Search By Distance",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: main_color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Sans-serif')),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.only(right: 10),
                                          //   child: Text(
                                          //     "${widget.searchs[index].searchDistance} Km",
                                          //     style: TextStyle(
                                          //         decoration:
                                          //             TextDecoration.none,
                                          //         color: main_color,
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w400,
                                          //         fontFamily: 'Sans-serif'),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              "${_currentSliderValue} Km",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Sans-serif'),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              "200 Km",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Sans-serif'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Within",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                                          Material(
                                            color: Colors.white,
                                            child: SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                rangeThumbShape:
                                                    CircleThumbShape(
                                                  thumbColor: forIos
                                                      ? main_color
                                                      : Colors.black12,
                                                  thumbRadius:
                                                      8.0, // Size of the thumb
                                                ),
                                                thumbColor: Colors
                                                    .transparent, // Transparent fill for hollow center
                                                overlayColor: Colors
                                                    .transparent, // No overlay when thumb is pressed
                                                activeTrackColor:
                                                    main_color, // Track color for selected range
                                                inactiveTrackColor:
                                                    main_color.withOpacity(
                                                        0.3), // Track color for unselected range
                                                trackHeight:
                                                    4.0, // Thickness of the track
                                              ),
                                              child: RangeSlider(
                                                activeColor: main_color,
                                                // values: _currentRangeValues,
                                                values: RangeValues(
                                                    double.parse(widget
                                                        .searchs[index]
                                                        .searchDistance
                                                        .toString()),
                                                    80),
                                                min: 0,
                                                max: 200,
                                                divisions: 10,
                                                // labels: RangeLabels(
                                                //   _currentRangeValues.start.round().toString(),
                                                //   _currentRangeValues.end.round().toString(),
                                                // ),
                                                labels: RangeLabels(
                                                    double.parse(widget
                                                            .searchs[index]
                                                            .searchDistance
                                                            .toString())
                                                        .round()
                                                        .toString(),
                                                    "200"),
                                                onChanged: forIos
                                                    ? (RangeValues values) {
                                                        if (!mounted) return;

                                                        setState(() {
                                                          // Adjust values to maintain a minimum gap of 20
                                                          double newStart =
                                                              values.start;
                                                          double newEnd =
                                                              values.end;

                                                          // If the range is less than 20, adjust the appropriate thumb
                                                          if (newEnd -
                                                                  newStart <
                                                              20) {
                                                            // If the user is moving the start thumb
                                                            if ((values.start -
                                                                        _currentRangeValues
                                                                            .start)
                                                                    .abs() >
                                                                (values.end -
                                                                        _currentRangeValues
                                                                            .end)
                                                                    .abs()) {
                                                              newEnd =
                                                                  newStart + 20;
                                                              if (newEnd >
                                                                  200) {
                                                                newEnd = 200;
                                                                newStart =
                                                                    200 - 20;
                                                              }
                                                            }
                                                            // If the user is moving the end thumb
                                                            else {
                                                              newStart =
                                                                  newEnd - 20;
                                                              if (newStart <
                                                                  0) {
                                                                newStart = 0;
                                                                newEnd = 20;
                                                              }
                                                            }
                                                          }

                                                          _currentRangeValues =
                                                              RangeValues(
                                                                  newStart,
                                                                  newEnd);
                                                        });
                                                      }
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          // Material(
                                          //   child: SliderTheme(
                                          //     data: SliderTheme.of(context)
                                          //         .copyWith(
                                          //       valueIndicatorColor: Colors
                                          //           .black, // Custom Gray Color
                                          //     ),
                                          //     child: RangeSlider(
                                          //       activeColor: main_color,
                                          //       values: RangeValues(
                                          //           double.parse(widget
                                          //               .searchs[index]
                                          //               .searchDistance
                                          //               .toString()),
                                          //           80),
                                          //       max: 200,
                                          //       divisions: 10,
                                          //       labels: RangeLabels(
                                          //           double.parse(widget
                                          //                   .searchs[index]
                                          //                   .searchDistance
                                          //                   .toString())
                                          //               .round()
                                          //               .toString(),
                                          //           "200"),
                                          //       onChanged: null,
                                          //     ),
                                          //   ),
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 55,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: CupertinoSwitch(
                                                  // overrides the default green color of the track
                                                  activeColor: Colors.white,
                                                  // color of the round icon, which moves from right to left
                                                  thumbColor: widget
                                                              .searchs[index]
                                                              .searchDistance !=
                                                          "0.0"
                                                      ? main_color
                                                      : Colors.black12,
                                                  // when the switch is off
                                                  trackColor: widget
                                                              .searchs[index]
                                                              .searchDistance !=
                                                          "0.0"
                                                      ? Colors.white
                                                      : Colors.black12,
                                                  // boolean variable value
                                                  value: widget.searchs[index]
                                                              .searchDistance !=
                                                          "0.0"
                                                      ? true
                                                      : false,
                                                  // changes the state of the switch
                                                  onChanged: (value) =>
                                                      setState(
                                                          () => forIos = value),
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
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: main_color,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Sans-serif'),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                _pageController.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Icon(
                                                Icons.arrow_back_ios_new,
                                                size: 18,
                                                color: main_color,
                                              )),
                                          SizedBox(
                                            width: Get.width * 0.85,
                                            child: Column(
                                              children: [
                                                nameContainer6(
                                                    'images/icons/calender.png',
                                                    "Age",
                                                    functions().AgeDialog,
                                                    widget.searchs[index].age!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/religion.png',
                                                    "Religion",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .religion!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/kundli.png',
                                                    "Kundli Dosh",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .kundlidosh!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/marital_status.png',
                                                    "Marital Status",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .marital_status!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/food.png',
                                                    "Diet",
                                                    functions().AgeDialog,
                                                    widget
                                                        .searchs[index].diet!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/smoke.png',
                                                    "Smoke",
                                                    functions().AgeDialog,
                                                    widget
                                                        .searchs[index].smoke!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/drink.png',
                                                    "Drink",
                                                    functions().AgeDialog,
                                                    widget
                                                        .searchs[index].drink!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/disability.png',
                                                    "Disability With Person",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .disability!),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                nameContainer4(
                                                    'images/icons/height.png',
                                                    "Height",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .height!),
                                                // HeightList, sdl.Height),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                nameContainer4(
                                                    'images/icons/education.png',
                                                    "Education",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .education!),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                nameContainer4(
                                                    'images/icons/profession_suitcase.png',
                                                    "Profession",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .profession!),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                nameContainer4(
                                                    'images/icons/hand_rupee.png',
                                                    "Income",
                                                    functions().AgeDialog,
                                                    widget.searchs[index]
                                                        .income!),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                nameContainer5(
                                                    'images/icons/location.png',
                                                    "Location",
                                                    functions().LocationDialog,
                                                    widget.searchs[index]
                                                        .location1!,
                                                    widget.searchs[index]
                                                        .statelocation,
                                                    widget.searchs[index]
                                                        .citylocation),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                _pageController.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                                color: main_color,
                                              )),
                                        ],
                                      ),

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
                            ],
                          ),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          // SizedBox(
                          //   height: 50,
                          //   width: 300,
                          //   child: ElevatedButton(
                          //     style: ButtonStyle(
                          //         shadowColor: MaterialStateColor.resolveWith(
                          //             (states) => Colors.black),
                          //         shape: MaterialStateProperty.all<
                          //                 RoundedRectangleBorder>(
                          //             RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(30.0),
                          //           //side: BorderSide(color: Colors.black)
                          //         )),
                          //         backgroundColor:
                          //             MaterialStateProperty.all<Color>(
                          //                 Colors.white)),
                          //     child: const Text(
                          //       "Search",
                          //       style: TextStyle(
                          //         fontFamily: 'Serif',
                          //         fontWeight: FontWeight.w700,
                          //         fontSize: 20,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Search by ${widget.searchs[index].name!} ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(widget.searchs[index].createdAt!).toLocal())}",
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Sans-serif'),
                          ),

                          SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                  itemCount: widget.searchs.length,
                ),
        ),
      ),
    );
  }

  getProfileSearch() async {
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
          _currentSliderValue != 0.0) {
        List<NewUserModel> allusers = await SearchProfile().searchuserdata(
            maxDistanceKm: _currentSliderValue.toInt(),
            lat: widget.userSave.lat,
            lng: widget.userSave.lng,
            gender: widget.userSave.gender == "male" ? "female" : "male",
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
        //  print()
        if (allusers.isEmpty) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchProfileError()));
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SearchSlideProfile(
                        lat: widget.userSave.lat!,
                        lng: widget.userSave.lng!,
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
                        forIos: widget.userSave.gender == "male" ? false : true,
                        user_data: allusers,
                      )),
              (route) => false);
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

  getProfileSearchByProfile() async {
    try {
      // var a, b;
      // var fireStore = FirebaseFirestore.instance;
      if (profileSearch != null && profileSearch != "") {
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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => SlideProfile(
                        user_data: allusers,
                      )),
              (route) => false);
        } else {
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
}
