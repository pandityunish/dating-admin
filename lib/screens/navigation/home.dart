import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart' as flutter;

import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/bio_data_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
// import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart' as pdfal;

import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../service/search_profile.dart';

ScreenshotController screenshotController = new ScreenshotController();

class PdfDesign extends StatefulWidget {
  final NewUserModel userSave;
  const PdfDesign({
    Key? key,
    required this.userSave,
  }) : super(key: key);

  @override
  State<PdfDesign> createState() => _PdfDesignState();
}

class _PdfDesignState extends State<PdfDesign> {
  bool downloadButtonVisibility = true;
  Permission? permission;
  String age = '30';
  Uint8List? _imageFile;
  bool isContactvisible = true;
  bool isSizedvisible = false;
  String getDateTime() {
    DateTime dateofbirth =
        DateTime.fromMillisecondsSinceEpoch(widget.userSave.dob!);
    var dt = dateofbirth.toString().substring(0, 10).split("-");
    var dob = "${dt[2]}-${dt[1]}-${dt[0]}";
    // String dateOfBirth = DateFormat('yyyy-MM-dd').format(now);
    // return dateOfBirth;
    return dob;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String dob = "";
  @override
  void initState() {
    getbiodata();
    DateTime dateofbirth =
        DateTime.fromMillisecondsSinceEpoch(widget.userSave.dob!);

    dob = DateFormat('yyyy-MM-dd').format(dateofbirth);
    super.initState();
  }

  List<BioDataModel> biodata = [];
  void getbiodata() async {
    try {
      List<BioDataModel> biodatas =
          await AdminService().getbiodatauser(id: widget.userSave.id);
      BioDataModel newbiodata = BioDataModel(
          aboutme: "",
          patnerpref: "",
          profession: "",
          education: "",
          createdAt: "",
          editname: "123",
          images: []);
      biodatas.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      biodata = [newbiodata, ...biodatas];
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  showdialog() {
    Get.dialog(Dialog(
      // insetPadding: EdgeInsets.symmetric(horizontal: 15),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  shadowColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          side: BorderSide(
                            color: Colors.white,
                          ))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () async {
                // if (downloadButtonVisibility == true) {
                downloadButtonVisibility = false;
                if (!mounted) return;
                setState(() {});

                await createPDF();
                SearchProfile().addtoadminnotification(
                    userid: widget.userSave!.id!,
                    useremail: widget.userSave!.email!,
                    userimage: widget.userSave!.imageurls!.isEmpty
                        ? ""
                        : widget.userSave!.imageurls![0],
                    title:
                        "${userSave.displayName} DOWNLOADS ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} BIODATA",
                    email: userSave.email!,
                    subtitle: "");
                // downloadButtonVisibility = true;
                if (!mounted) return;
                setState(() {});
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SnackBarContent(
                          error_text: "Download Successfully",
                          appreciation: "",
                          icon: Icons.done,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
                // }
              },
              child: Text(
                "Download with contact",
                style: TextStyle(
                  fontFamily: 'Sans-serif',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  shadowColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          side: BorderSide(
                            color: Colors.white,
                          ))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () async {
                // if (downloadButtonVisibility == true) {
                downloadButtonVisibility = false;
                isContactvisible = false;

                if (!mounted) return;
                setState(() {});

                await createPDF();
                // downloadButtonVisibility = true;
                if (!mounted) return;
                SearchProfile().addtoadminnotification(
                    userid: widget.userSave!.id!,
                    useremail: widget.userSave!.email!,
                    userimage: widget.userSave!.imageurls!.isEmpty
                        ? ""
                        : widget.userSave!.imageurls![0],
                    title:
                        "${userSave.displayName} DOWNLOADS ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} BIODATA (W)",
                    email: userSave.email!,
                    subtitle: "");
                setState(() {});
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SnackBarContent(
                          error_text: "Download Successfully",
                          appreciation: "",
                          icon: Icons.done,
                          sec: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      );
                    });
                // }
              },
              child: Text(
                "Download without contact",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sans-serif',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      textStyle: GoogleFonts.montserrat(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {},
            itemCount: biodata.length,
            itemBuilder: (BuildContext context, int index) {
              if (biodata[index].editname == "123") {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          width: 420,
                          height: 544,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/blackbg.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              //This is the main container for the profile image,name and titles.
                              Container(
                                width: 500,
                                child: Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/greenheaderbg.png',
                                          width: 260,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: 20,
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "MATRIMONIAL",
                                                    style: CustomTextStyle
                                                        .heavyboldwhite,
                                                  ),
                                                  Text("BIODATA",
                                                      style: CustomTextStyle
                                                          .heavyboldwhite),
                                                  SizedBox(
                                                    height: 32,
                                                  ),
                                                  isContactvisible
                                                      ? Text(
                                                          widget.userSave
                                                                  .name![0]
                                                                  .toUpperCase() +
                                                              widget.userSave
                                                                  .name!
                                                                  .substring(1),
                                                          style: CustomTextStyle
                                                              .heavyboldblue)
                                                      : Text(
                                                          widget
                                                              .userSave.name![0]
                                                              .toUpperCase(),
                                                          style: CustomTextStyle
                                                              .heavyboldblue),
                                                  Text(
                                                    widget.userSave.surname![0]
                                                            .toUpperCase() +
                                                        widget.userSave.surname!
                                                            .substring(1),
                                                    style: CustomTextStyle
                                                        .heavyboldblue,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 130,
                                          top: -3,
                                          child: Stack(children: <Widget>[
                                            Positioned(
                                              left: 15,
                                              top: 15,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                child: Image.network(
                                                  widget.userSave.imageurls![0],
                                                  width: 130,
                                                  fit: BoxFit.cover,
                                                  height: 130,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              child: Image.asset(
                                                'assets/images/circular-style.png',
                                                width: 152,
                                                height: 152,
                                              ),
                                            )
                                          ]),
                                        ),
                                        Positioned(
                                          left: 255,
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text("EDUCATION",
                                                      style: CustomTextStyle
                                                          .normalblue),
                                                  Text(
                                                    widget.userSave.Education!,
                                                    style: CustomTextStyle
                                                        .normalwhite,
                                                  ),
                                                  SizedBox(
                                                    height: 22,
                                                  ),
                                                  Text("INCOME",
                                                      style: CustomTextStyle
                                                          .normalblue),
                                                  Text(
                                                    widget.userSave.Income!,
                                                    style: CustomTextStyle
                                                        .normalwhite,
                                                  ),
                                                  SizedBox(
                                                    height: 22,
                                                  ),
                                                  Text("PROFESSION",
                                                      style: CustomTextStyle
                                                          .normalblue),
                                                  Text(
                                                    widget.userSave.Profession!,
                                                    style: CustomTextStyle
                                                        .normalwhite,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              //Container for User Details
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Left Part of User Details Strating with Gender
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Gender: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.gender!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Date of Birth: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  dob,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Place of Birth: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                SizedBox(
                                                  width: Get.width * 0.2,
                                                  child: Text(
                                                    widget
                                                        .userSave.placeofbirth!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: CustomTextStyle
                                                        .Smallnormal,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Time of Birth: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.timeofbirth!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Age: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  calculateAge(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              widget.userSave
                                                                  .dob!))
                                                      .toString(),
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Religion: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.religion!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            widget.userSave.religion == "Hindu"
                                                ? Row(
                                                    children: [
                                                      Text("Kundli Dosh: ",
                                                          style: CustomTextStyle
                                                              .Smallbold),
                                                      Text(
                                                        widget.userSave
                                                            .KundaliDosh!,
                                                        style: CustomTextStyle
                                                            .Smallnormal,
                                                      )
                                                    ],
                                                  )
                                                : Container(),

                                            Row(
                                              children: [
                                                Text("Marital Status: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget
                                                      .userSave.MartialStatus!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Diet: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.Diet!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Drink: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.Drink!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            // Row(
                                            //   children: [
                                            //     Text("Gender: ",style: CustomTextStyle.Smallbold),
                                            //     Text(, style: CustomTextStyle.Smallnormal,)
                                            //   ],
                                            // ),

                                            Row(
                                              children: [
                                                Text("Smoke: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.Smoke!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Disability: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.Disability!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Height: ",
                                                    style: CustomTextStyle
                                                        .Smallbold),
                                                Text(
                                                  widget.userSave.Height!,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 50),
                                      // Visibility(
                                      //   visible: isSizedvisible,
                                      //   child: SizedBox(
                                      //     width: 150,
                                      //   ),
                                      // ),
                                      //Contact part
                                      // Visibility(
                                      //   visible: isContactvisible,
                                      //   child:
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "CONTACT",
                                            style: CustomTextStyle.boldblue,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              // Image.asset(
                                              //   'assets/images/phone.png',
                                              //   width: 18,
                                              //   height: 18,
                                              //   fit: BoxFit.cover,
                                              // ),
                                              Container(
                                                height: 17,
                                                width: 17,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                widget.userSave.puid!,
                                                style: CustomTextStyle
                                                    .midsmallnormal,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Visibility(
                                            visible: isContactvisible,
                                            child: SizedBox(
                                              width: 150,
                                            ),
                                          ),
                                          Visibility(
                                            visible: isContactvisible,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/phone.png',
                                                      width: 18,
                                                      height: 18,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      widget.userSave.phone!,
                                                      style: CustomTextStyle
                                                          .midsmallnormal,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/email.png',
                                                      width: 17,
                                                      height: 17,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      widget.userSave.email!,
                                                      style: CustomTextStyle
                                                          .midsmallnormal,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Image.asset(
                                                'assets/images/home.png',
                                                width: 17,
                                                height: 17,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                widget.userSave.Location!,
                                                style: CustomTextStyle
                                                    .midsmallnormal,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              Container(
                                width: 325,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ABOUT ME",
                                      style: CustomTextStyle.boldblue,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (widget.userSave.About_Me == null ||
                                              widget.userSave.About_Me == "")
                                          ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                          : widget.userSave.About_Me!,
                                      style: CustomTextStyle.midsmallnormal,
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              Container(
                                width: 325,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "EXPECTATIONS",
                                      style: CustomTextStyle.boldblue,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (widget.userSave.Partner_Prefs == null ||
                                              widget.userSave.Partner_Prefs ==
                                                  "")
                                          ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                          : widget.userSave.Partner_Prefs!,
                                      style: CustomTextStyle.midsmallnormal,
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width - 120,
                                  //   height: 10,
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Image(
                                      image: AssetImage(
                                          "images/icons/free_ristawala.png"),
                                    ),
                                  ),
                                  Container(
                                      width: 95,
                                      child: Image.asset(
                                        'assets/images/qrcode.png',
                                        width: 48,
                                        height: 48,
                                        color: Colors.white.withOpacity(0.8),
                                        colorBlendMode: BlendMode.modulate,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      biodata.length > 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: SizedBox(
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    index == 0
                                        ? Center()
                                        : IconButton(
                                            icon: Icon(Icons.arrow_back_ios),
                                            onPressed: () => {
                                                  _pageController.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  )
                                                }),
                                    IconButton(
                                        icon: Icon(Icons.arrow_forward_ios),
                                        onPressed: () => {
                                              _pageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              )
                                            }),
                                  ],
                                ),
                              ),
                            )
                          : Center(),
                      SizedBox(
                        // width: MediaQuery.of(context).size.height * 0.2,
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              // padding:
                              //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                              //         EdgeInsets.symmetric(vertical: 17)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            // showdialog();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // width: MediaQuery.of(context).size.height * 0.2,
                                          width: 350,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black),
                                                // padding:
                                                //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                //         EdgeInsets.symmetric(vertical: 17)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        side: BorderSide(
                                                          color: Colors.white,
                                                        ))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                            onPressed: () async {
                                              // showdialog();
                                              AdminService().createbiodataprofile(
                                                  editname:
                                                      "Download by ${userSave.name}",
                                                  userid: widget.userSave.id,
                                                  patnerpref: widget
                                                      .userSave.Partner_Prefs!,
                                                  aboutme:
                                                      widget.userSave.About_Me!,
                                                  images:
                                                      widget.userSave.imageurls,
                                                  education: widget
                                                      .userSave.Education!,
                                                  profession: widget
                                                      .userSave.Profession);
                                              SearchProfile()
                                                  .addtoadminnotification(
                                                      userid:
                                                          widget.userSave!.id!,
                                                      useremail: widget
                                                          .userSave!.email!,
                                                      userimage: widget
                                                              .userSave!
                                                              .imageurls!
                                                              .isEmpty
                                                          ? ""
                                                          : widget.userSave!
                                                              .imageurls![0],
                                                      title:
                                                          "${userSave.displayName} DOWNLOADS ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} BIODATA",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                              if (!mounted) return;
                                              setState(() {});

                                              await createPDF();
                                              // downloadButtonVisibility = true;
                                              if (!mounted) return;
                                              setState(() {});
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SnackBarContent(
                                                        error_text:
                                                            "Download Successfully",
                                                        appreciation: "",
                                                        icon: Icons.done,
                                                        sec: 2,
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "Download with Contact",
                                              style: TextStyle(
                                                fontFamily: 'Sans-serif',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          // width: MediaQuery.of(context).size.height * 0.2,
                                          width: 380,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black),
                                                // padding:
                                                //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                //         EdgeInsets.symmetric(vertical: 17)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        side: BorderSide(
                                                          color: Colors.white,
                                                        ))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                            onPressed: () async {
                                              // showdialog();

                                              // if (downloadButtonVisibility == true) {
                                              //   downloadButtonVisibility = false;
                                              AdminService().createbiodataprofile(
                                                  editname:
                                                      "Download by ${userSave.name} (W)",
                                                  userid: widget.userSave.id,
                                                  patnerpref: widget
                                                      .userSave.Partner_Prefs!,
                                                  aboutme:
                                                      widget.userSave.About_Me!,
                                                  images:
                                                      widget.userSave.imageurls,
                                                  education: widget
                                                      .userSave.Education!,
                                                  profession: widget
                                                      .userSave.Profession);

                                              isContactvisible = false;
                                              isSizedvisible = true;
                                              if (!mounted) return;
                                              setState(() {});

                                              await createPDF();
                                              SearchProfile()
                                                  .addtoadminnotification(
                                                      userid:
                                                          widget.userSave!.id!,
                                                      useremail: widget
                                                          .userSave!.email!,
                                                      userimage: widget
                                                              .userSave!
                                                              .imageurls!
                                                              .isEmpty
                                                          ? ""
                                                          : widget.userSave!
                                                              .imageurls![0],
                                                      title:
                                                          "${userSave.displayName} DOWNLOADS(W) ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} BIODATA ",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                              // downloadButtonVisibility = true;
                                              if (!mounted) return;
                                              setState(() {});
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SnackBarContent(
                                                        error_text:
                                                            "Download Successfully",
                                                        appreciation: "",
                                                        icon: Icons.done,
                                                        sec: 2,
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    );
                                                  });

                                              // }
                                            },
                                            child: Text(
                                              "Download without Contact",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Sans-serif',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "Download",
                            style: TextStyle(
                              fontFamily: 'Sans-serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.height * 0.2,
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              // padding:
                              //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                              //         EdgeInsets.symmetric(vertical: 17)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            AdminService().createbiodataprofile(
                                editname: "Share by ${userSave.name}",
                                userid: widget.userSave.id,
                                patnerpref: widget.userSave.Partner_Prefs!,
                                aboutme: widget.userSave.About_Me!,
                                images: widget.userSave.imageurls,
                                education: widget.userSave.Education!,
                                profession: widget.userSave.Profession);

                            SearchProfile().addtoadminnotification(
                                userid: widget.userSave!.id!,
                                useremail: widget.userSave!.email!,
                                userimage: widget.userSave!.imageurls!.isEmpty
                                    ? ""
                                    : widget.userSave!.imageurls![0],
                                title:
                                    "${userSave.displayName} SHARE BIODATA OF ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} ",
                                email: userSave.email!,
                                subtitle: "");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // width: MediaQuery.of(context).size.height * 0.2,
                                          width: 300,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black),
                                                // padding:
                                                //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                //         EdgeInsets.symmetric(vertical: 17)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        side: BorderSide(
                                                          color: Colors.white,
                                                        ))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                            onPressed: () async {
                                              // showdialog();
                                              if (!mounted) return;
                                              setState(() {});
                                              await _takeScreenshotandShare();

                                              if (!mounted) return;
                                              setState(() {});
                                            },
                                            child: Text(
                                              "Share with Contact",
                                              style: TextStyle(
                                                fontFamily: 'Sans-serif',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          // width: MediaQuery.of(context).size.height * 0.2,
                                          width: 350,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shadowColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.black),
                                                // padding:
                                                //     MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                //         EdgeInsets.symmetric(vertical: 17)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        side: BorderSide(
                                                          color: Colors.white,
                                                        ))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                            onPressed: () async {
                                              AdminService().createbiodataprofile(
                                                  editname:
                                                      "Share by ${userSave.name} (W)",
                                                  userid: widget.userSave.id,
                                                  patnerpref: widget
                                                      .userSave.Partner_Prefs!,
                                                  aboutme:
                                                      widget.userSave.About_Me!,
                                                  images:
                                                      widget.userSave.imageurls,
                                                  education: widget
                                                      .userSave.Education!,
                                                  profession: widget
                                                      .userSave.Profession);

                                              // showdialog();

                                              // if (downloadButtonVisibility == true) {
                                              //   downloadButtonVisibility = false;
                                              isContactvisible = false;
                                              isSizedvisible = true;
                                              if (!mounted) return;
                                              setState(() {});
                                              SearchProfile()
                                                  .addtoadminnotification(
                                                      userid:
                                                          widget.userSave!.id!,
                                                      useremail: widget
                                                          .userSave!.email!,
                                                      userimage: widget
                                                              .userSave!
                                                              .imageurls!
                                                              .isEmpty
                                                          ? ""
                                                          : widget.userSave!
                                                              .imageurls![0],
                                                      title:
                                                          "${userSave.displayName} SHARE BIODATA(W) OF ${widget.userSave!.name.substring(0, 1).toUpperCase()} ${widget.userSave!.surname..toLowerCase()} ${widget.userSave!.puid} ",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                              await _takeScreenshotandShare();

                                              if (!mounted) return;
                                              setState(() {});

                                              // }
                                            },
                                            child: Text(
                                              "Share without Contact",
                                              style: TextStyle(
                                                fontFamily: 'Sans-serif',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "Share",
                            style: TextStyle(
                              fontFamily: 'Sans-serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }

              return Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 420,
                        height: 544,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/blackbg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            //This is the main container for the profile image,name and titles.
                            Container(
                              width: 500,
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/greenheaderbg.png',
                                        width: 260,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "MATRIMONIAL",
                                                  style: CustomTextStyle
                                                      .heavyboldwhite,
                                                ),
                                                Text("BIODATA",
                                                    style: CustomTextStyle
                                                        .heavyboldwhite),
                                                SizedBox(
                                                  height: 32,
                                                ),
                                                isContactvisible
                                                    ? Text(
                                                        widget.userSave.name![0]
                                                                .toUpperCase() +
                                                            widget
                                                                .userSave.name!
                                                                .substring(1),
                                                        style: CustomTextStyle
                                                            .heavyboldblue)
                                                    : Text(
                                                        widget.userSave.name![0]
                                                            .toUpperCase(),
                                                        style: CustomTextStyle
                                                            .heavyboldblue),
                                                Text(
                                                  widget.userSave.surname![0]
                                                          .toUpperCase() +
                                                      widget.userSave.surname!
                                                          .substring(1),
                                                  style: CustomTextStyle
                                                      .heavyboldblue,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 130,
                                        top: -3,
                                        child: Stack(children: <Widget>[
                                          Positioned(
                                            left: 15,
                                            top: 15,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: Image.network(
                                                biodata[index].images[0],
                                                width: 130,
                                                fit: BoxFit.cover,
                                                height: 130,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Image.asset(
                                              'assets/images/circular-style.png',
                                              width: 152,
                                              height: 152,
                                            ),
                                          )
                                        ]),
                                      ),
                                      Positioned(
                                        left: 255,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("EDUCATION",
                                                    style: CustomTextStyle
                                                        .normalblue),
                                                Text(
                                                  biodata[index].education!,
                                                  style: CustomTextStyle
                                                      .normalwhite,
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                ),
                                                Text("INCOME",
                                                    style: CustomTextStyle
                                                        .normalblue),
                                                Text(
                                                  widget.userSave.Income!,
                                                  style: CustomTextStyle
                                                      .normalwhite,
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                ),
                                                Text("PROFESSION",
                                                    style: CustomTextStyle
                                                        .normalblue),
                                                Text(
                                                  biodata[index].profession,
                                                  style: CustomTextStyle
                                                      .normalwhite,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //Container for User Details
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Left Part of User Details Strating with Gender
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Gender: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.gender!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Date of Birth: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                dob,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Place of Birth: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              SizedBox(
                                                width: Get.width * 0.2,
                                                child: Text(
                                                  widget.userSave.placeofbirth!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: CustomTextStyle
                                                      .Smallnormal,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Time of Birth: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.timeofbirth!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Age: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                calculateAge(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            widget
                                                                .userSave.dob!))
                                                    .toString(),
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Religion: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.religion!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          widget.userSave.religion == "Hindu"
                                              ? Row(
                                                  children: [
                                                    Text("Kundli Dosh: ",
                                                        style: CustomTextStyle
                                                            .Smallbold),
                                                    Text(
                                                      widget.userSave
                                                          .KundaliDosh!,
                                                      style: CustomTextStyle
                                                          .Smallnormal,
                                                    )
                                                  ],
                                                )
                                              : Container(),

                                          Row(
                                            children: [
                                              Text("Marital Status: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.MartialStatus!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Diet: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.Diet!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Drink: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.Drink!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          // Row(
                                          //   children: [
                                          //     Text("Gender: ",style: CustomTextStyle.Smallbold),
                                          //     Text(, style: CustomTextStyle.Smallnormal,)
                                          //   ],
                                          // ),

                                          Row(
                                            children: [
                                              Text("Smoke: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.Smoke!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Disability: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.Disability!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Height: ",
                                                  style: CustomTextStyle
                                                      .Smallbold),
                                              Text(
                                                widget.userSave.Height!,
                                                style:
                                                    CustomTextStyle.Smallnormal,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: 50),
                                    // Visibility(
                                    //   visible: isSizedvisible,
                                    //   child: SizedBox(
                                    //     width: 150,
                                    //   ),
                                    // ),
                                    //Contact part
                                    // Visibility(
                                    //   visible: isContactvisible,
                                    //   child:
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CONTACT",
                                          style: CustomTextStyle.boldblue,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            // Image.asset(
                                            //   'assets/images/phone.png',
                                            //   width: 18,
                                            //   height: 18,
                                            //   fit: BoxFit.cover,
                                            // ),
                                            Container(
                                              height: 17,
                                              width: 17,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                child: Icon(
                                                  Icons.person,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.userSave.puid!,
                                              style: CustomTextStyle
                                                  .midsmallnormal,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Visibility(
                                          visible: isContactvisible,
                                          child: SizedBox(
                                            width: 150,
                                          ),
                                        ),
                                        Visibility(
                                          visible: isContactvisible,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/phone.png',
                                                    width: 18,
                                                    height: 18,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    widget.userSave.phone!,
                                                    style: CustomTextStyle
                                                        .midsmallnormal,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/email.png',
                                                    width: 17,
                                                    height: 17,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    widget.userSave.email!,
                                                    style: CustomTextStyle
                                                        .midsmallnormal,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Image.asset(
                                              'assets/images/home.png',
                                              width: 17,
                                              height: 17,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.userSave.Location!,
                                              style: CustomTextStyle
                                                  .midsmallnormal,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            Container(
                              width: 325,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ABOUT ME",
                                    style: CustomTextStyle.boldblue,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    (biodata[index].aboutme == null ||
                                            biodata[index].aboutme == "")
                                        ? "Welcome to my profile. I'm here to find someone who appreciates authenticity and kindness. Hope you find what you're looking for."
                                        : biodata[index].aboutme,
                                    style: CustomTextStyle.midsmallnormal,
                                  )
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            Container(
                              width: 325,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "EXPECTATIONS",
                                    style: CustomTextStyle.boldblue,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    (biodata[index].patnerpref == null ||
                                            biodata[index].patnerpref == "")
                                        ? "I am looking for a meaningful connection based on mutual respect, trust and shared values. Someone who is ready to grow and learn with me on this journey I would like to Connect"
                                        : biodata[index].patnerpref,
                                    style: CustomTextStyle.midsmallnormal,
                                  )
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   width: MediaQuery.of(context).size.width - 120,
                                //   height: 10,
                                // ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Image(
                                    image: AssetImage(
                                        "images/icons/free_ristawala.png"),
                                  ),
                                ),
                                Container(
                                    width: 95,
                                    child: Image.asset(
                                      'assets/images/qrcode.png',
                                      width: 48,
                                      height: 48,
                                      color: Colors.white.withOpacity(0.8),
                                      colorBlendMode: BlendMode.modulate,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SizedBox(
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              index == 0
                                  ? Center()
                                  : IconButton(
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () => {
                                            _pageController.previousPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            )
                                          }),
                              IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () => {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        )
                                      }),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "${biodata[index].editname}",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE MMMM d y HH:mm').format(
                            DateTime.parse(biodata[index].createdAt).toLocal()),
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _takeScreenshotandShare([bool share = true]) async {
    _imageFile = null;
    print("ok");
    screenshotController
        .capture(delay: Duration(milliseconds: 500), pixelRatio: 2.0)
        .then((Uint8List? image) async {
      if (!mounted) return;
      setState(() {
        _imageFile = image;
      });

      final pdf = pw.Document(
        pageMode: PdfPageMode.fullscreen,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Image(
              pw.MemoryImage(_imageFile!),
              // width: PdfPageFormat.a4.width,
              // alignment: pw.Alignment.centerLeft,
              // height: PdfPageFormat.a4.height,
              fit: pw.BoxFit.contain,
            );
          },
        ),
      );

      // Save the PDF to a file
      final output = await getTemporaryDirectory();
      final filePath = File('${output.path}/${widget.userSave.puid}.pdf');
      await filePath.writeAsBytes(await pdf.save());

      print(filePath);

      // Convert the file to Uint8List
      List<int> fileBytes = await filePath.readAsBytes();

      // // Share the PDF file
      // await Share.file(
      //   'Free Risthey Wala',
      //   '${widget.userSave.puid}.pdf',
      //   fileBytes,
      //   'application/pdf', // MIME type for PDF
      //   text: 'Check out this PDF',
      // );
      isContactvisible = true;
      isSizedvisible = false;
      setState(() {});
    }).catchError((onError) {
      print(onError);
    });
  }

  createPDF() async {
    // await _takeScreenshotandShare(false);
    screenshotController
        .capture(delay: Duration(milliseconds: 500), pixelRatio: 2.0)
        .then((Uint8List? image) async {
      if (!mounted) return;
      setState(() {
        _imageFile = image;
      });

      final pdf = pw.Document(
        pageMode: PdfPageMode.fullscreen,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Image(
                pw.MemoryImage(
                  _imageFile!,
                ),
                // width: PdfPageFormat.a4.width,

                // // alignment: pw.Alignment.centerLeft,

                // height: PdfPageFormat.a4.height,
                fit: pw.BoxFit.contain);
          },
        ),
      );

      // Save the PDF to a file
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${widget.userSave.puid}.pdf');
      print(file);
      await file.writeAsBytes(await pdf.save());
      final result = await OpenFile.open(file.path);
      isContactvisible = true;
      isSizedvisible = false;
      setState(() {});
      // if (result.type != ResultType.done) {
      //   // Handle the error here
      //   print("Error opening the PDF: ${result.message}");
      // }
    });
// double screenWidth = MediaQuery.of(context).size.width;
// double screenHeight = MediaQuery.of(context).size.height;
// double millimetersToLogicalPixelsWidth = screenWidth / 210;  // A4 width in millimeters
// double millimetersToLogicalPixelsHeight = screenHeight / 297; // A4 height in millimeters
// double flutterA4Width = 210 * millimetersToLogicalPixelsWidth;
// double flutterA4Height = 297 * millimetersToLogicalPixelsHeight;

//     PdfDocument document = PdfDocument();
//     document.pageSettings.setMargins(0);
//     document.pageSettings.size = Size(flutterA4Width, flutterA4Height);
//     final page = document.pages.add();
//     final imageBytes = await readImageData();
//     final imageBitmap = PdfBitmap(imageBytes);

//     final imageSize =
//         Size(imageBitmap.width.toDouble(), imageBitmap.height.toDouble());
//     page.graphics.drawImage(
//         imageBitmap,
//         Rect.fromLTWH(
//             0,
//             0,
//             page.size.width,
//             imageSize.height*1.05)); //(page.size.width - (imageSize.width / imageSize.height * page.size.height)) /2  //imageSize.width / imageSize.height * page.size.height  //page.size.height

//     List<int> bytes = await document.save();
//     document.dispose();

//     await saveAndLaunchFile(bytes, "Resume.pdf");

//  final File imageFile = File(_imageFile);

    // Create a PDF document
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    print("Path : ${path}");
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open("$path/$fileName");
  }

  Future<Uint8List> readImageData() async {
    final directory = (await getExternalStorageDirectory())!.path;
    print("Directory : ${directory}");
    final file = File('$directory/${widget.userSave.puid}.png');
    return await file.readAsBytes();
  }
}

class CustomTextStyle {
  static const TextStyle Smallbold = TextStyle(
    fontSize: 8,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle Smallnormal = TextStyle(
    fontSize: 7,
    color: Colors.white,
  );

  static const TextStyle midsmallnormal = TextStyle(
    fontSize: 9,
    color: Colors.white,
  );

  static const TextStyle midbold = TextStyle(
    fontSize: 13,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle heavyboldwhite = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static TextStyle heavyboldblue = GoogleFonts.montserrat(
    color: Color(0xff0697d3),
    fontSize: 15.5,
    fontWeight: FontWeight.w900,
  );

  static TextStyle boldblue = GoogleFonts.montserrat(
      color: Color(0xff0697d3),
      fontSize: 14,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8);
  static TextStyle normalblue = TextStyle(
    color: Colors.blue,
    fontSize: 11,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
  );
  static TextStyle normalwhite =
      TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400);
}
