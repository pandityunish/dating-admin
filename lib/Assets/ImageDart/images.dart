import 'package:flutter/material.dart';

class ImageUrls extends ValueNotifier<List<String>> {
  ImageUrls._sharedInstance() : super([]);
  static final ImageUrls _shared = ImageUrls._sharedInstance();
  factory ImageUrls() => _shared;
  int get length => value.length;

  void add({required String imageurl}) {
    // print(imageurl);
    final imageurls = value;
    imageurls.add(imageurl);
    notifyListeners();
  }

  void clear() {
    // print(imageurl);
    final imageurls = value;
    imageurls.clear();
    notifyListeners();
  }

  void replaceLink(int num, {required String imageurl}) {
    print(imageurl);
    final imageurls = value;
    imageurls[num] = imageurl;
    notifyListeners();
  }

  void deleteLink(int num) {
    final imageurls = value;
    imageurls.removeAt(num);
    notifyListeners();
  }

  String? imageUrl({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}
class ImageUrls1 extends ValueNotifier<List<String>> {
  ImageUrls1._sharedInstance() : super([]);
  static final ImageUrls1 _shared = ImageUrls1._sharedInstance();
  factory ImageUrls1() => _shared;
  int get length => value.length;

  void add({required String imageurl}) {
    // print(imageurl);
    final imageurls = value;
    imageurls.add(imageurl);
    notifyListeners();
  }

  void clear() {
    // print(imageurl);
    final imageurls = value;
    imageurls.clear();
    notifyListeners();
  }

  void replaceLink(int num, {required String imageurl}) {
    print(imageurl);
    final imageurls = value;
    imageurls[num] = imageurl;
    notifyListeners();
  }

  void deleteLink(int num) {
    final imageurls = value;
    imageurls.removeAt(num);
    notifyListeners();
  }

  String? imageUrl({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}