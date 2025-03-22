import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/data_collection/aboutMe.dart';
import 'package:matrimony_admin/screens/service/auth_service.dart';
import '../../Assets/Error.dart';
import '../../Assets/G_Sign.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'custom_app_bar.dart';

String? location;

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
  // Position? position;
}

class _LocationState extends State<Location> {
  Position? _currentPosition;
  String? _currentAddress;

  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  var lat;
  var lng;
  bool locate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _searchController = TextEditingController();
  // GoogleMapsPlaces _places =
  //     GoogleMapsPlaces(apiKey: 'AIzaSyBgldLriecKqG8pYkQIUX5CI72rUREhIrQ');

  // List<Prediction> _predictions = [];
  UserService userService = Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    // void _onSearchChanged(String value) async {
    //   lng = "";
    //   lat = "";
    //   print(value);
    //   // print(_places.searchByText(value));
    //   var res = await _places.searchByText(value);
    //   print(res.results.length);
    //   if (value.isNotEmpty) {
    //     var response = await _places.autocomplete(value, types: ["(cities)"]);
    //     setState(() {
    //       _predictions = response.predictions;
    //     });
    //     print(response.predictions);
    //   }
    // }

    // void _onSelectedPlace(Prediction prediction) async {
    //   print(prediction.description);
    //   var placeDetail = await _places.getDetailsByPlaceId(prediction.placeId!);
    //   lat = placeDetail.result.geometry?.location.lat;
    //   lng = placeDetail.result.geometry?.location.lng;

    //   // TODO: Use the lat/lng to display the selected place on the map or save it to your database

    //   setState(() {
    //     _searchController.text = prediction.description!;
    //     location = prediction.description;
    //     try {
    //       city = prediction.structuredFormatting!.mainText;
    //       state = prediction.structuredFormatting!.secondaryText
    //           .toString()
    //           .split(',')[0];
    //       country = (prediction.structuredFormatting!.secondaryText
    //                   .toString()
    //                   .split(',')[prediction.structuredFormatting!.secondaryText
    //                           .toString()
    //                           .split(',')
    //                           .length -
    //                       1]
    //                   .split(" ")[0] !=
    //               " ")
    //           ? state
    //           : prediction.structuredFormatting!.secondaryText
    //               .toString()
    //               .split(',')[prediction.structuredFormatting!.secondaryText
    //                       .toString()
    //                       .split(',')
    //                       .length -
    //                   1]
    //               .split(" ")[1];

    //       FocusManager.instance.primaryFocus?.unfocus();
    //     } catch (e) {
    //       print(e);
    //     }
    //     // print(prediction.structuredFormatting!.secondaryText);
    //     // setData();
    //     // setData();
    //     List<String> parts = prediction.description!.split(RegExp(r'[,\s]+'));
    //     String lastWord = parts.last;
    //     print(lastWord);
    //     userService.userdata.addAll({
    //       "location": location,
    //       "state": state,
    //       "country": lastWord,
    //       "city": city,
    //       "lat": lat,
    //       "lng": lng
    //     });

    //     _predictions.clear();
    //   });
    // }

    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

    bool color_done2 = false;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBar(title: "I Live In", iconImage: 'images/icons/location_home.png'), 
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      SafeArea(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.9,
                                    height: 43,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                      hintText: 'Search for location',
                                      contentPadding: EdgeInsets.only(top: 10),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: main_color,
                                      ),
                                      border: InputBorder.none),
                                  onChanged: (value) {}
                                      // _onSearchChanged(value),
                                ),
                              ),
                              // Expanded(
                              //   child: ListView.builder(
                              //     itemCount: _predictions.length,
                              //     itemBuilder: (context, index) {
                              //       return ListTile(
                              //           title: Text(
                              //               _predictions[index].description!),
                              //           onTap: () {
                              //             _onSelectedPlace(
                              //                 _predictions[index]);
                              //           });
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      (locate)
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(main_color),
                              color: main_color,
                            )
                          : (_currentAddress != null)
                              ? Text(_currentAddress!,
                                  style: TextStyle(
                                      fontFamily: 'Sans-serif',
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontSize: 20))
                              : Container(),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: 300,
                  //   child: ElevatedButton(
                  //       child: Text(
                  //         "Enable location",
                  //         style: TextStyle(color: Colors.black, fontSize: 16),
                  //       ),
                  //       onPressed: () async {
                  //         setState(() {
                  //           locate = true;
                  //         });
                  //         setState(() async {
                  //           _currentAddress = await getLocation();
                  //           locate = false;
                  //         });

                  //         setData();
                  //       },
                  //       style: ButtonStyle(
                  //           shape: MaterialStateProperty.all<
                  //               RoundedRectangleBorder>(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //             // side: BorderSide(color: main_color),
                  //           )),
                  //           backgroundColor: MaterialStateProperty.all<Color>(
                  //               Colors.white))),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
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
                                    EdgeInsets.symmetric(vertical: 15)),
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
                          if ((lng != null && lng != "")) {
                            setState(() {
                              color_done2 = true;
                            });
                            print(state);
                            // userService.userdata.addAll({"location":location,"state":state,"country":country,"city":city,"lat":lat,"lng":lng});
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 0),
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 0),
                                    pageBuilder: (_, __, ___) => AboutMe()));
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: SnackBarContent(
                                      error_text:
                                          "Please Provide Your \n Living Address",
                                      appreciation: "",
                                      icon: Icons.error,
                                      sec: 2,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                });
                          }
                        },
                        child: Text(
                          "Continue",
                          style: (color_done2 == false)
                              ? TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Serif',
                                  fontWeight: FontWeight.w700)
                              : TextStyle(
                                  color: main_color,
                                  fontSize: 20,
                                  fontFamily: 'Serif',
                                  fontWeight: FontWeight.w700),
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  // Future<Position> getLocation() async {
  //   // Check if location services are enabled
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled, throw an error
  //     throw 'Location services are disabled.';
  //   }
  //   // Get the current position
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   setState(() {
  //     _currentPosition = position;
  //   });
  //   _getAddressFromLatLng();
  //   return position;
  // }

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition!.latitude, _currentPosition!.longitude);

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //       location = _currentAddress;
  //       setData();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  String? country, state, city;

  Future<String> getLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, throw an error
      throw 'Location services are disabled.';
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat = position.latitude;
    lng = position.longitude;
    // Get the address from latitude and longitude
    List<Placemark>? placemarks = await GeocodingPlatform.instance
        ?.placemarkFromCoordinates(position.latitude, position.longitude);

    country = "${placemarks![0].country}";
    state = "${placemarks[0].administrativeArea}";
    city = "${placemarks[0].locality}";
    print(placemarks);
    // Extract the area name from the address
    String areaName =
        "${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}";
    setState(() {
      location = areaName;
      setData();
    });
    List<String> parts = country!.split(RegExp(r'[,\s]+'));
    String lastWord = parts.last;

    userService.userdata.addAll({
      "location": location,
      "state": state,
      "country": lastWord,
      "city": city,
      "lat": lat,
      "lng": lng
    });
    return areaName;
  }

  dynamic setData() async {
    SharedPref sharedPref = SharedPref();
    final json2 = await sharedPref.read("uid");
    var uid = json2?['uid'];
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
    try {
      User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
      userSave.Location = location;
      userSave.longitude = lng;
      userSave.latitude = lat;
      userSave.city = city;
      userSave.state = state;
      userSave.country = country;
      final json = userSave.toJson();
      await sharedPref.save("user", userSave);
      await docUser.update(json).catchError((error) => print(error));
    } catch (Excepetion) {
      print(Excepetion);
    }
  }
}

// dynamic setData() async{
//   print(location);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid);

//   final json = {
//     'Location': location,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }

