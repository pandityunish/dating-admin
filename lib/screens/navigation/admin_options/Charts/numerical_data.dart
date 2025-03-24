import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';

import '../../../../Assets/ayushWidget/big_text.dart';

class NumericalData extends StatefulWidget {
  final Map<dynamic, int> data;
  final String? title;
  const NumericalData({super.key, required this.data, this.title});

  @override
  State<NumericalData> createState() => _NumericalDataState();
}

class _NumericalDataState extends State<NumericalData> {
  List<CountryDetails> countryList = [];

  getCountryCodesNow() async {
    await CountryCodes.init();
    setState(() {
      countryList = CountryCodes.countryCodes();
    });
  }

  @override
  void initState() {
    getCountryCodesNow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Convert Map to List and Sort Alphabetically by Country Name
    final realData = widget.data.entries.toList()
      ..sort((a, b) => a.key.toString().compareTo(b.key.toString()));

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
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
          middle: Row(
            children: [
              BigText(
                text: "User ${widget.title} Numerical Chart",
                size: 16,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          trailing: Icon(Icons.calendar_month, color: main_color),
          previousPageTitle: "",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ListView.builder(
                itemCount: realData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  String countryCode = "";
                  for (var item in countryList) {
                    if (realData[index].key.toString().toUpperCase() ==
                        item.name?.toUpperCase()) {
                      countryCode = item.dialCode ?? "";
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: Get.width * 0.9,
                                child: Text(
                                  " ${realData[index].key.toString().toUpperCase()} $countryCode  (${realData[index].value.toString()})",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
