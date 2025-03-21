import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../globalVars.dart';

class NotificationSend {
  congoNoti(json) {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(userSave.uid)
        .set({json} as Map<String, dynamic>);
  }
}
