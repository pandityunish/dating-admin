import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_string/json_string.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony_admin/screens/navigation/admin_options/Charts/numerical_data.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/Charts/user_demographic.dart';
import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';

import '../../../../Assets/ayushWidget/big_text.dart';

class UserNumerical extends StatefulWidget {
  final String title;
  const UserNumerical({super.key, required this.title});

  @override
  State<UserNumerical> createState() => _UserNumericalState();
}

class _UserNumericalState extends State<UserNumerical> {
  @override
  void initState() {
    getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;
  getUserDetails() async {
    try {
      http.Response res = await http.get(
        Uri.parse(getAllUsersData),
        headers: {'Content-Type': 'Application/json'},
      );
      // print(jsonDecode(res.body));
      final json = JsonString(res.body.toString());
      // print(json.decodedValueAsList.length);
      generateValues(json.decodedValueAsList);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<dynamic, int> genderCounts = {};
  Map<dynamic, int> realCountryCodeList = {};
  Map<dynamic, int> birthYearList = {};
  Map<dynamic, int> religionList = {};
  Map<dynamic, int> kundaliDoshList = {};
  Map<dynamic, int> maritialStatusList = {};
  Map<dynamic, int> dietList = {};
  Map<dynamic, int> drinkList = {};
  Map<dynamic, int> smokeList = {};
  Map<dynamic, int> disabilityList = {};
  Map<dynamic, int> heightList = {};
  Map<dynamic, int> educationList = {};
  Map<dynamic, int> professionList = {};
  Map<dynamic, int> annualIncomeList = {};
  Map<dynamic, int> countryList = {};
  Map<dynamic, int> stateList = {};
  Map<dynamic, int> cityList = {};
  Map<dynamic, int> aboutMeList = {};
  Map<dynamic, int> aboutPartnerList = {};
  Map<dynamic, int> profilePicList = {};
  Map<dynamic, int> numPicList = {};

  generateValues(List<dynamic> data) async {
    final genderList = [];
    final tempList = [];
    final tempBirthList = [];
    final tempReligionList = [];
    final tempKundaliList = [];
    final tempMaritialStatusList = [];
    final tempDietList = [];
    final tempDrinkList = [];
    final tempSmokeList = [];
    final tempDisabilityList = [];
    final tempHeightList = [];
    final tempEducationList = [];
    final tempProfessionList = [];
    final tempAnnualIncomeList = [];
    final tempCountryList = [];
    final tempStateList = [];
    final tempCityList = [];
    final tempAboutMeList = [];
    final tempAboutPartnerList = [];
    final tempProfilePicList = [];
    final tempNumPicList = [];

    for (var item in data) {
      genderList.add(item['gender']);
    }
    for (var item in data) {
      tempList.add(item['country']);
    }
    for (var item in data) {
      final date = DateTime.fromMillisecondsSinceEpoch(item['dob']);
      tempBirthList.add(date.year.toString());
    }
    for (var item in data) {
      tempReligionList.add(item['religion']);
    }
    for (var item in data) {
      tempKundaliList.add(item['kundalidosh']);
    }
    for (var item in data) {
      tempMaritialStatusList.add(item['martialstatus']);
    }
    for (var item in data) {
      tempDietList.add(item['diet']);
    }
    for (var item in data) {
      tempDrinkList.add(item['drink']);
    }
    for (var item in data) {
      tempSmokeList.add(item['smoke']);
    }
    for (var item in data) {
      tempDisabilityList.add(item['disability']);
    }
    for (var item in data) {
      tempHeightList.add(item['height']);
    }

    for (var item in data) {
      tempEducationList.add(item['education']);
    }
    for (var item in data) {
      tempProfessionList.add(item['profession']);
    }
    for (var item in data) {
      tempAnnualIncomeList.add(item['income']);
    }
    for (var item in data) {
      tempCountryList.add(item['country']);
    }
    for (var item in data) {
      tempStateList.add(item['state']);
    }

    for (var item in data) {
      tempCityList.add(item['city']);
    }
    for (var item in data) {
      tempAboutMeList.add(item['aboutme']);
    }
    for (var item in data) {
      tempAboutPartnerList.add(item['patnerprefs']);
    }
    for (var item in data) {
      tempProfilePicList.add(item['imageurls']);
    }

    setState(() {
      genderCounts = countItems(genderList);
      realCountryCodeList = countItems(tempList);
      birthYearList = countItems(tempBirthList);
      religionList = countItems(tempReligionList);
      kundaliDoshList = countItems(tempKundaliList);
      maritialStatusList = countItems(tempMaritialStatusList);
      dietList = countItems(tempDietList);
      drinkList = countItems(tempDrinkList);
      smokeList = countItems(tempSmokeList);
      disabilityList = countItems(tempDisabilityList);
      heightList = countItems(tempHeightList);
      educationList = countItems(tempEducationList);
      professionList = countItems(tempProfessionList);
      annualIncomeList = countItems(tempAnnualIncomeList);
      countryList = countItems(tempCountryList);
      stateList = countItems(tempStateList);
      cityList = countItems(tempCityList);
      aboutMeList = countItems(tempAboutMeList);
      aboutPartnerList = countItems(tempAboutPartnerList);
      // profilePicList = countItems(tempProfilePicList);
    });

    // print("yo hamro religion ko info ${religionList}");
  }

  Map<dynamic, int> countItems(List<dynamic> list) {
    // Create an empty map to store the counts
    final Map<String, int> itemCount = {};

    // Iterate through the list
    for (var item in list) {
      // If the item is already in the map, increment its count
      if (itemCount.containsKey(item)) {
        itemCount[item] = itemCount[item]! + 1;
      } else {
        // If the item is not in the map, add it with a count of 1
        itemCount[item] = 1;
      }
    }

    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
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
          title: Row(
            children: [
              BigText(
                text: widget.title,
                size: 20,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          // trailing: const Icon(Icons.calendar_month),
          // previousPageTitle: "",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: userNumericalData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (userNumericalData[index] == "GENDER") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Gender",
                                    data: genderCounts,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${genderCounts.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 25,
                          thickness: 1,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "COUNTRY CODE") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Country Code",
                                    data: realCountryCodeList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${realCountryCodeList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 25,
                          thickness: 1,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "BIRTH YEAR") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Birth Year",
                                    data: birthYearList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${birthYearList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "RELIGION PROFILES") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Religion",
                                    data: religionList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${religionList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "MARITAL STATUS") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Marital Status",
                                    data: maritialStatusList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${maritialStatusList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "KUNDLI DOSH") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Kundli Dosh",
                                    data: kundaliDoshList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${kundaliDoshList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "DIET") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: dietList,
                                    title: "Diet",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${dietList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "DRINK") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: drinkList,
                                    title: "Drink",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${drinkList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "SMOKE") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: smokeList,
                                    title: "Smoke",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${smokeList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "DISABILITY") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: disabilityList,
                                    title: "Disability",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${disabilityList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "HEIGHT") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: heightList,
                                    title: "Height",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${heightList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "EDUCATION") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: educationList,
                                    title: "Education",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${educationList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "PROFESSION") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Proferssion",
                                    data: professionList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${professionList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "ANNUAL INCOME") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: annualIncomeList,
                                    title: "Annual Income",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${annualIncomeList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "COUNTRY") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Country",
                                    data: countryList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${countryList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "STATE") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "State",
                                    data: stateList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${stateList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "CITY") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "City",
                                    data: cityList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${cityList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "ABOUT ME") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "About Me",
                                    data: aboutMeList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${aboutMeList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] ==
                      "ABOUT PARTNER PREFERENCE") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    title: "Patner Preference",
                                    data: aboutPartnerList,
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${aboutPartnerList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "PROFILE PIC") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: profilePicList,
                                    title: "Profile Pic",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${profilePicList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "NUMBER OF PICS") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: profilePicList,
                                    title: "Pic",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${profilePicList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "PROFILE PIC") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: profilePicList,
                                    title: "Profile Pic",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${profilePicList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  } else if (userNumericalData[index] == "APP STORE") {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.title == "User Numerical Charts") {
                                  Get.to(NumericalData(
                                    data: profilePicList,
                                    title: "App Store",
                                  ));
                                } else {
                                  Get.to(const UserDemographic());
                                }
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Get.width * 0.9,
                                  child: Text(
                                    " ${userNumericalData[index]} (${profilePicList.length})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 25,
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
