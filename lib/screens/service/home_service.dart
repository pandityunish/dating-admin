import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:matrimony_admin/Auth/auth.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/delete_account.dart';
import 'package:matrimony_admin/models/match_model2.dart';
import 'package:matrimony_admin/models/new_save_pref.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:http/http.dart' as http;

import '../../models/admin_notification_model.dart';

class HomeService extends GetxController {
  Rx<NewSavePrefModel> saveprefdata = Rx(NewSavePrefModel(
      email: "",
      ageList: [],
      id: "",
      v: 0,
      religionList: [],
      citylocation: [],
      statelocation: [],
      kundaliDoshList: [],
      maritalStatusList: [],
      dietList: [],
      drinkList: [],
      smokeList: [],
      disabilityList: [],
      heightList: [],
      educationList: [],
      professionList: [],
      incomeList: [],
      location: []));
  Rx<NewSavePrefModel> saveprefdata1 = Rx(NewSavePrefModel(
      email: "",
      ageList: [],
      id: "",
      v: 0,
      citylocation: [],
      statelocation: [],
      religionList: [],
      kundaliDoshList: [],
      maritalStatusList: [],
      dietList: [],
      drinkList: [],
      smokeList: [],
      disabilityList: [],
      heightList: [],
      educationList: [],
      professionList: [],
      incomeList: [],
      location: []));
  Future<NewUserModel> getuserdata() async {
    NewUserModel? newUserModel;

    print(userSave.email);
    try {
      http.Response res = await http.get(
          Uri.parse("$getuserdataurl/${userSave.email}"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        newUserModel = NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)));

        // userdata.addAll(jsonDecode(res.body));
        // print(userdata);
        print(newUserModel.email);
        userSave.email = newUserModel.email;
        userSave.gender = newUserModel.gender;
        userSave.status = newUserModel.status;
        userSave.About_Me = newUserModel.About_Me;
        userSave.Partner_Prefs = newUserModel.Partner_Prefs;
        userSave.phone = newUserModel.phone;
        userSave.Smoke = newUserModel.Smoke;
        userSave.Profession = newUserModel.Profession;
        // userSave.KundaliDosh=newUserModel.kundalidosh;
        userSave.token = newUserModel.token;
        // userSave.displayName = newUserModel.name;
        userSave.religion = newUserModel.religion;
        // userSave.name = newUserModel.name;
        userSave.surname = newUserModel.surname;
        userSave.puid = newUserModel.puid;
        userSave.Height = newUserModel.Height;
        userSave.Diet = newUserModel.Diet;
        userSave.Drink = newUserModel.Drink;
        userSave.Disability = newUserModel.Disability;
        userSave.Education = newUserModel.Education;
        userSave.Income = newUserModel.Income;
        userSave.Location = newUserModel.Location;
        frienda = newUserModel.friends;
        friendr = newUserModel.pendingreq;
        friends = newUserModel.sendreq;
        shortFriend = newUserModel.shortlist;
        userSave.uid = newUserModel.id;
        blocFriend = newUserModel.blocklists;
        reportFriend = newUserModel.reportlist;
        shortFriend = newUserModel.shortlist;
        userSave.imageUrls = newUserModel.imageurls;
        userSave.videoLink = newUserModel.videolink;
        userSave.MartialStatus = newUserModel.MartialStatus;
        //  notificationslists=newUserModel.notifications;
        //  message=newUserModel.chats!;
        print(shortFriend);
        userSave.verifiedStatus = newUserModel.verifiedstatus;
        AuthService().getadminuser(userSave.email!);
        addtoken(newUserModel.email, deviceToken!);
        //  print(newUserModel.chats);
        //  print(newUserModel.notifications[0].title);
        // activitieslists=newUserModel.activities;
        print(newUserModel.status);
        return newUserModel;
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return newUserModel!;
  }

  Future<NewUserModel> getuserdatabyid(String _id) async {
    NewUserModel? newUserModel;

    try {
      http.Response res = await http.get(Uri.parse("$getuserdatabyurl/$_id"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        newUserModel = NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)));
        return newUserModel;
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return newUserModel!;
  }

  Future<void> updatelogin({
    required String email,
    required String mes,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(updateloginurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "mes": mes}));
      print("islogout1234 ${res.body}");
      if (res.statusCode == 200) {
        print("update noti  successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<NewUserModel?> getdeleteuserdatabyid(String _id) async {
    NewUserModel? newUserModel;

    try {
      http.Response res = await http.post(Uri.parse(getdeleteduserbyid),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"uid": _id}));
      log(res.body);
      if (res.statusCode == 200) {
        newUserModel = NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)));
        return newUserModel;
      } else {
        log("something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return newUserModel; // Return null if user not found
  }

  Future<int> gettotaluser() async {
    int totaluser = 0;
    try {
      http.Response res = await http.get(
        Uri.parse(getusersnumber),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        totaluser = jsonDecode(res.body);
        return totaluser;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
    }
    return totaluser;
  }

  Future<int> getdeletetotaluser() async {
    int totaluser = 0;
    try {
      http.Response res = await http.get(
        Uri.parse(getdeleteusersnumber),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        totaluser = jsonDecode(res.body);
        return totaluser;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
    }
    return totaluser;
  }

  Future<void> addtoactivities(
      {required String email,
      required String title,
      required String username,
      String? userimage,
      required String userid}) async {
    try {
      print("hello");
      http.Response res = await http.post(Uri.parse(addtoactivitiesurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "title": title,
            "username": username,
            "userimage": userimage ?? "",
            "userid": userid
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("activities added successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendrequest(
      {required String email,
      required String sendemail,
      required String senduid,
      required String profileid}) async {
    try {
      http.Response res = await http.post(Uri.parse(sendconnecturl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "uid": profileid,
            "sendemail": sendemail,
            "senduid": senduid
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> getthenumberofunread() async {
    int totaluser = 0;
    try {
      print("this is not working");
      http.Response res = await http.get(
        Uri.parse(getallnotiunreadurl),
        headers: {'Content-Type': 'Application/json'},
      );
      print("*****************hi");
      print(jsonDecode(res.body));
      print("*****************hello");
      if (res.statusCode == 200) {
        totaluser = jsonDecode(res.body).length;
        print("*****************hi");
        print(jsonDecode(res.body));
        print("*****************hello");
        return totaluser;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
    }
    return totaluser;
  }

  Future<List<AdminNotificationModel>> getunreadmessages() async {
    List<AdminNotificationModel> allnotifications = [];
    try {
      print("this is not working");
      http.Response res = await http.get(
        Uri.parse(getallnotiunreadurl),
        headers: {'Content-Type': 'Application/json'},
      );

      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allnotifications.add(AdminNotificationModel.fromJson(
              jsonEncode(jsonDecode(res.body)[i])));
        }

        return allnotifications;
      } else {
        return allnotifications;
      }
    } catch (e) {
      print(e.toString());
    }
    return allnotifications;
  }

  Future<List<NewUserModel>> getalluserdata(
      {required String gender,
      required String email,
      required String religion,
      required int page,
      required List<dynamic> ages,
      required List<dynamic> religionList,
      required List<dynamic> kundaliDoshList,
      required List<dynamic> maritalStatusList,
      required List<dynamic> dietList,
      required List<dynamic> drinkList,
      required List<dynamic> smokeList,
      required List<dynamic> disabilityList,
      required List<dynamic> heightList,
      required List<dynamic> educationList,
      required List<dynamic> professionList,
      required List<dynamic> incomeList,
      required List<dynamic> statelocation,
      required List<dynamic> citylocation,
      required List<dynamic> location}) async {
    List<NewUserModel> allusers = [];

    try {
      http.Response res = await http.post(Uri.parse(getalluserssurl),
          headers: {'Content-Type': 'Application/json'},
          body: json.encode({
            "gender": gender,
            "religion": religion,
            "page": page,
            "email": email,
            "ages": ages,
            "religionList": religionList,
            "kundaliDoshList": kundaliDoshList,
            "maritalStatusList": maritalStatusList,
            "dietList": dietList,
            "drinkList": drinkList,
            "smokeList": smokeList,
            "disabilityList": disabilityList,
            "heightList": heightList,
            "educationList": educationList,
            "professionList": professionList,
            "incomeList": incomeList,
            "statelocation": statelocation,
            "citylocation": citylocation,
            "location": location
          }));
      print("${res.body} hello");
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          allusers
              .add(NewUserModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));

          // print(userdata);
        }
      } else {
        print("something went wrongyunish");
      }
    } catch (e) {
      print(e.toString());
    }
    return allusers;
  }

  Future<void> deleteaccount(
      {required String email,
      required String reasontodeleteuser,
      required NewUserModel newusermodel}) async {
    try {
      http.Response res = await http.post(Uri.parse(deleteaccounturl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": newusermodel.email,
            "aboutme": newusermodel.About_Me,
            "diet": newusermodel.Diet,
            "disability": newusermodel.Disability,
            "drink": newusermodel.Drink,
            "education": newusermodel.Education,
            "height": newusermodel.Height,
            "income": newusermodel.Income,
            "patnerprefs": newusermodel.Partner_Prefs,
            "smoke": newusermodel.Smoke,
            "displayname": newusermodel.displayname,
            "puid": newusermodel.puid,
            "religion": newusermodel.religion,
            "name": newusermodel.name,
            "surname": newusermodel.surname,
            "phone": newusermodel.phone,
            "gender": newusermodel.gender,
            "kundalidosh": newusermodel.KundaliDosh,
            "martialstatus": newusermodel.MartialStatus,
            "profession": newusermodel.Profession,
            "location": newusermodel.Location,
            "city": newusermodel.city,
            "state": newusermodel.state,
            "imageurls": newusermodel.imageurls,
            "blocklists": newusermodel.blocklists,
            "reportlist": newusermodel.reportlist,
            "shortlist": newusermodel.shortlist,
            "country": newusermodel.country,
            "token": newusermodel.token,
            "age": newusermodel.dob,
            "lat": newusermodel.lat,
            "lng": newusermodel.lng,
            "timeofbirth": newusermodel.timeofbirth,
            "placeofbirth": newusermodel.placeofbirth,
            "dob": newusermodel.dob,
            "reasontodeleteuser": reasontodeleteuser
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteregisteruseraccount({
    required String email,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(deleteuseraccounturl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      print("***********1234567");
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteuseraccount(
      {required String email, required NewUserModel userSave}) async {
    try {
      DeleteUserModel usermodel = DeleteUserModel(
        About_Me: userSave.About_Me!,
        isBlur: userSave.isBlur!,
        id: userSave.id!,
        showads: [],
        Location: userSave.Location!,
        adminlat: userSave.lat,
        adminlng: userSave.lng,
        chatnow: 0,
        createdAt: "",
        downloadbiodata: false,
        editstatus: "",
        freepersonmatch: 0,
        marriageloan: 0,
        onlineuser: false,
        share: 0,
        support: 0,
        unapproveActivites: [],
        chats: [],
        placeofbirth: userSave.placeofbirth!,
        timeofbirth: userSave.timeofbirth!,
        Diet: userSave.Diet!,
        Disability: userSave.Disability!,
        Drink: userSave.Drink!,
        isLogOut: userSave.isLogOut!,
        status: userSave.status!,
        Education: userSave.Education!,
        Height: userSave.Height!,
        Income: userSave.Income!,
        Partner_Prefs: userSave.Partner_Prefs!,
        Smoke: userSave.Smoke!,
        displayname: userSave.displayname!,
        email: email,
        religion: userSave.religion!,
        name: userSave.name!,
        surname: userSave.surname!,
        phone: userSave.phone!,
        gender: userSave.gender!,
        KundaliDosh: userSave.KundaliDosh!,
        MartialStatus: userSave.MartialStatus!,
        Profession: userSave.Profession!,
        city: userSave.city!,
        state: userSave.state!,
        imageurls: userSave.imageurls!,
        blocklists: [],
        reportlist: [],
        shortlist: [],
        country: userSave.country!,
        token: userSave.token!,
        puid: userSave.puid!,
        dob: userSave.dob!,
        age: "20",
        lat: userSave.lat!,
        lng: userSave.lng!,
        verifiedstatus: userSave.verifiedstatus!,
        pendingreq: [],
        sendreq: [],
        friends: userSave.friends,
        videolink: userSave.videolink!,
        notifications: [],
        activities: [],
      );
      http.Response res = await http.post(Uri.parse(deleteaccounturl),
          headers: {'Content-Type': 'Application/json'},
          body: usermodel.toJson());
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteaccountfromadmin({
    required String id,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(deleteaccountfromadminurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"id": id}));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<NewUserModel>> getallusers({
    required String page,
  }) async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.post(Uri.parse(getallusersurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode(
              {"email": userSave.email, "page": page, "itemsPerPage": 10}));
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<List<NewUserModel>> getallusersbyoldestfirst() async {
    List<NewUserModel> getallusersdata = [];
    try {
      http.Response response = await http.get(
        Uri.parse(getoldestfirsturl),
        headers: {'Content-Type': 'Application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getallusersdata.add(
              NewUserModel.fromJson(jsonEncode(jsonDecode(response.body)[i])));

          // print(userdata);
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return getallusersdata;
  }

  Future<List<AdminNotificationModel>> getAdminNotifications(
      int page, int perPage) async {
    List<AdminNotificationModel> getAdminNotificationsData = [];
    try {
      final response = await http.get(
        Uri.parse('$getallnotificationurl?page=$page&perPage=$perPage'),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getAdminNotificationsData.add(AdminNotificationModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return getAdminNotificationsData;
  }

  Future<List<AdminNotificationModel>> getsearchNotifications(
      {required String title, required int page}) async {
    List<AdminNotificationModel> getAdminNotificationsData = [];
    try {
      final response = await http.post(
        Uri.parse('$baseurl/admin/searchnotification'),
        body: jsonEncode({"title": title, "page": page}),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          getAdminNotificationsData.add(AdminNotificationModel.fromJson(
              jsonEncode(jsonDecode(response.body)[i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return getAdminNotificationsData;
  }

  Future<List<AdminNotificationModel>> getalladminnotification(
    int page,
      String email) async {
    List<AdminNotificationModel> getAdminNotificationsData = [];
    try {
      final response = await http.post(
        Uri.parse(getadminnotificationurl),
        body: jsonEncode({"adminemail": email,"page": page}),
        headers: {'Content-Type': 'application/json'},
      );
        log("${jsonDecode(response.body)["data"]}");

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonDecode(response.body)["data"].length; i++) {
          getAdminNotificationsData.add(AdminNotificationModel.fromJson(
              jsonEncode(jsonDecode(response.body)["data"][i])));
        }
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      log(e.toString());
    }
    return getAdminNotificationsData;
  }

  Future<NewSavePrefModel> getusersaveprefdata() async {
    NewSavePrefModel? newUserModel;
    print("${userSave.email} hello");
    try {
      http.Response res = await http.get(
          Uri.parse("$getusersavepref/${userSave.email}"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        newUserModel = newSavePrefModelFromJson(res.body);

        saveprefdata.value = newUserModel;
        print(saveprefdata.value.ageList);
        return newUserModel;
      } else {
        print("something went wrong1");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return newUserModel!;
  }

  Future getusersaveprefdata1(String email) async {
    NewSavePrefModel? newUserModel;
    try {
      http.Response res = await http.get(Uri.parse("$getusersavepref/$email"),
          headers: {'Content-Type': 'Application/json'});
      print("*********");
      print(res.body);
      print("*******************");
      if (res.statusCode == 200) {
        newUserModel = newSavePrefModelFromJson(res.body);

        saveprefdata1.value = newUserModel;
        return newUserModel;
      } else {
        print("something went wrong1");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
  }

  Future<NewSavePrefModel> getsavepref(String email) async {
    NewSavePrefModel newUserModel = NewSavePrefModel(
        id: "",
        email: email,
        ageList: [],
        religionList: [],
        citylocation: [],
        statelocation: [],
        kundaliDoshList: [],
        maritalStatusList: [],
        dietList: [],
        drinkList: [],
        smokeList: [],
        disabilityList: [],
        heightList: [],
        educationList: [],
        professionList: [],
        incomeList: [],
        location: [],
        v: 0);
    try {
      http.Response res = await http.get(Uri.parse("$getusersavepref/$email"),
          headers: {'Content-Type': 'Application/json'});
      print(res.body);
      if (res.statusCode == 200) {
        newUserModel = newSavePrefModelFromJson(res.body);

        return newUserModel;
      } else {
        print("something went wrong1");
      }
    } catch (e) {
      print(e.toString() + "3ee");
    }
    return newUserModel;
  }

  Future<void> createsavepref({
    required List<dynamic> ageList,
    required String email,
    required List<dynamic> religionList,
    required List<dynamic> kundaliDoshList,
    required List<dynamic> maritalStatusList,
    required List<dynamic> heightList,
    required List<dynamic> smokeList,
    required List<dynamic> drinkList,
    required List<dynamic> disabilityList,
    required List<dynamic> dietList,
    required List<dynamic> educationList,
    required List<dynamic> statelocation,
    required List<dynamic> citylocation,
    required List<dynamic> professionList,
    required List<dynamic> incomeList,
    required List<dynamic> location,
  }) async {
    try {
      NewSavePrefModel newSavePrefModel = NewSavePrefModel(
          id: "",
          email: email,
          ageList: ageList,
          religionList: religionList,
          citylocation: citylocation,
          statelocation: statelocation,
          kundaliDoshList: kundaliDoshList,
          maritalStatusList: maritalStatusList,
          dietList: dietList,
          drinkList: drinkList,
          smokeList: smokeList,
          disabilityList: disabilityList,
          heightList: heightList,
          educationList: educationList,
          professionList: professionList,
          incomeList: incomeList,
          location: location,
          v: 0);
      print(newSavePrefModel.ageList);
      http.Response res = await http.post(Uri.parse(createuseravepref),
          headers: {'Content-Type': 'Application/json'},
          body:
              // newSavePrefModel.toJson()
              json.encode({
            "email": email,
            "ageList": ageList,
            "kundaliDoshList": kundaliDoshList,
            "religionList": religionList,
            "maritalStatusList": maritalStatusList,
            "dietList": dietList,
            "statelocation": statelocation,
            "citylocation": citylocation,
            "drinkList": drinkList,
            "smokeList": smokeList,
            "disabilityList": disabilityList,
            "heightList": heightList,
            "educationList": educationList,
            "professionList": professionList,
            "incomeList": incomeList,
            "location": location
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print('saved');
      } else {
        print('not saved');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addtosavedprefprofile(
      {required List<dynamic> ageList,
      required List<dynamic> religionList,
      required List<dynamic> kundaliDoshList,
      required List<dynamic> maritalStatusList,
      required List<dynamic> dietList,
      required List<dynamic> drinkList,
      required List<dynamic> smokeList,
      required String email,
      required String uid,
      required String name,
      required List<dynamic> disabilityList,
      required List<dynamic> heightList,
      required List<dynamic> educationList,
      required List<dynamic> professionList,
      required List<dynamic> incomeList,
      required List<dynamic> location,
      required List<dynamic> statelocation,
      required List<dynamic> citylocation}) async {
    try {
      http.Response res = await http.post(Uri.parse(addtosharedprefsearch),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "ageList": ageList,
            "citylocation": citylocation,
            "religionList": religionList,
            "statelocation": statelocation,
            "kundaliDoshList": kundaliDoshList,
            "maritalStatusList": maritalStatusList,
            "dietList": dietList,
            "drinkList": drinkList,
            "smokeList": smokeList,
            "disabilityList": disabilityList,
            "heightList": heightList,
            "educationList": educationList,
            "professionList": professionList,
            "incomeList": incomeList,
            "location": location,
            "email": email,
            "name": name,
            "userid": uid
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("updatelogin  successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> approveuser(String email) async {
    try {
      http.Response res = await http.post(Uri.parse(approveuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateunapproveactivites(String email) async {
    try {
      http.Response res = await http.post(Uri.parse(updateunapproveurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtoken(String email, String token) async {
    try {
      http.Response res = await http.post(Uri.parse(addtotokenurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "token": token}));
      print("approved successfully" + res.body);
      if (res.statusCode == 200) {
        print("approved successfully" + res.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editapproveuser(String email) async {
    try {
      http.Response res = await http.post(Uri.parse(approveuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("approved successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editprofile(
      {required String email,
      required String aboutme,
      required String mypreference,
      required List<dynamic> imageurls}) async {
    try {
      print(imageurls);
      http.Response res = await http.post(Uri.parse(editprofileurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
            "patnerprefs": mypreference,
            "aboutme": aboutme,
            "imageurls": imageurls
          }));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtoblock({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(blockuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      print(res.body);
      if (res.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unblock({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(unblockuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("unblock");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unshortlistuser(
      {required String email, required String profileid}) async {
    try {
      http.Response res = await http.post(Uri.parse(unshortlistrurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "senduid": profileid}));
      if (res.statusCode == 200) {
        print("unshortlist user successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtosortlist(
      {required String email, required String profileid}) async {
    try {
      http.Response res = await http.post(Uri.parse(addtosorturl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "senduid": profileid}));
      if (res.statusCode == 200) {
        print("add to sortlist successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removefromreportlist({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(unreportuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("unshortlist user successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtoreportlist({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(reportuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("add to sortlist successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyuser({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(updateverifyuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("verify user");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unverifyuser({required String email}) async {
    try {
      http.Response res = await http.post(Uri.parse(updateunverifyuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({
            "email": email,
          }));
      if (res.statusCode == 200) {
        print("unverify user");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Match2?> getusermatch2({
    required String boydob,
    required String boytob,
    required double boylat,
    required double boyon,
  }) async {
    Match2? match;
    try {
      http.Response res = await http.get(Uri.parse(
          "https://api.vedicastroapi.com/v3-json/dosha/mangal-dosh?dob=$boydob&tob=$boytob&lat=$boylat&lon=$boyon&tz=5.5&api_key=c3c8e02b-443e-529e-bf07-9772430f8f8b&lang=en"));
      print(res.body);
      if (res.statusCode == 200) {
        print("matadcafd");
        match = match2FromJson(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return match!;
  }

  Future updateblur({required String email, required bool isblur}) async {
    try {
      http.Response res = await http.post(Uri.parse(updateblurprofile),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode({"email": email, "isblur": isblur}));

      if (res.statusCode == 200) {
        print(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createverifieduser({
    required String editname,
    required String videolink,
    required String useremail,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(createverifyuserurl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode(
              {"userid": useremail, "videoLink": videolink, "name": editname}));
      print(res.body);
      if (res.statusCode == 200) {
        print("accept request successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getmaintenance() async {
    var data;
    try {
      http.Response res = await http.get(
        Uri.parse(getmaintenanceurl),
        headers: {'Content-Type': 'Application/json'},
      );
      print(res.body);
      if (res.statusCode == 200) {
        return data = jsonDecode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return data;
  }
}
