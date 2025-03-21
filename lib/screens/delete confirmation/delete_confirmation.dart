import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';

// import '../../Assets/G_Sign.dart' ;
import '../../Assets/ayushWidget/big_text.dart';
import '../../sendUtils/notiFunction.dart';
import '../navigation/admin_options/service/admin_service.dart';
import '../profie_types/delete_profiles.dart';
import '../search.dart';
import '../navigation/navigator.dart';

class DeleteConfirm extends StatefulWidget {
  final String delete;
  final NewUserModel newusermode;
   var userSave;
   DeleteConfirm({super.key, this.userSave, required this.newusermode, required this.delete});

  @override
  State<DeleteConfirm> createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  TextEditingController _deleteReason = TextEditingController();
  double _currentSliderValue = 0;
  double _startValue = 20.0;
  double _endValue = 90.0;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
               leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: main_color,
                size: 25,
              ),
            ),
              middle: Row(
                children: [
                  // Icon(
                  //   Icons.chevron_left,
                  //   size: 45,
                  //   color: Colors.black,
                  // ),
                  BigText(
                    text: "Delete My Profile",
                    size: 20,
                    color: main_color,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
              previousPageTitle: "",
            ),
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 10, right: 15),
                // child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 35),
                          child: Text(
                            "Why Are You Deleting Your Profile?",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 15, top: 10, bottom: 10),
                          child: Text(
                            "Please Tell us Why are you leaving us. We are Always looking to Improve Us for Our Users",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: _deleteReason,
                        minLines: 3,
                        maxLines: 5,
                        cursorColor: main_color,
                        style:
                            TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:  BorderSide(color: main_color)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(color: main_color)),
                          // labelText: 'Write Here',
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 100),
                    //   width: 200,
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(35),
                    //       image: DecorationImage(
                    //           image: AssetImage("images/bin.png"))),
                    // ),
                    // SizedBox(
                    //   height: 250,
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 50, right: 20),
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image:
                                  AssetImage("images/icons/delete_bin.png"))),
                    ),
//                      SizedBox(
//                       width: 300,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                             shadowColor: MaterialStateColor.resolveWith(
//                                 (states) => Colors.black),
//                             padding:
//                                 MaterialStateProperty.all<EdgeInsetsGeometry?>(
//                                     EdgeInsets.symmetric(vertical: 13)),
//                             shape: MaterialStateProperty
//                                 .all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(60.0),
//                                         side: BorderSide(
//                                           color: (value == false)
//                                               ? Colors.white
//                                               : main_color,
//                                         ))),
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white)),
//                         child: const Text(
//                           "Delete",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                         onPressed: () async {
//                           if(_deleteReason.text.isEmpty){
//                              showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   return const AlertDialog(
//                                     content: SnackBarContent(
//                                       error_text: "Please Enter Reason",
//                                       appreciation: "",
//                                       icon: Icons.error,
//                                       sec: 3,
//                                     ),
//                                     backgroundColor: Colors.transparent,
//                                     elevation: 0,
//                                   );
//                                 });
 
//                           }else{
//  SearchProfile().addtoadminnotification(userid: widget.newusermode!.puid!, useremail:widget.newusermode!.email!, userimage:widget.newusermode!.imageurls!.isEmpty?"":widget.newusermode!.imageurls![0], 
//   title: "${userSave.displayName} DELETE ${widget.newusermode!.name.substring(0, 1).toUpperCase()} ${widget.newusermode!.surname.toLowerCase()} ${widget.newusermode!.puid} PROFILE ${_deleteReason.text}", email: userSave.email!, subtitle: "");
//    AdminService().createeditprofile(userid: widget.newusermode.email, aboutme: widget.newusermode.About_Me!,
//  mypreference:  widget.newusermode.Partner_Prefs!, isBlur:widget.newusermode.isBlur! ,
//   editname: "Deleted by ${userSave.displayName}", dob: widget.newusermode.dob.toString(), gender: widget.newusermode.gender,
//    phone: widget.newusermode.phone, timeofbirth: widget.newusermode.timeofbirth,
//     placeofbirth: widget.newusermode.placeofbirth,
//      kundalidosh: widget.newusermode.KundaliDosh,
//       martialstatus: widget.newusermode.MartialStatus,
//        profession: widget.newusermode.Profession,
//         location1: widget.newusermode.Location, city: widget.newusermode.city,
//          state: widget.newusermode.state, 
//         country: widget.newusermode.country, name: widget.newusermode.name,
//          surname: widget.newusermode.surname,
//          lat: widget.newusermode.lat, lng: widget.newusermode.lng,
//           diet: widget.newusermode.Diet!,
//            disability: widget.newusermode.Disability!,
//           puid: widget.newusermode.puid, drink: widget.newusermode.Drink!,
//            education: widget.newusermode.Education!, height:  widget.newusermode.Height!,
//            religion:  widget.newusermode.religion!, income:  widget.newusermode.Income!, imageurls: widget.newusermode.imageurls);
//                            showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     content: SnackBarContent(
//                                       error_text: "Delete Successfully",
//                                       appreciation: "",
//                                       icon: Icons.done,
//                                       sec: 3,
//                                     ),
//                                     backgroundColor: Colors.transparent,
//                                     elevation: 0,
//                                   );
//                                 });
//                                 Navigator.pop(context);
//                                 if(widget.delete=="true"){
//   HomeService().deleteuseraccount(email: widget.newusermode.email,userSave: widget.newusermode )
//                            .whenComplete(() async{
//                            List<NewUserModel>  allusers=await SearchProfile().deleteProfiles(page: 1, searchText: "");
//                              Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => DeleteProfile(searchText: "Delete",user_list: allusers,)));
                           
//                             });
//                                 }else{
//                                     HomeService().deleteaccount(email: widget.newusermode.email,newusermodel: widget.newusermode,reasontodeleteuser: _deleteReason.text )
//                            .whenComplete(() {
//                             // Navigator.pushAndRemoveUntil(context, 
//                             // MaterialPageRoute(builder: 
//                             // (context)=>SlideProfile()),
//                             //  (route) => false);      
//                             Navigator.pop(context);    
                           
//                             });
//                                 }
//                           }
                            
 
                         

                        
//                         },
//                       ),
//                     ),
                  ],
                ),
                // ),
              ),
            )),
      ),
    );
  }
}
