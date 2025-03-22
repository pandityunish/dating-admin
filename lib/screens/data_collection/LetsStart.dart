import 'package:age_calculator/age_calculator.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_maps_webservice/places.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:matrimony_admin/screens/data_collection/religion.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';
// import '../../Assets/calender.dart'; 
import '../../Assets/Error.dart';
import '../../Assets/caldener.dart';
import '../../Assets/tpage.dart';
import '../../globalVars.dart';
import '../../models/shared_pref.dart';
import '../service/search_profile.dart';


List<String> list1 = <String>[
  'Year',
  '1976',
  '1978',
  '1979',
  '1970',
  '1980',
  '1981',
  '1982',
  '1983',
  '1984',
  '1985',
  '1986',
  '1987',
  '1988',
  '1989',
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
List<String> minutes = <String>[
  'Minutes',
 "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"
];
String selectedhours="Hour";
String selectedminutes="Minute";
List<String> hours = <String>[
  'Hours',
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
  
];
List<String> ampm=[
  'Am','Pm'
];
String selectedampm="Am";
List<String> list8 = <String>['Date'];

class LetsStart extends StatefulWidget {
  const LetsStart({Key? key}) : super(key: key);

  @override
  State<LetsStart> createState() => _LetsStartState();
}

class _LetsStartState extends State<LetsStart> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController useremail = TextEditingController();
    TextEditingController placeofbirthcontroller = TextEditingController();

  SharedPref sharedPref = SharedPref();
  int? dob_timestamp;
  var phone_num;
  var User_Name;
  var placeofbirth;
  var User_email;
  var User_SurName;
  bool male_gender = false;
  bool female_gender = false;
  var dob = "";
  var gender;
  DateTime? pickedDate;
  DateDuration duration = DateDuration();
  String dropdownValuem1 = list1.first;
  String dropdownValuem2 = list2.first;
  String dropdownValuem3 = list3.first;
  String dropdownValuem4 = list8.first;
  String? mmonth;
  String? age;
  final FocusNode _focusNode = FocusNode();

  // DateDuration? duration;
  DateDuration? dateOfBirth;

  DateTime? dateTime;
  updateMaleDate(var date, var month, var year) {
    // print("update male date called");
    // print("$date  $month $year");
    // mdate = date;
    // mmonth = month;
    // myear = year;
    DateTime birthday = DateTime(year, month, date);
      
    duration = AgeCalculator.age(birthday);
    print(duration.years);
    age=duration.years.toString();
    
    setState(() {
      dob = duration.toString();
      dob_timestamp = birthday.millisecondsSinceEpoch;
    });
  }
bool isGmailValid(String email) {
  if (EmailValidator.validate(email)) {
    if (email.contains("@gmail.com")) {
      return true;
    }
  }
  return false;
}
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    print("initState running ???");
     _scrollController = ScrollController();
   
  }

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
     _scrollController.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  bool register = false;
  var error = "";

  runtpage() {
    // Future.delayed(const Duration(seconds: 1), () {
    if (userSave != null) {
      print('One second has passed.'); // Prints after 1 second.
      Tpage.transferPage(context, "main");
    }
    // });
  }
UserService service=Get.put(UserService());
  void onpressed() async {
    if (User_Name == null || User_Name == "") {
      setState(() {
        error = "Please Write Your Name";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Name",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if (User_SurName == null || User_SurName == "") {
      setState(() {
        error = "Please Write Your Surname";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Surname",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
      print(duration.years);
    } else if(User_email==null){
setState(() {
        error = "Please Enter email id";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Email Id",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    }  else if(!isGmailValid(User_email)){
setState(() {
        error = "Please Enter Contact Number";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Valid Email ID" ,
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
    else if (phone_num == null || phone_num.toString().length < 8) {
      setState(() {
        error = "Please Enter Contact Number";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Contact Number" ,
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if (gender == null || gender == "") {
      setState(() {
        error = "Please Select Gender";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Select Gender",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if (dob == null || dob == "") {
      setState(() {
        error = "Please Enter Your Date of Birth";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Date of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    }else if (selectedhours == "Hours") {
      setState(() {
        error = "";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Select Time of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if (gender == "male" && duration.years < 21) {
      setState(() {
        error = "Age must be greater than 21";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Age Must be \n Greater than 21",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if (gender == "female" && duration.years < 18) {
      setState(() {
        error = "";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Age must be \n greater than 18",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if(selectedhours=="Hours" || selectedminutes=="Minutes"){
setState(() {
        error = "";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter the Time of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    } else if( birthPlaceController.text.isEmpty){
     setState(() {
        error = "";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Select Place of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }); 
    }else if (dob == null || dob == "") {
      setState(() {
        error = "Please Enter Your Date of Birth";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Date of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      });
    }  else   if(!landmarkssug.contains(birthPlaceController.text)){
                            setState(() {
        error = "";
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Please Enter Valid Place of Birth",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }); 
    }
    else {
       SearchProfile().addtoadminnotification(userid: "12324", useremail:userSave.email!, userimage:"", 
  title: "${userSave.displayName} TRIED TO CREATE PROFILE WITH ${User_email}", email: userSave.email!, subtitle: "");
      setState(() {
        color_done2 = true;
        error = "";
      });
      print(age);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Religion(User_Name: User_Name, User_SurName: User_SurName, age: age!,
     timeofbirth: "$selectedhours:$selectedminutes $selectedampm", phone_num: phone_num, placeofbirth: birthPlaceController.text, gender: gender, dob:dob_timestamp!, email: User_email),));
//   UserService().createappuser(aboutme: "",
//  diet: "'", disability: "'",
//  context: context,
//   drink: "'", education: "'",
//    height: "3.0 Feet", income: "'",

//     patnerprefs: "", smoke: "'",
//      displayname: User_Name, email: User_email,
//       religion: "'", name: User_Name, surname: User_SurName,
//        phone:phone_num , gender: gender, kundalidosh: "",
//         martialstatus: "'", profession: "'",
//          location: "", city: "", state: "",
//           imageurls: [], blocklists: [],
      
//            reportlist: [], shortlist: [],
//             country: "", token: "'", age: "'", lat: 33.5471303,
//              lng: 68.4221352, timeofbirth: "$selectedhours:$selectedminutes $selectedampm", placeofbirth: birthPlaceController.text, 
//              puid: "'", dob: 32323).whenComplete((){

//              });
     
                
    }
  }
   late ScrollController _scrollController;
    TextEditingController birthPlaceController = TextEditingController();
      final _searchController = TextEditingController();
      String? location;
  //   List<Prediction> _predictions = [];
  //     var height_suggest1 = 0.0;
       List<String> landmarkssug=[];
  //  GoogleMapsPlaces _places =
  //     GoogleMapsPlaces(apiKey: 'AIzaSyBgldLriecKqG8pYkQIUX5CI72rUREhIrQ');
  //      void _onSelectedPlace(Prediction prediction) async {
  //   var placeDetail = await _places.getDetailsByPlaceId(prediction.placeId!);
 

  //   // TODO: Use the lat/lng to display the selected place on the map or save it to your database
  //   if (!mounted) return;
  //   setState(() {
  //     _searchController.text = prediction.description!;
  //     location = prediction.description!;
  //     birthPlaceController.text = location!;
  //     _predictions.clear();
  //     // landmarkssug.clear();
  //   });
  // }
// void _onSearchChanged(String value) async {
//     if (value.isNotEmpty) {
//       var response = await _places.autocomplete(value);
//       if (!mounted) return;
//       setState(() {
//         _predictions = response.predictions;
//         height_suggest1 = 200;
//       });
//       for (var i = 0; i < _predictions.length; i++) {
//         landmarkssug.add(_predictions[i].description!);
//       }
//       setState(() {
        
//       });
//     }
//   }
  @override
  Widget build(BuildContext context) {
    // setState(() {
    // print(male_gender);
    if (male_gender == true) {
      setState(() {
        gender = "male";
      });
    } else if (female_gender == true) {
      setState(() {
        gender = "female";
      });
    }
    // });
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          key: scaffoldKey,
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
            // actionsForegroundColor: Colors.white,
            title: Row(
              children: [
                // Icon(Icons.arrow_back_ios_new),
                Container(
                  margin: EdgeInsets.only(right: 150),
                  child: Text(
                    "Let's Start",
                    style: TextStyle(fontSize: 24, color: main_color),
                  ),
                ),
              ],
            ),
         
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                
                  // DefaultTextStyle(
                  //     style: GoogleFonts.poppins(
                  //         color: Colors.black,
                  //         fontSize: 40,
                  //         fontWeight: FontWeight.bold),
                  //     child: Container(
                  //         padding: EdgeInsets.only(left: 20),
                  //         alignment: Alignment.centerLeft,
                  //         child: Text(
                  //           "Let's Start",
                  //           style: TextStyle(fontSize: 24),
                  //         ))),
              
                  //namesubmission
                  
                  Card(
                      elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      height: 50,
                      child: CupertinoTextField(
                        // height: 20.0,
                        maxLength: 12,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), // Allow only alphabets
                        ],
                        maxLengthEnforcement:
                            MaxLengthEnforcement.enforced, // show error message
                        // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                        placeholder: "Enter Name",
                        focusNode: _focusNode1,
                        controller: name,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _focusNode1.hasFocus
                                ? main_color
                                : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (name) => {
                          setState(() {
                            this.User_Name = name;
                          })
                        },
                      ),
                    ),
                  ),
                 
                  // Card(
                  //   elevation: 4,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(30)),
                  //   child: TextFormField(
                  //     // controller: namecontroller,
                  //     textInputAction: TextInputAction.next,
                  //     keyboardType: TextInputType.name,
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "Enter your name";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: const InputDecoration(
                  //         hintText: "Groom's Name",
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.all(20)),
                  //   ),
                  // ),
              
                  Card(
                      elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      height: 50,
                      child: CupertinoTextField(
                        maxLength: 12,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), // Allow only alphabets
                        ],
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        placeholder: "Enter Surname",
                        focusNode: _focusNode2,
                        controller: surname,
                        
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _focusNode2.hasFocus
                                ? main_color
                                : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (surname) => {
                          setState(() {
                            this.User_SurName = surname;
                          })
                        },
                      ),
                    ),
                  ),
                  Card(
                      elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      height: 50,
                      child: CupertinoTextField(
                        // height: 20.0,
                        maxLength: 100,
                        //               inputFormatters: [
                        //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), // Allow only alphabets
                        // ],
                        maxLengthEnforcement:
                            MaxLengthEnforcement.enforced, // show error message
                        // maxLengthEnforcedMessage: 'You have reached the maximum character limit of 50',
                        placeholder: "Enter Email ID",
                        focusNode: _focusNode3,
                        controller: useremail,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _focusNode3.hasFocus
                                ? main_color
                                : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (name) => {
                          setState(() {
                            this.User_email = name;
                          })
                        },
                      ),
                    ),
                  ),
                
                   Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Container(
                              child: IntlPhoneField(
                            focusNode: _focusNode,
                            flagsButtonPadding:
                                const EdgeInsets.only(top: 20, bottom: 0),
                            controller: Phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          
                            decoration: InputDecoration(
                              focusColor: main_color,
                              hoverColor: main_color,
                          
                              //decoration for Input Field
                              contentPadding: EdgeInsets.only(
                                top: 25,
                                left: 20,
                                right: 20,
                              ),
                              // labelText: 'Phone Number',
                          
                              hintText: "Enter Contact Number",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              errorStyle: TextStyle(
                                // Add padding to the error text
                          
                                // You can also customize the text style as needed
                                color: Colors.red, // Error text color
                                fontSize: 14.0, // Error text font size
                              ),
                              // border: OutlineInputBorder(
                              //     borderSide: BorderSide(color: main_color),
                              //     borderRadius: BorderRadius.circular(60)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: main_color),
                              //     borderRadius: BorderRadius.circular(60)),
                            ),
                            // validator: (p0) {
                          
                            // },
                            onCountryChanged: (value) {
                              phone_num = "";
                              Phone.clear();
                              print(phone_num);
                              setState(() {});
                            },
                            initialCountryCode:
                                'IN', //default contry code, NP for Nepal
                            onChanged: (phone) {
                              //when phone number country code is changed
                              // print(phone.completeNumber); //get complete number
                              // print(phone.countryCode); // get country code only
                              // print(phone.number); // only phone number
                          
                              setState(() {
                                phone_num = phone.countryCode + phone.number;
                               
                              });
                            },
                            onSubmitted: (phone_num) =>
                                print('Submitted $phone_num'),
                          )),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 46,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                  _focusNode.unfocus();
                                setState(() {
                                  male_gender = !male_gender;
                                  female_gender = false;
                                  if (!male_gender) {
                                    gender = "";
                                  }
                                });
                              },
                              style: male_gender
                                  ? ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: BorderSide(
                                                  color: main_color))),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.white))
                                  : ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(Colors.white)),
                              child: Text("Male",
                                  style: TextStyle(
                                    fontFamily: 'Sans-serif',
                                    fontWeight: FontWeight.w400,
                                    color:
                                        male_gender ? main_color : textColor,
                                    fontSize: 14,
                                  ))),
                        ),
                        SizedBox(
                          width: 150,
                          height: 46,
                          child: ElevatedButton(
                              onPressed: () {
                  _focusNode.unfocus();
                                setState(() {
                                  female_gender = !female_gender;
                                  male_gender = false;
                                  if (!female_gender) {
                                    gender = "";
                                  }
                                });
                              },
                              style: female_gender
                                  ? ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: BorderSide(
                                                  color: main_color))),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.white))
                                  : ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(Colors.white)),
                              child: Text("Female",
                                  style: TextStyle(
                                    fontFamily: 'Sans-serif',
                                    fontWeight: FontWeight.w400,
                                    color: female_gender
                                        ? main_color
                                        : textColor,
                                    fontSize: 14,
                                  ))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Date Of Birth",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              fontFamily: 'Sans-serif',
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // (gender == "male")
                  //     ? Calender(
                  //         useTwentyOneYears: male_gender,
                  //         setdate: updateMaleDate,
                  //       )
                  //     :
                  Calender(
                    useTwentyOneYears: male_gender,
                    setdate: updateMaleDate,
                  ),
              
                  DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: 'Sans-serif',
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      child: Text("$dob")),
                 
                
               Container(
                    margin: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Time Of Birth",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              fontFamily: 'Sans-serif',
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                height: 46,
                width: MediaQuery.of(context).size.width * 0.29,
                child: Center(
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.center,
                    underline: Container(
                      color: Colors.white,
                    ),
                    value: selectedhours,
                    items: hours.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: textColor),),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedhours = newValue!;
                        // _updateDaysInMonth();
                      });
                    },
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
                width: MediaQuery.of(context).size.width * 0.29,
                child: Center(
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.center,
                    underline: Container(
                      color: Colors.white,
                    ),
                    value: selectedminutes,
                    items: minutes.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: textColor),),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedminutes = newValue!;
                        // _updateDaysInMonth();
                      });
                    },
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
                width: MediaQuery.of(context).size.width * 0.29,
                child: Center(
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.center,
                    underline: Container(
                      color: Colors.white,
                    ),
                    value: selectedampm,
                    items: ampm.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: textColor),),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedampm = newValue!;
                        // _updateDaysInMonth();
                      });
                    },
                  ),
                ),
              ),
                          ),
              ],
                  ),
                  SizedBox(height: 5,),
                 Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  controller: birthPlaceController,

                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    // _onSearchChanged(value);
                                    _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.easeOut,
              );
                                  },
                                  onTap: () {
                                    print("hello");
                                    _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.easeOut,
              );
                          
                                  },
                                  focusNode: _focusNode4,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     setState(() {
                                  //       height_suggest1 = 0.0;
                                  //     });
                                  //     return "Enter your name";
                                  //   }
                                  //   return location;
                                  // },
                                  decoration: const InputDecoration(
                                      hintText: "Enter Place Of Birth",
                                       hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                      ),
                            // Stack(
                            //   children: [
                            //     SizedBox(height: 1),
                            //     Container(
                            //       height: height_suggest1,
                            //       child: Card(
                            //         child: ListView.builder(
                            //           padding: EdgeInsets.zero,
                            //           itemCount: _predictions.length,
                            //           itemBuilder: (context, index) {
                            //             return SingleChildScrollView(
                            //               child: ListTile(
                            //                   title: Text(_predictions[index]
                            //                       .description!),
                            //                   onTap: () {
                            //                     _onSelectedPlace(
                            //                         _predictions[index]);
                            //                     if (!mounted) return;
                            //                     setState(() {
                            //                       height_suggest1 = 0.0;
                            //                     });
                            //                   }),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                   const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                    EdgeInsets.symmetric(vertical: 17)),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        side: BorderSide(
                                          color: (color_done2 == false)
                                              ? Colors.white
                                              : main_color,
                                        ))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          onpressed();
                        },
                        child: Text(
                          "Register",
                          style: (color_done2 == false)
                              ? TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Serif')
                              : TextStyle(
                                  color: main_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Serif'),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
              
                  // Text(
                  //   error,
                  //   textAlign: TextAlign.center,
                  //   style: const TextStyle(
                  //       decoration: TextDecoration.none,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       fontFamily: 'Sans-serif',
                  //       color: Colors.black),
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  bool color_done2 = false;
  DateDuration? PickedDate;
}
