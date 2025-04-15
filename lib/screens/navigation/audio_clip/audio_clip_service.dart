import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip_model.dart';
class AudioClipService {
    Future<void> sendAudioClip(String email,String audioLink,String name,String status) async {
    try {
      http.Response res = await http.post(Uri.parse(postAudioClipUrl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
           "audioLink":audioLink,"name":name,"status":status
          }));
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<PaginatedAudioClip?> fetchAudioClips(String email,{int page = 1}) async {
  try {
    final response = await http.get(
      Uri.parse('$postAudioClipUrl?email=$email&page=$page&limit=10'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final paginatedClips = PaginatedAudioClip.fromJson(jsonData);

      return paginatedClips;
    } else {
      print('Failed to fetch audio clips. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching audio clips: $e');
    return null;
  }
}

}
