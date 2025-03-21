import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import '../../Assets/Error.dart';
import '../../Assets/ayushWidget/big_text.dart';
import '../../Assets/caldener.dart';
import '../../globalVars.dart';
import '../../models/kundli_model_history.dart';
import '../../screens/data_collection/location.dart';
import '../service/search_profile.dart';
import 'kundli_match_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

List<String> list1 = <String>[
  'Year',
  '1990',
  '1991',
  '1992',
  '1993',
  '1994',
  '1995',
  '1996',
  '1997',
  '1998',
  '1999',
  '2000',
  '2001',
  '2002',
  '2003',
  '2004',
  '2005',
  '2006',
  '2007',
  '2008',
  '2009',
  '2010',
  '2011',
  '2012',
  '2013',
  '2014',
  '2015',
  '2016',
  '2017',
  '2018',
  '2019',
  '2020',
  '2021',
  '2022',
  '2023',
  '2024'
]; //'2000',
List<String> list2 = <String>['Date', 'Two', 'Three', 'Four'];
List<String> list3 = <String>[
  'Month',
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
List<String> list4 = <String>['Date'];

List<String> list5 = <String>[
  'Date',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30'
];

List<String> list6 = <String>[
  'Date',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29'
];

List<String> list7 = <String>[
  'Date',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28'
];
List<String> list8 = <String>['Date'];

class KundliMatch extends StatefulWidget {
  final NewUserModel newusermode;
  final List<KundliMatchHistoryModel> allkundali;
  const KundliMatch({super.key, required this.allkundali, required this.newusermode});

  @override
  State<KundliMatch> createState() => _KundliMatchState();
}

class _KundliMatchState extends State<KundliMatch> {
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyBgldLriecKqG8pYkQIUX5CI72rUREhIrQ');
  final _searchController = TextEditingController();
  final _searchController2 = TextEditingController();
  String? location;
  String? location2;
  DateDuration? duration;
  DateDuration? dateOfBirth;
  var height_suggest1 = 0.0;
  var height_suggest2 = 0.0;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  bool _isFocused = false;
  int mdate = 1;
  int mmonth = 1;
  int myear = 1;
  int fdate = 1;
  int fmonth = 1;
  int fyear = 1;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange2);
    
  }

  updateMaleDate(var date, var month, var year) {
    print("update male date called");
    print("$date  $month $year");
    mdate = date;
    mmonth = month;
    myear = year;
  }

  updateFemaleDate(var date, var month, var year) {
    fdate = date;
    fmonth = month;
    fyear = year;
  }

  void _onFocusChange() {
    if (_isFocused) {
      setState(() {
        height_suggest1 = 0.0;
      });
    }

    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onFocusChange2() {
    if (_isFocused) {
      setState(() {
        height_suggest2 = 0.0;
      });
    }
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  List<Prediction> _predictions = [];
  List<Prediction> _predictions2 = [];
  void _onSearchChanged(String value) async {
    if (value.isNotEmpty) {
      var response = await _places.autocomplete(value);
      setState(() {
        _predictions = response.predictions;
        height_suggest1 = 200;
      });
    }
  }

  void _onSearchChanged2(String value) async {
    if (value.isNotEmpty) {
      var response = await _places.autocomplete(value);
      setState(() {
        _predictions2 = response.predictions;
        height_suggest2 = 200;
      });
    }
  }

  var latf;
  var lngf;
  var latm;
  var lngm;
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController birthPlaceController2 = TextEditingController();
  void _onSelectedPlace(Prediction prediction) async {
    var placeDetail = await _places.getDetailsByPlaceId(prediction.placeId!);
    latm = placeDetail.result.geometry?.location.lat;
    lngm = placeDetail.result.geometry?.location.lng;

    // TODO: Use the lat/lng to display the selected place on the map or save it to your database

    setState(() {
      _searchController.text = prediction.description!;
      location = prediction.description!;
      birthPlaceController.text = location!;
      _predictions.clear();
    });
  }

  void _onSelectedPlace2(Prediction prediction) async {
    var placeDetail = await _places.getDetailsByPlaceId(prediction.placeId!);
    latf = placeDetail.result.geometry?.location.lat;
    lngf = placeDetail.result.geometry?.location.lng;

    // TODO: Use the lat/lng to display the selected place on the map or save it to your database

    setState(() {
      _searchController2.text = prediction.description!;
      location2 = prediction.description!;
      birthPlaceController2.text = location2!;
      _predictions2.clear();
    });
  }

  var containerHeight;

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _searchController2.dispose();
    _focusNode2.removeListener(_onFocusChange);
    _focusNode2.dispose();
    super.dispose();
  }
String getMonthName(int monthNumber) {
  // Create a DateTime object with the year and month number
  DateTime dateTime = DateTime(2000, monthNumber);

  // Format the DateTime object to get the month name
  String monthName = DateFormat('MMMM').format(dateTime);

  return monthName;
}
  DateTime? dateTime;
  void pickdate() async {
    dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2025));
    setState(() {});
  }

  String dropdownValuem1 = list1.first;
  String dropdownValuem2 = list2.first;
  String dropdownValuem3 = list3.first;
  String dropdownValuem4 = list8.first;
  String dropdownValuef1 = list1.first;
  String dropdownValuef2 = list2.first;
  String dropdownValuef3 = list3.first;
  String dropdownValuef4 = list8.first;
  // String? mmonth;
  // String? fmonth;

  String categoty = "AM";
  List<String> porductCategories = ["AM", "PM"];
  List<String> dayCategories = ["AM", "PM"];
  List<String> monthCategories = ["AM", "PM"];
  List<String> yearCategories = ["AM", "PM"];
  TextEditingController groomnamecontroller = TextEditingController();
  TextEditingController bridenamecontroller = TextEditingController();

  //Time COde

  String? mselectedHour ;
  String? mselectedMinute ;
  String mselectedAMPM = "AM";

  void saveSelectedValues() {
    int hour = int.parse(mselectedHour!);
    if (mselectedAMPM == "PM" && hour != 12) {
      hour += 12;
    } else if (mselectedAMPM == "AM" && hour == 12) {
      hour = 0;
    }
    int minute = int.parse(mselectedMinute??"00");
    print("Selected Hour: $hour");
    print("Selected Minute: $minute");
  }

  String? fselectedHour ;
  String? fselectedMinute;
  String fselectedAMPM = "AM";

  void fsaveSelectedValues() {
    int hour = int.parse(fselectedHour!);
    if (fselectedAMPM == "PM" && hour != 12) {
      hour += 12;
    } else if (fselectedAMPM == "AM" && hour == 12) {
      hour = 0;
    }
    int minute = int.parse(fselectedMinute??"00");
    print("Selected Hour: $hour");
    print("Selected Minute: $minute");
  }
   final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
         appBar: CustomAppBar(title: 'Kundli Match', iconImage: 'images/icons/kundli.png') ,
        body:  widget.allkundali.isEmpty?Center(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                 
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Groom's Information",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: groomnamecontroller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Groom's Name",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Date of Birth",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                
                            Calender(
                              useTwentyOneYears: true,
                              setdate: updateMaleDate,
                            ),
                
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Birth Time",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: SizedBox(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.29,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            mselectedHour = value!;
                                            saveSelectedValues();
                                          });
                                        },
                                        items: List.generate(12, (int index) {
                                          String hour = (index + 1).toString();
                                          return DropdownMenuItem<String>(
                                            value: hour,
                                            child: Text(hour),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: SizedBox(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        value: mselectedMinute,
                                        onChanged: (value) {
                                          setState(() {
                                            mselectedMinute = value!;
                                            saveSelectedValues();
                                          });
                                        },
                                        items: List.generate(60, (int index) {
                                          String minute =
                                              index.toString().padLeft(2, '0');
                                          return DropdownMenuItem<String>(
                                            value: minute,
                                            child: Text(minute),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.29,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        value: mselectedAMPM,
                                        onChanged: (value) {
                                          setState(() {
                                            mselectedAMPM = value!;
                                            saveSelectedValues();
                                          });
                                        },
                                        items: <DropdownMenuItem<String>>[
                                          DropdownMenuItem<String>(
                                            value: "AM",
                                            child: Text("AM"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "PM",
                                            child: Text("PM"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                // controller: birthPlaceController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  _onSearchChanged(value);
                                },
                                focusNode: _focusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      height_suggest1 = 0.0;
                                    });
                                    return "Enter your name";
                                  }
                                  return location;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Birth place",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                            Stack(
                              children: [
                                SizedBox(height: 1),
                                Container(
                                  height: height_suggest1,
                                  child: Card(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _predictions.length,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                          child: ListTile(
                                              title: Text(_predictions[index]
                                                  .description!),
                                              onTap: () {
                                                _onSelectedPlace(
                                                    _predictions[index]);
                                                setState(() {
                                                  height_suggest1 = 0.0;
                                                });
                                              }),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                
                            Text(
                              "Bride's Information",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: bridenamecontroller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Bride's Name",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Date of Birth",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Calender(
                              useTwentyOneYears: false,
                              setdate: updateFemaleDate,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Birth Time",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                
                            Row(
                              children: [
                                Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: SizedBox(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.29,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                      hint: Text("Hours",style: TextStyle(color: Colors.black),),
                                        
                                        onChanged: (value) {
                                          setState(() {
                                            fselectedHour = value!;
                                            fsaveSelectedValues();
                                          });
                                        },
                                        items: List.generate(12, (int index) {
                                          String hour = (index + 1).toString();
                                          return DropdownMenuItem<String>(
                                            value: hour,
                                            child: Text(hour),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: SizedBox(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        value: fselectedMinute,
                      hint: Text("Minutes",style: TextStyle(color: Colors.black),),

                                        onChanged: (value) {
                                          setState(() {
                                            fselectedMinute = value!;
                                            fsaveSelectedValues();
                                          });
                                        },
                                        items: List.generate(60, (int index) {
                                          String minute =
                                              index.toString().padLeft(2, '0');
                                          return DropdownMenuItem<String>(
                                            value: minute,
                                            child: Text(minute),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: 46,
                                    width:
                                        MediaQuery.of(context).size.width * 0.29,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          color: Colors.white,
                                        ),
                                        value: fselectedAMPM,
                                        onChanged: (value) {
                                          setState(() {
                                            fselectedAMPM = value!;
                                            fsaveSelectedValues();
                                          });
                                        },
                                        items: <DropdownMenuItem<String>>[
                                          DropdownMenuItem<String>(
                                            value: "AM",
                                            child: Text("AM"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "PM",
                                            child: Text("PM"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                // controller: birthPlaceController2,
                                
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  _onSearchChanged2(value);
                                },
                                focusNode: _focusNode2,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      height_suggest2 = 0.0;
                                    });
                                    return "Enter your birth place";
                                  }
                                  return location2;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Birth place",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  height: height_suggest2,
                                  child: Card(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _predictions2.length,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                          child: ListTile(
                                              title: Text(_predictions2[index]
                                                  .description!),
                                              onTap: () {
                                                _onSelectedPlace2(
                                                    _predictions2[index]);
                                                setState(() {
                                                  height_suggest2 = 0.0;
                                                });
                                              }),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            height: 46,
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
                                    borderRadius: BorderRadius.circular(60.0),
                                  )),
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
                              onPressed: () {
                                if (groomnamecontroller.text != null &&
                                    groomnamecontroller.text != '' &&
                                    bridenamecontroller.text != null &&
                                    bridenamecontroller.text != '' &&
                                    mmonth != null &&
                                    mmonth != '' &&
                                    fmonth != null &&
                                    fmonth != '' &&
                                    mdate != null &&
                                    mdate != '' &&
                                    fdate != null &&
                                    fdate != '' &&
                                    myear != null &&
                                    myear != '' &&
                                    fyear != null &&
                                    fyear != '' &&
                                    mselectedHour != null &&
                                    mselectedHour != '' &&
                                    fselectedHour != null &&
                                    fselectedHour != '' &&
                                    mselectedMinute != null &&
                                    mselectedMinute != '' &&
                                    fselectedMinute != null &&
                                    fselectedMinute != '' &&
                                    location != null &&
                                    location != '' &&
                                    location2 != null &&
                                    location2 != '' &&
                                    latm != null &&
                                    latm != '' &&
                                    lngm != null &&
                                    lngm != '' &&
                                    latf != null &&
                                    latf != '' &&
                                    lngf != null &&
                                    lngf != '') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) =>
                                          KundaliMatchDataScreen1(
                                            m_name: groomnamecontroller.text,
                                            f_name: bridenamecontroller.text,
                                            m_month: mmonth,
                                            f_month: fmonth,
                                            m_day: mdate,
                                            f_day: fdate,
                                            m_year: myear,
                                            f_year: fyear,
                                            m_hour: mselectedHour,
                                            f_hour: fselectedHour,
                                            m_min: mselectedMinute,
                                            f_min: fselectedMinute,
                                            m_place: location,
                                            f_place: location2,
                                            m_gender: "Male",
                                            f_gender: "Female",
                                            m_lat: latm,
                                            m_lon: lngm,
                                            f_lat: latf,
                                            f_lon: lngf,
                                            m_sec: 0,
                                            f_sec: 0,
                                            m_tzone: "5.5",
                                            f_tzone: "5.5",
                                          )));
                                } else {
                                  setState(() {
                                    // var error = "Please Enter All Details";
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SnackBarContent(
                                              error_text:
                                                  "Please Enter All Details",
                                              appreciation: "",
                                              icon: Icons.error,
                                              sec: 1,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          );
                                        });
                                  });
                                }
                                // print(object)
                              },
                            ),
                          ),
                
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
          ), 
        ): Padding(
          padding: const EdgeInsets.all(8.0),
          child:PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {},
                            itemCount: widget.allkundali.length,
                            itemBuilder: (BuildContext context, int index) {
                              if(widget.allkundali[index].userid=="12345"){
                                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Groom's Information",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  controller: groomnamecontroller,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Groom's Name",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Date of Birth",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Sans-serif',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                                    
                              Calender(
                                useTwentyOneYears: true,
                                setdate: updateMaleDate,
                              ),
                                    
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Birth Time",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Sans-serif',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: SizedBox(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.29,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value:mselectedHour,
                      hint: Text("Hours",style: TextStyle(color: Colors.black),),

                                          onChanged: (value) {
                                            setState(() {
                                              mselectedHour = value!;
                                              saveSelectedValues();
                                            });
                                          },
                                          items: List.generate(12, (int index) {
                                            String hour = (index + 1).toString();
                                            return DropdownMenuItem<String>(
                                              value: hour,
                                              child: Text(index < 9 ? '0$hour' : '$hour'),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: SizedBox(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.3,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value: mselectedMinute,
                      hint: Text("Minutes",style: TextStyle(color: Colors.black),),

                                          onChanged: (value) {
                                            setState(() {
                                              mselectedMinute = value!;
                                              saveSelectedValues();
                                            });
                                          },
                                          items: List.generate(60, (int index) {
                                            String minute =
                                                index.toString().padLeft(2, '0');
                                            return DropdownMenuItem<String>(
                                              value: minute,
                                              child: Text(minute),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.29,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value: mselectedAMPM,
                                          onChanged: (value) {
                                            setState(() {
                                              mselectedAMPM = value!;
                                              saveSelectedValues();
                                            });
                                          },
                                          items: <DropdownMenuItem<String>>[
                                            DropdownMenuItem<String>(
                                              value: "AM",
                                              child: Text("AM"),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: "PM",
                                              child: Text("PM"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  controller: birthPlaceController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    _onSearchChanged(value);
                                  },
                                  focusNode: _focusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        height_suggest1 = 0.0;
                                      });
                                      return "Enter your name";
                                    }
                                    return location;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Birth place",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                              Stack(
                                children: [
                                  SizedBox(height: 1),
                                  Container(
                                    height: height_suggest1,
                                    child: Card(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: _predictions.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: ListTile(
                                                title: Text(_predictions[index]
                                                    .description!),
                                                onTap: () {
                                                  _onSelectedPlace(
                                                      _predictions[index]);
                                                  setState(() {
                                                    height_suggest1 = 0.0;
                                                  });
                                                }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                        child: SizedBox(
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          
                                  IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: (){
                                      SearchProfile().addtoadminnotification(userid: widget.newusermode!.id!, useremail:widget.newusermode!.email!, userimage:widget.newusermode!.imageurls!.isEmpty?"":widget.newusermode!.imageurls![0], 
  title: "${userSave.displayName} SEEN ${widget.newusermode!.name.substring(0, 1).toUpperCase()} ${widget.newusermode!.surname..toLowerCase()} ${widget.newusermode!.puid} KUNDLI MATCH", email: userSave.email!, subtitle: "");
                                    _pageController.nextPage( duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,);
                                  }),
                            ],
                          ),
                        ),
                      ),
                              Text(
                                "Bride's Information",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sans-serif',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  controller: bridenamecontroller,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Bride's Name",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                                    
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Date of Birth",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Sans-serif',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Calender(
                                useTwentyOneYears: false,
                                setdate: updateFemaleDate,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Birth Time",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Sans-serif',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                                    
                              Row(
                                children: [
                                  Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: SizedBox(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.29,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value:fselectedHour,
                      hint: Text("Hours",style: TextStyle(color: Colors.black),),

                                          onChanged: (value) {
                                            setState(() {
                                              fselectedHour = value!;
                                              fsaveSelectedValues();
                                            });
                                          },
                                          items: List.generate(12, (int index) {
                                            String hour = (index + 1).toString();
                                            return DropdownMenuItem<String>(
                                              value: hour,
                                          child: Text(index < 9 ? '0$hour' : '$hour'),

                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: SizedBox(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.3,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value: fselectedMinute,
                      hint: Text("Minutes",style: TextStyle(color: Colors.black),),

                                          onChanged: (value) {
                                            setState(() {
                                              fselectedMinute = value!;
                                              fsaveSelectedValues();
                                            });
                                          },
                                          items: List.generate(60, (int index) {
                                            String minute =
                                                index.toString().padLeft(2, '0');
                                            return DropdownMenuItem<String>(
                                              value: minute,
                                              child: Text(minute),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      height: 46,
                                      width:
                                          MediaQuery.of(context).size.width * 0.29,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            color: Colors.white,
                                          ),
                                          value: fselectedAMPM,
                                          onChanged: (value) {
                                            setState(() {
                                              fselectedAMPM = value!;
                                              fsaveSelectedValues();
                                            });
                                          },
                                          items: <DropdownMenuItem<String>>[
                                            DropdownMenuItem<String>(
                                              value: "AM",
                                              child: Text("AM"),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: "PM",
                                              child: Text("PM"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  controller: birthPlaceController2,
                                  
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    _onSearchChanged2(value);
                                  },
                                  focusNode: _focusNode2,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        height_suggest2 = 0.0;
                                      });
                                      return "Enter your birth place";
                                    }
                                    return location2;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Birth place",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    height: height_suggest2,
                                    child: Card(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: _predictions2.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: ListTile(
                                                title: Text(_predictions2[index]
                                                    .description!),
                                                onTap: () {
                                                  _onSelectedPlace2(
                                                      _predictions2[index]);
                                                  setState(() {
                                                    height_suggest2 = 0.0;
                                                  });
                                                }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          child: Center(
                            child: SizedBox(
                              width:MediaQuery.of(context).size.width,
                              height: 46,
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
                                      borderRadius: BorderRadius.circular(60.0),
                                    )),
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
                                onPressed: () async{
                                  if (groomnamecontroller.text != null &&
                                      groomnamecontroller.text != '' &&
                                      bridenamecontroller.text != null &&
                                      bridenamecontroller.text != '' &&
                                      mmonth != null &&
                                      mmonth != '' &&
                                      fmonth != null &&
                                      fmonth != '' &&
                                      mdate != null &&
                                      mdate != '' &&
                                      fdate != null &&
                                      fdate != '' &&
                                      myear != null &&
                                      myear != '' &&
                                      fyear != null &&
                                      fyear != '' &&
                                      mselectedHour != null &&
                                      mselectedHour != '' &&
                                      fselectedHour != null &&
                                      fselectedHour != '' &&
                                      mselectedMinute != null &&
                                      mselectedMinute != '' &&
                                      fselectedMinute != null &&
                                      fselectedMinute != '' &&
                                      location != null &&
                                      location != '' &&
                                      location2 != null &&
                                      location2 != '' &&
                                      latm != null &&
                                      latm != '' &&
                                      lngm != null &&
                                      lngm != '' &&
                                      latf != null &&
                                      latf != '' &&
                                      lngf != null &&
                                      lngf != '') {
                                        var data;
                                  var url = Uri.parse(
                                      'https://api.kundali.astrotalk.com/v1/combined/match_making');
                                
                                  var payload = {
                                    "m_detail": {
                                      "day": mdate,
                                      "hour": mselectedHour,
                                      "lat": latm,
                                      "lon": lngm,
                                      "min": mselectedMinute,
                                      "month": mmonth,
                                      "name": groomnamecontroller.text,
                                      "tzone": "5.5",
                                      "year": myear,
                                      "gender": "male",
                                      "place": location,
                                      "sec": 0
                                    },
                                    "f_detail": {
                                      "day": fdate,
                                      "hour": fselectedHour,
                                      "lat": latf,
                                      "lon": lngf,
                                      "min": fselectedMinute,
                                      "month": fmonth,
                                      "name": bridenamecontroller.text,
                                      "tzone": "5.5",
                                      "year": fyear,
                                      "gender": "female",
                                      "place": location2,
                                      "sec": 0
                                    },
                                    "languageId": 1
                                  };

                                  var body = json.encode(payload);

                                  var response = await http.post(url,
                                      body: body,
                                      headers: {
                                        'Content-Type': 'application/json'
                                      });
                                  print("*********************");
                                  print(response.body);
                                  print("*********************");
                                  if (response.statusCode == 200) {
                                    if (!mounted) return;
                                    setState(() {
                                      data = json.decode(response.body);
                                    });
                                    print(data["ashtkoot"]["varna"]
                                        ["description"]);
                                  } else {
                                    print(
                                        'Request failed with status: ${response.statusCode}.');
                                  }
                                        AdminService().addtokundaliprofile(gname: groomnamecontroller.text,
                                           bam:fselectedAMPM ,
                                      gam: mselectedAMPM,
                                      name: userSave.name!,
                                       bkundli: data['manglik']
                                                  ['male_manglik_dosha'] ==
                                              false
                                          ? "Non- Manglik".toUpperCase()
                                          : "Manglik".toUpperCase(),
                                      gkundli: data['manglik']
                                                  ['female_manglik_dosha'] ==
                                              false
                                          ? "Non- Manglik".toUpperCase()
                                          : "Manglik".toUpperCase(),
                                      uid: widget.newusermode.id,
                                         gday: mdate.toString(), gmonth: mmonth.toString(), gyear: myear.toString(),
                                          ghour: mselectedHour!, gplace: location!, gsec: mselectedMinute!,
                                           bname: bridenamecontroller.text, bday: fdate.toString(), bmonth: fmonth.toString(),
                                            byear: fyear.toString(), bhour: fselectedHour!, bsec: fselectedMinute!,
                                             bplace: location2!, totalgun:
                                              data['ashtkoot']['total']
                                              ['received_points'].toString()
                                              );
                                                SearchProfile().addtoadminnotification(userid: userSave!.uid!, useremail:userSave.email!, userimage:userSave!.imageUrls!.isEmpty?"":userSave!.imageUrls![0], 
  title: "${userSave.displayName} USES KUNDLI MATCH", email: userSave.email!, subtitle: "KU");
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (builder) =>
                                            KundaliMatchDataScreen1(
                                              m_name: groomnamecontroller.text,
                                              f_name: bridenamecontroller.text,
                                              m_month: mmonth,
                                              f_month: fmonth,
                                              m_day: mdate,
                                              f_day: fdate,
                                              m_year: myear,
                                              f_year: fyear,
                                              m_hour: mselectedHour,
                                              f_hour: fselectedHour,
                                              m_min: mselectedMinute,
                                              f_min: fselectedMinute,
                                              m_place: location,
                                              f_place: location2,
                                              m_gender: "Male",
                                              f_gender: "Female",
                                              m_lat: latm,
                                              m_lon: lngm,
                                              f_lat: latf,
                                              f_lon: lngf,
                                              m_sec: 0,
                                              f_sec: 0,
                                              m_tzone: "5.5",
                                              f_tzone: "5.5",
                                            )));

                                  } else {
                                    setState(() {
                                      // var error = "Please Enter All Details";
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SnackBarContent(
                                                error_text:
                                                    "Please Enter All Details",
                                                appreciation: "",
                                                icon: Icons.error,
                                                sec: 1,
                                              ),
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                            );
                                          });
                                    });
                                  }
                                  // print(object)
                                },
                              ),
                            ),
                                    
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                );
                              }
                             return  Container(
            width: MediaQuery.of(context).size.width,
            child: 
            SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      SizedBox(height: 100,),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Groom's Information",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Sans-serif',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              // controller: groomnamecontroller,
                              initialValue: widget.allkundali[index].gname,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your name";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Groom's Name",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
      
                          // Calender(
                          //   useTwentyOneYears: true,
                          //   setdate: updateMaleDate,
                          // ),
      Row(
                            children: [
                              Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].gday)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(getMonthName(int.parse(widget.allkundali[index].gmonth)))
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].gyear)
                                  ),
                                ),
                              ),
                              
                              
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Birth Time",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].ghour)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].gsec)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].gam)
                                  ),
                                ),
                              ),
                              
                              
                            ],
                          ),
                          
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              // controller: birthPlaceController,
                              initialValue: widget.allkundali[index].gplace,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                _onSearchChanged(value);
                              },
                              focusNode: _focusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    height_suggest1 = 0.0;
                                  });
                                  return "Enter your name";
                                }
                                return location;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Birth place",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
                          Stack(
                            children: [
                              SizedBox(height: 1),
                              Container(
                                height: height_suggest1,
                                child: Card(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _predictions.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        child: ListTile(
                                            title: Text(_predictions[index]
                                                .description!),
                                            onTap: () {
                                              _onSelectedPlace(
                                                  _predictions[index]);
                                              setState(() {
                                                height_suggest1 = 0.0;
                                              });
                                            }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                   index==0?Center():     IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>{
                                  _pageController.previousPage( duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,)
                                }),              
                                IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                                  _pageController.nextPage( duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,)
                                }),
                          ],
                        ),
                      ),
                    ),
                          Text(
                            "Bride's Information",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Sans-serif',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              // controller: bridenamecontroller,
                              initialValue: widget.allkundali[index].bname,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your name";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Bride's Name",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
      
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].bday)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(getMonthName(int.parse(widget.allkundali[index].bmonth)) )
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].byear)
                                  ),
                                ),
                              ),
                              
                              
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Birth Time",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Sans-serif',
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
      
                          Row(
                            children: [
                              Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].bhour)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].bsec)
                                  ),
                                ),
                              ),
                               Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: Center(
                                    child: Text(widget.allkundali[index].bam)
                                  ),
                                ),
                              ),
                              
                              
                            ],
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              // controller: birthPlaceController2,
                              initialValue: widget.allkundali[index].bplace,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                _onSearchChanged2(value);
                              },
                              focusNode: _focusNode2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    height_suggest2 = 0.0;
                                  });
                                  return "Enter your birth place";
                                }
                                return location2;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Birth place",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Container(
                                height: height_suggest2,
                                child: Card(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _predictions2.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        child: ListTile(
                                            title: Text(_predictions2[index]
                                                .description!),
                                            onTap: () {
                                              _onSelectedPlace2(
                                                  _predictions2[index]);
                                              setState(() {
                                                height_suggest2 = 0.0;
                                              });
                                            }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 46,
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
                                  borderRadius: BorderRadius.circular(60.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                            child: const Text(
                              "Match",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) =>
                                        KundaliMatchDataScreen(
                                          m_name: widget.allkundali[index].bname,
                                          f_name: widget.allkundali[index].gname,
                                          m_month: widget.allkundali[index].bmonth,
                                          f_month: widget.allkundali[index].gmonth,
                                          m_day: widget.allkundali[index].bday,
                                          f_day: widget.allkundali[index].gday,
                                          m_year: widget.allkundali[index].byear,
                                          f_year: widget.allkundali[index].gyear,
                                          m_hour: widget.allkundali[index].bhour,
                                          f_hour: widget.allkundali[index].ghour,
                                          m_min: widget.allkundali[index].bsec,
                                          f_min: widget.allkundali[index].gsec,
                                          m_place: widget.allkundali[index].bplace,
                                          f_place: widget.allkundali[index].gplace,
                                          m_gender: "Male",
                                          bkundli: widget.allkundali[index].bkundli,
                                          gkundli: widget.allkundali[index].gkundli,
                                          f_gender: "Female",
                                          totalgun:widget.allkundali[index].totalgun,
                                          m_lat: latm,
                                          m_lon: lngm,
                                          f_lat: latf,
                                          f_lon: lngf,
                                          m_sec: 0,
                                          f_sec: 0,
                                          m_tzone: "5.5",
                                          f_tzone: "5.5",
                                        )));
                             
                              // print(object)
                            },
                          ),
                        ),
      
                      ),
                    ),
                    SizedBox(height: 5,),
                      Text("Used by:${widget.allkundali[index].name}",style:  TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),),
                    Text("Total Gun:${widget.allkundali[index].totalgun}",style:  TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),),
                    Text( DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(widget.allkundali[index].createdAt).toLocal()),style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),)
                  ],
                ),
              ),
            ),
          );}),
        ),
      ),
    );
  }
}
