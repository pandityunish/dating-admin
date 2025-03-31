import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_webservice/places.dart';
import '../../Assets/Error.dart';
// import 'package:csc_picker/csc_picker.dart';
// import '../../Assets/G_Sign.dart';
// import '../../models/shared_pref.dart';
// import '../../models/user_model.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  Position? _currentPosition;
  String? _currentAddress;
  List<String> location = [];
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController _searchController = TextEditingController();
  // GoogleMapsPlaces _places =
  //     GoogleMapsPlaces(apiKey: 'AIzaSyCY0Kuh0x5rOk2yKXejCwEBMcbciJyH5cc');

  // List<Prediction> _predictions = [];

  @override
  Widget build(BuildContext context) {
    // void _onSearchChanged(String value) async {
    //   if (value.isNotEmpty) {
    //     var response = await _places.autocomplete(value);
    //     setState(() {
    //       _predictions = response.predictions;
    //     });
    //   }
    // }

    // void _onSelectedPlace(Prediction prediction) async {
    //   var placeDetail = await _places.getDetailsByPlaceId(prediction.placeId!);
    //   var lat = placeDetail.result.geometry?.location.lat;
    //   var lng = placeDetail.result.geometry?.location.lng;

    //   // TODO: Use the lat/lng to display the selected place on the map or save it to your database

    //   setState(() {
    //     // _searchController.text = prediction.description!;
    //     _searchController.text = "";
    //     location.add(prediction.description!);
    //     _predictions.clear();
    //   });
    // }

    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

    bool color_done2 = false;
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage('images/icons/location_home.png'),
              size: 25,
              color: main_color,
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              // margin: EdgeInsets.only(right: 12),
              child: DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sans-serif',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                  child: Text("Location")),
            )
          ],
        ),
        previousPageTitle: "",
      ),
      // child: Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height,
      //   child: SingleChildScrollView(
      //     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
      //         Widget>[
      //       SafeArea(
      //         child: SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height * 0.4,
      //           child: Material(
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 40,
      //                 ),
      //                 Container(
      //                   width: MediaQuery.of(context).size.width * 0.8,
      //                   decoration: BoxDecoration(
      //                       color: Colors.black12,
      //                       borderRadius: BorderRadius.circular(10)),
      //                   child: TextField(
      //                     controller: _searchController,
      //                     decoration: InputDecoration(
      //                         hintText: 'Search for location',
      //                         prefixIcon: Icon(
      //                           Icons.search,
      //                           color: main_color,
      //                         ),
      //                         border: InputBorder.none),
      //                     onChanged: (value) => _onSearchChanged(value),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: ListView.builder(
      //                     itemCount: _predictions.length,
      //                     itemBuilder: (context, index) {
      //                       return ListTile(
      //                           title: Text(_predictions[index].description!),
      //                           onTap: () {
      //                             _onSelectedPlace(_predictions[index]);
      //                           });
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       if (location.isNotEmpty)
      //         Material(
      //           child: Container(
      //             height: 200,
      //             child: ListView.builder(
      //               itemCount: location.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: Center(
      //                     child: Container(
      //                         height: 62,
      //                         width: 380,
      //                         decoration: BoxDecoration(
      //                             color: Colors.white,
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(10)),
      //                             //   border: Border.all(color: Colors.black),
      //                             boxShadow: [
      //                               BoxShadow(
      //                                   color: Colors.black, blurRadius: 2),
      //                             ]),
      //                         child: Container(
      //                           child: SingleChildScrollView(
      //                             scrollDirection: Axis.horizontal,
      //                             child: Row(
      //                               children: [
      //                                 SizedBox(
      //                                   width: 10,
      //                                 ),
      //                                 ImageIcon(
      //                                   AssetImage(
      //                                       'images/icons/location_home.png'),
      //                                   size: 25,
      //                                   color: main_color,
      //                                 ),
      //                                 SizedBox(
      //                                   width: 20,
      //                                 ),
      //                                 Text(location[index]),
      //                               ],
      //                             ),
      //                           ),
      //                         )),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ),
      //       SizedBox(
      //         height: 120,
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 15),
      //         width: MediaQuery.of(context).size.width * 0.9,
      //         child: ElevatedButton(
      //           style: ButtonStyle(
      //               shadowColor: MaterialStateColor.resolveWith(
      //                   (states) => Colors.black),
      //               padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
      //                   EdgeInsets.symmetric(vertical: 17)),
      //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(60.0),
      //                       side: BorderSide(
      //                         color: (color_done2 == false)
      //                             ? Colors.white
      //                             : main_color,
      //                       ))),
      //               backgroundColor:
      //                   MaterialStateProperty.all<Color>(Colors.white)),
      //           onPressed: () {
      //             if (location != null && location != "") {
      //               setState(() {
      //                 color_done2 = true;
      //               });

      //               Navigator.of(context).pop(location);
      //             } else {
      //               showDialog(
      //                   context: context,
      //                   builder: (context) {
      //                     return const AlertDialog(
      //                       content: SnackBarContent(
      //                         error_text:
      //                             "Please Provide Your \n Living Address",
      //                         appreciation: "",
      //                         icon: Icons.error_outline_outlined,
      //                         sec: 2,
      //                       ),
      //                       backgroundColor: Colors.transparent,
      //                       elevation: 0,
      //                     );
      //                   });
      //             }
      //           },
      //           child: Text(
      //             "Continue",
      //             style: (color_done2 == false)
      //                 ? TextStyle(
      //                     color: Colors.black,
      //                     fontSize: 20,
      //                     fontFamily: 'Serif',
      //                     fontWeight: FontWeight.w700)
      //                 : TextStyle(
      //                     color: main_color,
      //                     fontSize: 20,
      //                     fontFamily: 'Serif',
      //                     fontWeight: FontWeight.w700),
      //           ),
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
      child: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: Column(
              children: [
                ///Adding CSC Picker Widget in app
                // CSCPicker(
                //   ///Enable disable state dropdown [OPTIONAL PARAMETER]
                //   // showStates: true,

                //   /// Enable disable city drop down [OPTIONAL PARAMETER]
                //   // showCities: true,

                //   ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                //   // flagState: CountryFlag.DISABLE,

                //   ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                //   dropdownDecoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.white,
                //       border:
                //           Border.all(color: Colors.grey.shade300, width: 1)),

                //   ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                //   disabledDropdownDecoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.grey.shade300,
                //       border:
                //           Border.all(color: Colors.grey.shade300, width: 1)),

                //   ///placeholders for dropdown search field
                //   countrySearchPlaceholder: "Country",
                //   stateSearchPlaceholder: "State",
                //   citySearchPlaceholder: "City",

                //   ///labels for dropdown
                //   countryDropdownLabel: "Country",
                //   stateDropdownLabel: "State",
                //   cityDropdownLabel: "City",

                //   ///Default Country
                //   ///defaultCountry: CscCountry.India,

                //   ///Country Filter [OPTIONAL PARAMETER]
                //   // countryFilter: [
                //   //   CscCountry.India,
                //   //   CscCountry.United_States,
                //   //   CscCountry.Canada
                //   // ],

                //   ///Disable country dropdown (Note: use it with default country)
                //   //disableCountry: true,

                //   ///selected item style [OPTIONAL PARAMETER]
                //   selectedItemStyle: TextStyle(
                //     color: Colors.black,
                //     fontSize: 14,
                //   ),

                //   ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                //   dropdownHeadingStyle: TextStyle(
                //       color: Colors.black,
                //       fontSize: 17,
                //       fontWeight: FontWeight.bold),

                //   ///DropdownDialog Item style [OPTIONAL PARAMETER]
                //   dropdownItemStyle: TextStyle(
                //     color: Colors.black,
                //     fontSize: 14,
                //   ),

                //   ///Dialog box radius [OPTIONAL PARAMETER]
                //   dropdownDialogRadius: 10.0,

                //   ///Search bar radius [OPTIONAL PARAMETER]
                //   searchBarRadius: 10.0,

                //   ///triggers once country selected in dropdown
                //   onCountryChanged: (value) {
                //     setState(() {
                //       ///store value in country variable
                //       countryValue = value;
                //     });
                //   },

                //   ///triggers once state selected in dropdown
                //   onStateChanged: (value) {
                //     setState(() {
                //       ///store value in state variable
                //       stateValue = value!;
                //     });
                //   },

                //   ///triggers once city selected in dropdown
                //   onCityChanged: (value) {
                //     setState(() {
                //       ///store value in city variable
                //       cityValue = value!;
                //     });
                //   },

                //   ///Show only specific countries using country filter
                //   // countryFilter: ["United States", "Canada", "Mexico"],
                // ),
                //       CSCPicker(
                //         layout: Layout.vertical,
                //         //flagState: CountryFlag.DISABLE,
                //         onCountryChanged: (country) {
                //           print(country);
                //         },
                //         onStateChanged: (state) {
                //           print(state);
                //         },
                //         onCityChanged: (city) {
                //           print(city);
                //         },
                //         /* countryDropdownLabel: "*Country",
                // stateDropdownLabel: "*State",
                // cityDropdownLabel: "*City",*/
                //         //dropdownDialogRadius: 30,
                //         //searchBarRadius: 30,
                //       ),

                ///print newly selected country state and city in Text Widget
                TextButton(
                    onPressed: () {
                      setState(() {
                        address = "$cityValue, $stateValue, $countryValue";
                      });
                    },
                    child: Text("Print Data")),
                Text(address),
              ],
            )),
      ),
    );
  }
}
// dynamic setData() async {
//   SharedPref sharedPref = SharedPref();
//   final json2 = await sharedPref.read("uid");
//   var uid = json2['uid'];
//   print(location);
//   final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
//   try {
//     User? userSave = User.fromJson(await sharedPref.read("user"));
//     print(userSave.toString());

//     userSave.Location = location;
//     // print(userSave.toJson().toString());
//     final json = userSave.toJson();
//     await sharedPref.save("user", userSave);
//     await docUser.update(json).catchError((error) => print(error));
//   } catch (Excepetion) {
//     print(Excepetion);
//   }
// }
