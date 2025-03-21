
import '../../globalVars.dart';

class ProfileMatch {
  final List matchPercentage = [];
  int profileMatch(data) {
    var match = 0;
    if (userSave.religion == data.religion) {
      // print("1");
      match += 10;
    }
    if (userSave.KundaliDosh == data.kundalidosh) {
      // print("2");
      match += 10;
    }
    if (userSave.MartialStatus == data.martialstatus) {
      // print("3");
      match += 10;
    }
    if (userSave.Diet == data.diet) {
      // print("4");
      match += 10;
    }
    if (userSave.gender != data.gender) {
      if (userSave.gender == "Male" &&
          (double.parse(userSave.Height!.split(' ')[0]) >
              data.height!.split(' ')[0])) {
        match += 10;
      } else if (userSave.gender == "Female" &&
          (double.parse(userSave.Height!.split(' ')[0]) <
              data.height!.split(' ')[0])) {
        match += 10;
      }
    }
    if (userSave.Profession == data.profession) {
      // print("5");
      match += 10;
    }
    if (userSave.Diet == data.diet) {
      // print("6");
      match += 10;
    }
    if (userSave.Drink == data.drink) {
      // print("7");
      match += 5;
    }
    if (userSave.Smoke == data.smoke) {
      // print("8");
      match += 5;
    }
    if (userSave.Disability == data.disability) {
      // print("9");
      match += 10;
    }
    // if (profileMatchDataJson.LocatioList.toString().contains(data.Location)) {
    //   match += 10;
    // }
    if (match > 90) {
      match = 100;
    }

    // matchConditionCheck();
    // print(match);
    return match;
  }

  // matchConditionCheck() {}
}
