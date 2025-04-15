import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/models/send_link_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';

import '../../service/search_profile.dart';
import '../navigator.dart';

class SendLink extends StatefulWidget {
  final NewUserModel newUserModel;
  const SendLink({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<SendLink> createState() => _ReligionState();
}

class _ReligionState extends State<SendLink> {
  int value = 0;
  var supprotdata;
  void getallsupprot() async {
    supprotdata = await SearchProfile().getsupports(widget!.newUserModel.id);
    setState(() {});
  }

  int aboutme = 0;
  int patnerpref = 0;
  int video = 0;
  int savepref = 0;
  int useapp = 0;
  int professionmanualy = 0;
  int educationmanualy = 0;
  int askRating = 0;
  int uploadPhoto = 0;
  int biodata = 0;
  int shareapp = 0;
  int support = 0;
  List<SendLinkModel> data = [];
  void getallsendlink() async {
    data = await AdminService().getsendlink(widget.newUserModel.email);
    SendLinkModel sendLinkModel = SendLinkModel(
        aboutme: 34343434,
        patnerpref: patnerpref,
        success: 9,
        video: video,
        name: "",
        status: "",
        savepref: savepref,
        useapp: useapp,
        professionManually: 0,
        educationManually: 0,
        createdAt: "",
        rating: 0,
        photo: 0,
        biodata: biodata,
        share: 0,
        support: support);
    data = [sendLinkModel, ...data];
    setState(() {});
//   if(data!=null){
// aboutme=data["aboutme"];
// patnerpref=data["patnerpref"];
// video=data["video"];
// savepref=data["savepref"];
// useapp=data["useapp"];
// professionmanualy=data["professionManually"];
// educationmanualy=data["educationManually"];
// askRating=data["rating"];
// uploadPhoto=data["photo"];
// biodata=data["biodata"];
// shareapp=data["share"];
// support=data["support"];

//   }
    setState(() {});
  }

  @override
  void initState() {
    getallsendlink();
    getallsupprot();
    super.initState();
  }

  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        if (index == 1) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme + 1,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 2) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref + 1,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 5) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref + 1,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 6) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp + 1,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 7) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy + 1,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 8) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy + 1,
              rating: askRating,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 9) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating + 1,
              photo: uploadPhoto,
              biodata: biodata,
              support: support);
        } else if (index == 10) {
          AdminService().countsendlink(
              email: widget.newUserModel.email,
              aboutme: aboutme,
              patnerpref: patnerpref,
              success: 0,
              video: video,
              savepref: savepref,
              useapp: useapp,
              professionManually: professionmanualy,
              educationManually: educationmanualy,
              rating: askRating,
              photo: uploadPhoto + 1,
              biodata: biodata,
              support: support);
        }
        setState(() {
          if (text == "To Upload Success Story") {
          } else {
            if (index == 11 && widget.newUserModel.status == "") {
              SearchProfile().addtoadminnotification(
                  userid: widget.newUserModel!.id!,
                  useremail: widget.newUserModel!.email!,
                  userimage: widget.newUserModel!.imageurls!.isEmpty
                      ? ""
                      : widget.newUserModel!.imageurls![0],
                  title:
                      '${userSave.displayName} TRIED TO SEND LINK TO ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} "$text" (ERROR)',
                  email: userSave.email!,
                  subtitle: "");
              AdminService().countsendlink(
                  email: widget.newUserModel.email,
                  aboutme: aboutme,
                  patnerpref: patnerpref,
                  success: 0,
                  video: video,
                  savepref: savepref,
                  useapp: useapp,
                  professionManually: professionmanualy,
                  educationManually: educationmanualy,
                  rating: askRating,
                  photo: uploadPhoto,
                  biodata: biodata + 1,
                  support: support);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Please Approve The User First",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            } else if (index == 4 && widget.newUserModel.imageurls.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Profile Don't Have Photo",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            } else if (index == 4 && widget.newUserModel.videolink != "") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Profile Already Have Video",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            } else if (index == 4 &&
                widget.newUserModel.verifiedstatus == "verified") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Profile is Already Verified",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            } else if (index == 13) {
              if (supprotdata.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    content: const SnackBarContent(
                      error_text: "Profile Doesn't Have Used Supprot",
                      appreciation: "",
                      icon: Icons.error,
                      sec: 2,
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.06),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              } else if (supprotdata[0]["isAdmin"]) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    content: const SnackBarContent(
                      error_text: "Already Replied",
                      appreciation: "",
                      icon: Icons.error,
                      sec: 2,
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.06),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              } else {
                if (index == 4) {
                  AdminService().countsendlink(
                      email: widget.newUserModel.email,
                      aboutme: aboutme,
                      patnerpref: patnerpref,
                      success: 0,
                      video: video + 1,
                      savepref: savepref,
                      useapp: useapp,
                      professionManually: professionmanualy,
                      educationManually: educationmanualy,
                      rating: askRating,
                      photo: uploadPhoto,
                      biodata: biodata,
                      support: support);
                } else if (index == 13) {
                  AdminService().countsendlink(
                      email: widget.newUserModel.email,
                      aboutme: aboutme,
                      patnerpref: patnerpref,
                      success: 0,
                      video: video + 1,
                      savepref: savepref,
                      useapp: useapp,
                      professionManually: professionmanualy,
                      educationManually: educationmanualy,
                      rating: askRating,
                      photo: uploadPhoto,
                      biodata: biodata,
                      support: support + 1);
                }
                SearchProfile().addtoadminnotification(
                    userid: widget.newUserModel!.id!,
                    useremail: widget.newUserModel!.email!,
                    userimage: widget.newUserModel!.imageurls!.isEmpty
                        ? ""
                        : widget.newUserModel!.imageurls![0],
                    title:
                        '${userSave.displayName} SEND LINK TO ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} "$text"',
                    email: userSave.email!,
                    subtitle: "");
                AdminService().addtosendlink(
                    email: widget.newUserModel.email, value: text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    content: const SnackBarContent(
                      error_text: "Send link successfully",
                      appreciation: "",
                      icon: Icons.check_circle,
                      sec: 2,
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.06),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyProfile(
                              profilecomp: 50,
                              userSave: widget.newUserModel,
                            )));
              }
            } else {
              SearchProfile().addtoadminnotification(
                  userid: widget.newUserModel!.id!,
                  useremail: widget.newUserModel!.email!,
                  userimage: widget.newUserModel!.imageurls!.isEmpty
                      ? ""
                      : widget.newUserModel!.imageurls![0],
                  title:
                      '${userSave.displayName} SEND LINK TO ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} "$text"',
                  email: userSave.email!,
                  subtitle: "");
              AdminService()
                  .addtosendlink(email: widget.newUserModel.email, value: text);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Send link successfully",
                    appreciation: "",
                    icon: Icons.check_circle,
                    sec: 2,
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.06),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyProfile(
                            profilecomp: 50,
                            userSave: widget.newUserModel,
                          )));
            }

            //SmokeStatus = text;
            value = index;
            /*setData().then({
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => Disability()))
          });*/
          }
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? main_color : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Send Link", iconImage: "images/icons/link.png"),
        // appBar: CupertinoNavigationBar(
        //   leading: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Icon(
        //       Icons.arrow_back_ios_new,
        //       color: main_color,
        //       size: 25,
        //     ),
        //   ),
        //   middle: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         margin: EdgeInsets.only(right: 20),
        //         child: DefaultTextStyle(
        //             style: GoogleFonts.poppins(color: main_color, fontSize: 25),
        //             child: Text("Send Link")),
        //       )
        //     ],
        //   ),
        //   previousPageTitle: "",
        // ),
        body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {},
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (data[index].aboutme == 34343434) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                    
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Improve About Me ($aboutme)", 1)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Improve About Partner Preference ($patnerpref)",
                              2)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Upload Success Story", 3)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Upload Video ($video)", 4)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Save Preference ($savepref)", 5)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Learn How To Use App ($useapp)", 6)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Save Profession Manually ($professionmanualy)",
                              7)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Save Education Manually ($educationmanualy)",
                              8)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Ask Rating ($askRating)", 9)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Upload Photo ($uploadPhoto)", 10)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Download Biodata ($biodata)", 11)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Share App ($shareapp)", 12)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomRadioButton(
                              "To Show Support Reply ($support)", 13)),
                             data.length>1?  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                            IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                              _pageController.nextPage( duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,)
                            }),
                      ],
                    ),
                  ),
                )
                :Center(),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Improve About Me (${data[index].aboutme})", 1)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Improve About Partner Preference (${data[index].patnerpref})",
                                            2)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Upload Success Story", 3)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Upload Video (${data[index].video})", 4)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Save Preference (${data[index].savepref})", 5)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Learn How To Use App (${data[index].useapp})", 6)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Save Profession Manually (${data[index].professionManually})",
                                            7)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Save Education Manually (${data[index].educationManually})",
                                            8)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Ask Rating (${data[index].rating})", 9)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Upload Photo (${data[index].photo})", 10)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Download Biodata (${data[index].biodata})", 11)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Share App (${data[index].share})", 12)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: CustomRadioButton(
                                            "To Show Support Reply (${data[index].support})", 13)),
                                             Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                                   index==0?Center():     IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>{
                                            _pageController.previousPage( duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,)
                                          }),              
                                          IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                                            _pageController.nextPage( duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,)
                                          }),
                                    ],
                                  ),
                                ),
              ),
                                            SizedBox(height: 10,),
                                               Text(data[index].status,style:  TextStyle(
                                              fontFamily: 'Serif',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color:data[index].status=="Pending"?Colors.red: main_color,
                                            ),),
                                              Text("Created By ${data[index].name}",style:  TextStyle(
                                              fontFamily: 'Serif',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),),
                                  Text( DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(data[index].createdAt).toLocal()),style: TextStyle(
                                              fontFamily: 'Serif',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),),
                                
                                  ],
                                ),
              );
              
            }));
  }
}
