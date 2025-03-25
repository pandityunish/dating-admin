import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:matrimony_admin/Assets/countryModel/country_state_city_picker.dart';


class Searchservice {
  
  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/country.json');
  }
  Future<List<LocationModel>> getData() async {
    String jsonString = await loadJsonData();
    List<dynamic> jsonData = json.decode(jsonString);
    print(jsonData);
    List<LocationModel> persons =
        jsonData.map((json) => LocationModel.fromJson(json)).toList();
    return persons;
  }

 
}
