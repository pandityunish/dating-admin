import 'package:flutter/services.dart';

class ScreenshotDetection {
  static const MethodChannel _channel = MethodChannel('screenshot_detection');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onScreenshot') {
        // Perform your action here
        print('Screenshot detected');
      } else if (call.method == 'onScreenRecording') {
        // Perform your action here
        print('Screen recording detected');
      }else{
        print("somethign went wrong");
      }
    });
  }
}
