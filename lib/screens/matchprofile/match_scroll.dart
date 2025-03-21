import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as cloud;


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matrimony_admin/Assets/defaultAlgo/profileMatch.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/filterusermodel.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/matchprofile/match_profile_page.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
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
     
setState(() {
  load=true;
});
    // print("Page is Running");
    super.initState();
    
   homeservice.getusersaveprefdata1(widget.userSave.email).whenComplete((){
     getalluserlists();
   } );   
 
  
  
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
                  
              (widget.notiPage)
                  ? Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.04,
                      child: IconButton(
                        icon: Icon(
                          // Icons.more_vert_outlined,//for three dots
                          Icons.arrow_back_ios, //for three lines
                          size: 25,
                          color: main_color,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  : Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
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
                        onPressed: ()async {
                          
//  Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>  MyProfile(profilepercentage: profilepercentage,)));
                         
                          // builder: (context) => const CallSample()));

                          // Get.to(() => const MyProfile(),
                          //     transition: Transition.zoom);
                        },
                      ),
                    ),
              (widget.notiPage)
                  ? Positioned(
                      child: Container(
                      width: 0,
                      height: 0,
                    ))
                  : Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.04,
                      child: IconButton(
                        icon: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              child: const Icon(
                                // Icons.more_vert_outlined,//for three dots
                                FontAwesomeIcons.bell, //for three lines
                                size: 25,
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(color: Colors.black, blurRadius: 15.0)
                                ],
                              ),
                            ),
                            if (_unreadCount >= 0)
                              Positioned(
                                right: 6,
                                top: 5.0,
                                child: Container(
                                  height: 5,
                                  width: 5,
                                  // padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color: main_color,
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 8.0,
                                    minHeight: 8.0,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onPressed: () {
        //                   NotificationService().addtoadminnotification(
        //   userid: userSave.uid!,
        //  useremail: userSave.email!,
        //   userimage: userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0],
        //   title:  "${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} ${userSave.puid} SEEN NOTIFICATIONS");
        //                   NotificationFunction.setNotification(
        //                     "admin",
        //                     "${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} ${userSave.puid} SEEN NOTIFICATIONS",
        //                     'notificationbell',
        //                   );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const NavHome()));
                        },
                      ),
                    ),
              /*Positioned(
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.08,
                  child: IconButton(
                    FontAwesomeIcons.bell,
                    size: 20,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
    //
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}

