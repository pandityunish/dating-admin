import 'package:flutter/material.dart';

import '../../globalVars.dart';

class ProfileCompletion {
  var profilePercentage = 50;

  int profileComplete() {
    if (userSave.About_Me != null || userSave.About_Me != "") {
      profilePercentage += 5;
    }
    if (userSave.Partner_Prefs != null || userSave.Partner_Prefs != "") {
      profilePercentage += 5;
    }
    if (userSave.imageUrls !=null && userSave.imageUrls!.isNotEmpty) {
      profilePercentage += 10;
    }
    if (userSave.status == "approved") {
      profilePercentage += 10;
    }
    return profilePercentage;
  }
}
