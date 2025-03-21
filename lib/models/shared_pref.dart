import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<Map<String, dynamic>?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? jsonString = prefs.getString(key);
      if (jsonString == null) {
        print("No value found for key: $key");
        return null;
      }
      // Decode and cast to Map<String, dynamic>
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap;
    } catch (e) {
      print("Error in shared pref: $e");
      return null; // Return null or a default value if an error occurs
    }
  }

  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(key, json.encode(value));
    } catch (e) {
      print("Error saving to shared pref: $e");
    }
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove(key);
    } catch (e) {
      print("Error removing from shared pref: $e");
    }
  }
}
