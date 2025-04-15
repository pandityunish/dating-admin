import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as cloud;


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matrimony_admin/Assets/defaultAlgo/profileMatch.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/filterusermodel.dart';
import 'package:matrimony_admin/models/new_save_pref.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/matchprofile/match_profile_page.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:matrimony_admin/screens/notification/navHome.dart';
import 'package:matrimony_admin/screens/profie_types/sortprofile.dart';
import 'package:matrimony_admin/screens/profile/filter.dart';
import 'package:matrimony_admin/screens/profile/profile_service.dart';
import 'package:matrimony_admin/screens/search.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import 'package:matrimony_admin/sendUtils/notiFunction.dart';
import '../../Assets/box.dart';

import '../../globalVars.dart' as glb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../Chat/main.dart';
import '../../Chat/screens/mobile_chat_screen.dart';


import '../../models/user_model.dart';
import '../ERRORs/save_pref_errors.dart';



var profiledata;

class MatchSlideProfile extends StatefulWidget {
  MatchSlideProfile(
      {super.key,
      this.type = "",
      required this.userSave,
      this.user_list,
      required this.notiPage});
  String type;
  NewUserModel userSave;
  bool notiPage = false;
  var user_list;
  @override
  State<MatchSlideProfile> createState() => _SlideProfileState();
}

class _SlideProfileState extends State<MatchSlideProfile> {
  int num = 6;
  int pagecount = 2;
  int profilepercentage=0;
  bool load = false;
  DatabaseReference? _notificationsRef;
  int _unreadCount = 0;
  // User userSave = User();
  List<User> userlist = [];
  List<User> largeuserlist = [];
  List<NewUserModel?> newuserlists=[];
  bool nodata = false;
  cloud.QueryDocumentSnapshot? lastDocument;
  HomeService homeservice=Get.put(HomeService());
    var profilePercentage = 50;
  Future<int> profileComplete() async {
    NewSavePrefModel? newSavePrefModel =
        await HomeService().getusersaveprefdata1(widget.userSave!.email);

    if (widget.userSave!.About_Me != null || widget.userSave!.About_Me != "") {
      profilePercentage += 5;
    }
    if (widget.userSave!.Partner_Prefs != null ||
        widget.userSave!.Partner_Prefs != "") {
      profilePercentage += 5;
    }
    if (widget.userSave!.imageurls.isNotEmpty) {
      profilePercentage += 10;
    }
    if (widget.userSave!.status == "approved") {
      profilePercentage += 10;
    }
    if (newSavePrefModel != null) {
      profilePercentage += 5;
    }
    if (widget.userSave!.verifiedstatus == "verified") {
      profilePercentage += 15;
    }
    setState(() {});
    return profilePercentage;
  }
void getalluserlists()async{

if(widget.user_list==null || widget.user_list.isEmpty){
   load=true;
setState(() {
  
});
    if(homeservice.saveprefdata1.value.ageList.isNotEmpty || homeservice.saveprefdata1.value.dietList.isNotEmpty
   || homeservice.saveprefdata1.value.disabilityList.isNotEmpty|| homeservice.saveprefdata1.value.drinkList.isNotEmpty||
    homeservice.saveprefdata1.value.educationList.isNotEmpty|| homeservice.saveprefdata1.value.dietList.isNotEmpty
    || homeservice.saveprefdata1.value.heightList.isNotEmpty || homeservice.saveprefdata1.value.incomeList.isNotEmpty || homeservice.saveprefdata1.value.kundaliDoshList.isNotEmpty
    || homeservice.saveprefdata1.value.location.isNotEmpty|| homeservice.saveprefdata1.value.maritalStatusList.isNotEmpty|| homeservice.saveprefdata1.value.professionList.isNotEmpty|| homeservice.saveprefdata1.value.religionList.isNotEmpty

    || homeservice.saveprefdata1.value.smokeList.isNotEmpty
    ){
      
      print(homeservice.saveprefdata1.value.dietList);
   newuserlists=await   homeservice.getalluserdata(gender:widget. userSave.gender=="male"?"female":"male",
       email:widget. userSave.email!, religion:widget. userSave.religion!,
        page: 1, ages:homeservice.saveprefdata1.value.ageList ,
         religionList: homeservice.saveprefdata1.value.religionList,
          kundaliDoshList: homeservice.saveprefdata1.value.kundaliDoshList,
          citylocation: homeservice.saveprefdata1.value.citylocation,
          statelocation: homeservice.saveprefdata1.value.statelocation,
           maritalStatusList: homeservice.saveprefdata1.value.maritalStatusList,
            dietList: homeservice.saveprefdata1.value.dietList,
             drinkList: homeservice.saveprefdata1.value.drinkList, 
            smokeList: homeservice.saveprefdata1.value.smokeList,
             disabilityList: homeservice.saveprefdata1.value.disabilityList, 
            heightList: homeservice.saveprefdata1.value.heightList, 
            educationList: homeservice.saveprefdata1.value.educationList,
             professionList: homeservice.saveprefdata1.value.professionList,
              incomeList: homeservice.saveprefdata1.value.incomeList,
              location: homeservice.saveprefdata1.value.location);
    }else{
      newuserlists= await homeservice.getalluserdata(page: 1,
       gender: widget.userSave.gender=="male"? "female":"male",
      ages:  ["18", "70"],
      dietList: [],
      citylocation: [],
      statelocation: [],
      disabilityList:[],
      drinkList: [],
      educationList: [],
      email: widget.userSave.email,
       heightList: [],
      incomeList: [],
      kundaliDoshList: [], 
      location: [],
      maritalStatusList: []
      ,professionList: [],
      religion: widget.userSave.religion,religionList: [],
      smokeList: []);
    }
//   List<Filterusermodel> usersWithDistance = newuserlists.map((user) {

//   int distance =ProfileMatch().profileMatch(user,widget.userSave);
//   return Filterusermodel(matchvalue:distance ,newUserModel: user!);
// }).toList();
 List<Matchusermodel> profilematch = await Future.wait(
          newuserlists.map((user) async {
            double distance = await ProfileMatch().getallusermatch(user!,widget.userSave);
            return Matchusermodel(
                kundalimatch: distance.toInt(), newUserModel: user);
          }),
        );
        profilematch.sort((a, b) => b.kundalimatch - a.kundalimatch);
        newuserlists.clear();
        for (var i = 0; i < profilematch.length; i++) {
          newuserlists.add(profilematch[i].newUserModel);
        }

        setState(() {});
// usersWithDistance.sort((a, b) => b.matchvalue-a.matchvalue);
// newuserlists.clear();
// for (var i = 0; i < usersWithDistance.length; i++) {
//   newuserlists.add(usersWithDistance[i].newUserModel);
// }
 

    load=false;

}else{
  newuserlists=[];
   load=false;
  newuserlists=widget.user_list!;
  setState(() {
    
  });

}
 
 
}

  @override
  void initState() {
     getallnumofunreadnoti();
setState(() {
  load=true;
});
    // print("Page is Running");
    super.initState();
    
   homeservice.getusersaveprefdata1(widget.userSave.email).whenComplete((){
     getalluserlists();
   } );   
 
  
  profileComplete();
  }

  
  pushChatPage(
    var roomid,
    var profiledata,
    var profilepic,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (maincontext) => Scaffold(
                body: MobileChatScreen(
                  newUserModel: widget.userSave,
                    roomid: roomid,
                    profileDetail: profiledata,
                    profilepic: profilepic),
              )),
    );
  }

  // data() async {
  //   SharedPref sharedPref = SharedPref();
  //   final json2 = await sharedPref.read("uid");
  //   var uid = json2['uid'];
  //   cloud.FirebaseFirestore.instance
  //       .collection('user_data')
  //       .doc(uid)
  //       .get()
  //       .then((cloud.DocumentSnapshot doc) async {
  //     if (!mounted) return;
  //     setState(() {
  //       userSave = User.fromdoc(doc);
  //       load = true;
  //     });
  //   });
  // }
    int numofnoti = 0;
  void getallnumofunreadnoti() async {
    numofnoti = await HomeService().getthenumberofunread();
    setState(() {});
  }
int currentPage = 0;
bool _ispageLoading=false;
   PageController controller = PageController(initialPage: 0,);
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // key: scrollKey,
        // key: scrollKey,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              load==true?
              Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              CircularProgressIndicator(color: main_color,),
                              // Text(
                              //     "No data available according to preference \nKindly change your preference"),
                            ],
                          ),
                        ):
              newuserlists.isEmpty 
                      ?
                      // ? Center(
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: const [
                      //         // CircularProgressIndicator(),
                      //         Text(
                      //             "No data available according to preference \nKindly change your preference"),
                      //       ],
                      //     ),
                      //   )
                      SavePreferencesError()
                      : 
                       PageView.builder(
                        // reverse: true,
                          controller: controller,
                          onPageChanged: (index) async {
                              if (index == newuserlists.length - 4) {
                               
                                _ispageLoading = true;
                                setState(() {});
                                  if(homeservice.saveprefdata1.value.ageList.isNotEmpty || homeservice.saveprefdata1.value.dietList.isNotEmpty
   || homeservice.saveprefdata1.value.disabilityList.isNotEmpty|| homeservice.saveprefdata1.value.drinkList.isNotEmpty||
    homeservice.saveprefdata1.value.educationList.isNotEmpty|| homeservice.saveprefdata1.value.dietList.isNotEmpty
    || homeservice.saveprefdata1.value.heightList.isNotEmpty || homeservice.saveprefdata1.value.incomeList.isNotEmpty || homeservice.saveprefdata1.value.kundaliDoshList.isNotEmpty
    || homeservice.saveprefdata1.value.location.isNotEmpty|| homeservice.saveprefdata1.value.maritalStatusList.isNotEmpty|| homeservice.saveprefdata1.value.professionList.isNotEmpty|| homeservice.saveprefdata1.value.religionList.isNotEmpty

    || homeservice.saveprefdata1.value.smokeList.isNotEmpty
    ){
      
    List<NewUserModel> getdata=await   homeservice.getalluserdata(gender:widget. userSave.gender=="male"?"female":"male",
       email:widget. userSave.email!, religion:widget. userSave.religion!,
        page: pagecount, ages:homeservice.saveprefdata1.value.ageList ,
         religionList: homeservice.saveprefdata1.value.religionList,
          kundaliDoshList: homeservice.saveprefdata1.value.kundaliDoshList,
          citylocation: homeservice.saveprefdata1.value.citylocation,
          statelocation: homeservice.saveprefdata1.value.statelocation,
           maritalStatusList: homeservice.saveprefdata1.value.maritalStatusList,
            dietList: homeservice.saveprefdata1.value.dietList,
             drinkList: homeservice.saveprefdata1.value.drinkList, 
            smokeList: homeservice.saveprefdata1.value.smokeList,
             disabilityList: homeservice.saveprefdata1.value.disabilityList, 
            heightList: homeservice.saveprefdata1.value.heightList, 
            educationList: homeservice.saveprefdata1.value.educationList,
             professionList: homeservice.saveprefdata1.value.professionList,
              incomeList: homeservice.saveprefdata1.value.incomeList,
              location: homeservice.saveprefdata1.value.location);
                 List<Matchusermodel> profilematch =
                                    await Future.wait(
                                  getdata.map((user) async {
                                    double distance = await ProfileMatch()
                                        .getallusermatch(user,widget.userSave);
                                    return Matchusermodel(
                                        kundalimatch: distance.toInt(),
                                        newUserModel: user);
                                  }),
                                );
                                profilematch.sort(
                                    (a, b) => b.kundalimatch - a.kundalimatch);
                                    print("******error");
                                for (var i = 0; i < profilematch.length; i++) {
                                  newuserlists
                                      .add(profilematch[i].newUserModel);
                                }
    }else{
      print("somelsj;aflkd");
      print(pagecount);
       List<NewUserModel> getdata= await homeservice.getalluserdata(page: pagecount,
       gender: widget.userSave.gender=="male"? "female":"male",
      ages:  ["18", "70"],
      dietList: [],
      citylocation: [],
      statelocation: [],
      disabilityList:[],
      drinkList: [],
      educationList: [],
      email: widget.userSave.email,
       heightList: [],
      incomeList: [],
      kundaliDoshList: [], 
      location: [],
      maritalStatusList: []
      ,professionList: [],
      religion: widget.userSave.religion,religionList: [],
      smokeList: []);
         List<Matchusermodel> profilematch =
                                    await Future.wait(
                                  getdata.map((user) async {
                                    double distance = await ProfileMatch()
                                        .getallusermatch(user,widget.userSave);
                                    return Matchusermodel(
                                        kundalimatch: distance.toInt(),
                                        newUserModel: user);
                                  }),
                                );
                                profilematch.sort(
                                    (a, b) => b.kundalimatch - a.kundalimatch);
                                    print("******error");
                                    print(getdata);
                                for (var i = 0; i < profilematch.length; i++) {
                                  newuserlists
                                      .add(profilematch[i].newUserModel);
                                }
    }
                              
                              pagecount++;
                            _ispageLoading = false;
                            setState(() {});
                              }
                            
                          

                            
                          },
                          itemBuilder: (BuildContext context, int index) {
                            // if (_ispageLoading == true) {
                            //   return Center(
                            //     child: CircularProgressIndicator(
                            //       color: main_color,
                            //     ),
                            //   );
                            // } else {
                              if (index == newuserlists.length) {
                                // Show the SavePreferencesError widget at the end
                                return widget.notiPage == false
                                    ? SavePreferencesError(
                                        
                                      )
                                    :Text("");
                              } else {
                                return Column(children: <Widget>[
                                  Expanded(
                                    child: MatchProfilePage(
                                     currentuser: widget.userSave,
                                        index: index,
                                    userSave: newuserlists[index],
                                    controller: controller,
                                    pushchat: pushChatPage),
                                  ),
                                ]);
                              }
                            // }
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: newuserlists.length+1 ,
                        ),
        //               PageView.builder(
                        
        //                   controller: controller,
        //                   onPageChanged: (index) {

        //                   },
        //                   itemBuilder: (BuildContext context, int index) {
        //                     final userIndex = index % newuserlists.length;
        // final user = newuserlists[userIndex];
        //                     return Column(children: <Widget>[
                         
                            
        //                       Expanded(
        //                         child: MatchProfilePage(
        //                           currentuser: widget.userSave,
        //                             index: index,
        //                             userSave: user,
        //                             controller: controller,
        //                             pushchat: pushChatPage),
        //                       ),
                              
          
        //                     ]);
        //                   },
        //                   // itemCount: newuserlists.length+1,
        //                 ),
                  
          
                   Positioned(
                      left: MediaQuery.of(context).size.width * 0.009,
                      top: MediaQuery.of(context).size.height * 0.09,
                      child: IconButton(
                        icon: Icon(
                          // Icons.more_vert_outlined,//for three dots
                          Icons.arrow_back_ios, //for three lines
                          size: 25,
                  color: Colors.white,

                          shadows: <Shadow>[
                    Shadow(color: Colors.black, blurRadius: 15.0)
                  ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  
             
            Positioned(
              left: MediaQuery.of(context).size.width * 0.0006,
              top: MediaQuery.of(context).size.height * 0.04,
              child: IconButton(
                icon: const Icon(
                  // Icons.more_vert_outlined,//for three dots
                  Icons.menu, //for three lines
                  size: 20,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(color: Colors.black, blurRadius: 15.0)
                  ],
                ),
                onPressed: () {
                  numofnoti = 0;
                  setState(() {});
                  if (listofadminpermissions!.contains("Can See left menu") ||
                      listofadminpermissions!
                          .contains("Can See user’s full name") ||
                      listofadminpermissions!.contains("All")) {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "",
                        userimage: "",
                        title:
                            "${userSave.displayName} CLICK ON THE LEFT MENU ",
                        email: userSave.email!,
                        subtitle: "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfile(
                                  profilecomp: profilePercentage,
                                  userSave: widget.userSave!,
                                  isDelete:
                                     false,
                                )));
                  }

                  // Get.to(() => const MyProfile(),
                  //     transition: Transition.zoom);
                },
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.004,
              top: MediaQuery.of(context).size.height * 0.04,
              child: IconButton(
                icon: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(
                        // Icons.more_vert_outlined,//for three dots
                        FontAwesomeIcons.bell, //for three lines
                        size: 22,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(color: Colors.black, blurRadius: 15.0)
                        ],
                      ),
                    ),
                    if (_unreadCount >= 0)
                      Positioned(
                        // right: 2.0,
                        // top: 1.0,
                        right: 1.0,
                        top: 1.0,
                        child: numofnoti == 0
                            ? const Text("")
                            : Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: main_color, shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '$numofnoti',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 6.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),
                onPressed: () {
                  if (listofadminpermissions!
                          .contains("Can see main admin activities") ||
                      listofadminpermissions!
                          .contains("Can see sub admin activities") ||
                      listofadminpermissions!.contains("All")) {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "",
                        userimage: "",
                        title: "${userSave.displayName} SEEN NOTIFICATION",
                        email: userSave.email!,
                        subtitle: "");
                    NotificationFunction.setNotification(
                      "admin",
                      "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave.uid!.length - 5)} SEEN NOTIFICATIONS",
                      'notificationbell',
                    );
                    NotiService().updatenoti();
                    // numofnoti = 0;
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavHome(
                                  newUserModel: widget.userSave,
                                )));
                  }
                },
              ),
            ),
              Positioned(
                right: 15.0,
                top: 90.0,
                child: GestureDetector(
                  onTap: () {
                    SearchProfile().addtoadminnotification(
                        userid: "2345",
                        useremail: "lksjflajk",
                        userimage: "",
                        title: "${userSave.displayName} CLICK ON RIGHT MENU",
                        email: userSave.email!,
                        subtitle: "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterC()));
                  },
                  child: const Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 15.0,
                top: 220,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!.contains("Can See Sort") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title: "${userSave.displayName} CLICK ON SORT",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SortProfileScreen()));
                    }
                  },
                  child: const Icon(
                    FontAwesomeIcons.sort,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 15.0,
                top: 130.0,
                child: GestureDetector(
                  onTap: () {
                    print(listofadminpermissions);
                    if (listofadminpermissions!
                            .contains("Can See Search Bar") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title:
                              "${userSave.displayName} CLICK ON ADMIN SEARCH BAR ",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()));
                    }

                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: const Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            Positioned(
                right: 15.0,
                top: 170.0,
                child: GestureDetector(
                  onTap: () {
                    if (listofadminpermissions!
                            .contains("Can Create Profile") ||
                        listofadminpermissions!.contains("All")) {
                      SearchProfile().addtoadminnotification(
                          userid: "",
                          useremail: userSave.email!,
                          userimage: userSave.imageUrls!.isEmpty
                              ? ""
                              : userSave.imageUrls![0],
                          title:
                              "${userSave.displayName} CLICK ON PROFILE CREATE BY ADMIN",
                          email: userSave.email!,
                          subtitle: "");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LetsStart()));
                    }
                    // Get.to(() => const MyProfile(),
                    //     transition: Transition.zoom);
                  },
                  child: const Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.white,
                    size: 18,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}

