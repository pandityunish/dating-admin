import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/Storage/baseDatabaseRepo.dart';
import 'package:matrimony_admin/Storage/storage_repo.dart';
import 'package:matrimony_admin/screens/data_collection/customImg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assets/G_Sign.dart';
import '../Assets/ImageDart/images.dart';
import '../models/shared_pref.dart';
import '../models/user_model.dart';

class DatabaseRepo extends BaseDatabaseRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('user_data')
        .doc(uid)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  void sharedpref(var downloadurl) async {
    var prefs = await SharedPreferences.getInstance();

    List<String>? imgurls;
    if (prefs.getStringList("imgurls") != null) {
      imgurls = prefs.getStringList("imgurls");
      imgurls!.add(downloadurl);
    } else {
      imgurls = [downloadurl];
    }
    print(imgurls);

    prefs.setStringList("imgurls", imgurls);
  }

  @override
  Future<void> updateUserPicture(String imageName) async {
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);

    // var downloadurl = await StorageRepo().getDownloadurl(imageName);
    // setData(downloadurl);
    // final json = {
    //   'imageurls': FieldValue.arrayUnion([downloadurl]),
    // };
    // await docUser.update(json).catchError((error) => print(error)).then(
    //     (value) =>
    //         {sharedpref(downloadurl), ImageUrls().add(imageurl: downloadurl)});
  }

  Future<void> replaceUserPicture(String imageName, int num) async {
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);

    // var downloadurl = await StorageRepo().getDownloadurl(imageName);
    // replaceData(downloadurl, num);
  }

  dynamic setData(var downloadurl) async {
    SharedPref sharedPref = SharedPref();
    final json2 = await sharedPref.read("uid");
    var uid = json2?['uid'];
    // print();
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);

    try {
      User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
      // print(userSave.toString());
      if (userSave.imageUrls == null) {
        userSave.imageUrls = [downloadurl];
      } else {
        userSave.imageUrls?.add(downloadurl);
      }
      print("imgurls : ${userSave.imageUrls}");

      // print(" json : ${userSave.toJson().toString()}");
      final json = userSave.toJson();
      // print(json.toString());

      await docUser
          .update(json)
          .catchError((error) => print(error))
          .then((value) => {
                sharedpref(downloadurl),
                ImageUrls().add(imageurl: downloadurl),
                // imagepicked = false
              });

      sharedPref.save("user", userSave);
    } catch (Excepetion) {
      print(Excepetion);
    }
  }

  dynamic replaceData(var downloadurl, int num) async {
    SharedPref sharedPref = SharedPref();
    final json2 = await sharedPref.read("uid");
    var uid = json2?['uid'];
    // print();
    final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);

    try {
      User? userSave = User.fromJson(await sharedPref.read("user") ?? {});
      userSave.imageUrls![num] = downloadurl;
      print("imgurls : ${userSave.imageUrls}");

      // print(" json : ${userSave.toJson().toString()}");
      final json = userSave.toJson();
      // print(json.toString());

      await docUser.update(json).catchError((error) => print(error)).then(
          (value) => {
                sharedpref(downloadurl),
                ImageUrls().replaceLink(num, imageurl: downloadurl)
              });

      sharedPref.save("user", userSave);
    } catch (Excepetion) {
      print(Excepetion);
    }
  }
}
