import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../globalVars.dart';
import 'notiModel.dart';

class NotificationFunction {
  static setNotification(String toWhome, String text, String Type,
      {String useruid = ""}) async {
    DatabaseReference _dbref = FirebaseDatabase.instance.ref();
    _dbref = _dbref.child(toWhome);
    var tempuid;
    print(useruid);
    if (toWhome == 'user2') {
      tempuid = useruid;
      // } else if (toWhome != 'user2' && useruid != null) {
      //   tempuid = useruid;
    } else {
      tempuid = (userSave.uid == null) ? useruid : userSave.uid;
    }
    if (useruid == "") {
      useruid = userSave.uid!;
    }
    print("$tempuid , useruid : $useruid");
    if (await docexist(_dbref.child(tempuid))) {
      DateTime time = DateTime.now().toUtc();
      int millisecondsSinceEpoch = time.millisecondsSinceEpoch;
      NotifyModel temp = NotifyModel(
          text: text, uid: useruid, type: Type, time: millisecondsSinceEpoch);
      _dbref.child(tempuid).push().update(temp.toJson());
    } else {
      DateTime time = DateTime.now().toUtc();
      int millisecondsSinceEpoch = time.millisecondsSinceEpoch;
      NotifyModel temp = NotifyModel(
          text: text, uid: useruid, type: Type, time: millisecondsSinceEpoch);
      _dbref.child(tempuid).push().set(temp.toJson());
    }
    // _dbref.child(toWhome).orderByChild('time').onValue.listen((event) {
    //   DataSnapshot snapshot = event.snapshot;
    //   Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    //   values.forEach((snapshot, value) {
    //     messages.add(value);
    //     setState(() {
    //       messages.sort((a, b) => a['time'].compareTo(b['time']));
    //     });
    //   });
    // });
  }

  static Future<bool> docexist(DatabaseReference databaseReference) async {
    DatabaseEvent dataSnapshot = await databaseReference.once();
    print(dataSnapshot.snapshot.value);
    return dataSnapshot.snapshot.value != null;
  }

  showNotification(String towhome) {}
  static Future<void> setonlineStatus(String useruid, String status) async {
    try {
      DatabaseReference _dbref =
          FirebaseDatabase.instance.ref().child("onlineStatus");

      bool exists = await docexist(_dbref.child(useruid));
      if (exists) {
        await _dbref.child(useruid).update({"status": status, "uid": useruid});
        print("Updated status for user: $useruid");
      } else {
        await _dbref.child(useruid).set({"status": status, "uid": useruid});
        print("Set status for new user: $useruid");
      }
    } catch (e) {
      print("Error setting online status: $e");
    }
  }

  static createChatroom(String useruid, String frienduid) async {
    DatabaseReference _dbref = FirebaseDatabase.instance.ref();
    _dbref = _dbref.child("chatroomids");
    final id = generateUniqueId();
    DateTime time = DateTime.now().toUtc();
    int timeStamp = time.millisecondsSinceEpoch;
    if (await docexist(_dbref.child(useruid))) {
      _dbref.child(useruid).child(id).set({
        'useruid': useruid,
        'frienduid': frienduid,
        'roomid': id,
        'lmtime': timeStamp,
        'lmtext': ''
      });
    } else {
      _dbref.child(useruid).child(id).set({
        'useruid': useruid,
        'frienduid': frienduid,
        'roomid': id,
        'lmtime': timeStamp,
        'lmtext': ''
      });
    }
    if (await docexist(_dbref.child(useruid))) {
      _dbref.child(frienduid).child(id).set({
        'useruid': frienduid,
        'frienduid': useruid,
        'roomid': id,
        'lmtime': timeStamp,
        'lmtext': ''
      });
    } else {
      _dbref.child(frienduid).child(id).set({
        'useruid': frienduid,
        'frienduid': useruid,
        'roomid': id,
        'lmtime': timeStamp,
        'lmtext': ''
      });
    }
    return id;
  }

  static String generateUniqueId() {
    final now = DateTime.now();
    final uniqueId = now.microsecondsSinceEpoch.toString();
    return uniqueId;
  }
}
