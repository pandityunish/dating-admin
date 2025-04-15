import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/service/admin_service.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/showAd.dart';
import 'package:matrimony_admin/screens/profie_types/advertisment_types/user_ads_details.dart';

import '../../../Assets/ayushWidget/big_text.dart';
import '../../../models/ads_model.dart';
import '../../service/search_profile.dart';
import '../ads_service.dart';

class ShowUserAds extends StatefulWidget {
  final NewUserModel newUserModel;
  final String id;
  const ShowUserAds({super.key, required this.id, required this.newUserModel});

  @override
  State<ShowUserAds> createState() => _AdvertisementDetailsState();
}

class _AdvertisementDetailsState extends State<ShowUserAds> {
  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    print(picked);
  }

  XFile? image;
  List<AdsModel> allads = [];
  void pickimage() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = pickimage;
    setState(() {});
  }

  getallads() {
  widget.newUserModel.showads!
      .sort((a, b) => b.createdAt.compareTo(a.createdAt));
  allads = widget.newUserModel.showads!
      .where((obj) => obj.adsid == widget.id)
      .toList();
  var firstInactiveAd = allads.firstWhereOrNull(
    (item) => item.isActive == false,
  );
  if (firstInactiveAd != null && !firstInactiveAd.isActive) {
    AdsModel adsModel = AdsModel(
        image: "image",
        isActive: false,
        createdAt: "",
        adsid: "",
        clicked: 0,
        seen: 0,
        id: "",
        description: "",
        video: "",
        name: "");
    allads = [adsModel, ...allads];
  }
  setState(() {});
  print(allads);
  getthedetails();
}

  void getthedetails() async {
    List<AdsModel> newallads = await AdsService().getallusers(adsid: widget.id);
    allads.addAll(newallads);
    setState(() {});
  }

  @override
  void initState() {
    getallads();
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController headcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.newUserModel.showads);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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

            trailing: Material(
              child: IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: main_color,
                  )),
            ),
            middle: Row(
              children: [
                BigText(
                  text: "Advertisement-${widget.id}",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),

            // TextSpan(
            //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),

            previousPageTitle: "",
          ),
          child: allads.isNotEmpty
              ? PageView.builder(
                  controller: _pageController,
                  itemCount: allads.length,
                  onPageChanged: (index) {
                    headcontroller.text = allads[index].description;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    headcontroller.text = allads[index].description;
                    return UserAdsDetails(
                        url: allads[index].image,
                        ads: allads[index],
                        id: allads[index].id,
                        pageController: _pageController,
                        index: index,
                        adscount: index,
                        delete: () async {
                          SearchProfile().addtoadminnotification(
                              userid: "",
                              useremail: "1234",
                              userimage: "1234",
                              title:
                                  '${userSave.displayName} DELETE ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} ADVERTISEMENT-${widget.id}',
                              email: "",
                              subtitle: "");
                          AdminService().removefromads(
                            adsid: allads[index].id,
                            email: widget.newUserModel.email,
                          );
                          // AdsService().deleteads(id: allads[index].id);
                          allads.remove(AdsModel(
                              isActive: allads[index].isActive,
                              image: allads[index].image,
                              createdAt: allads[index].createdAt,
                              adsid: allads[index].adsid,
                              id: allads[index].id,
                              clicked: allads[index].clicked,
                              seen: allads[index].seen,
                              description: allads[index].description,
                              video: allads[index].video,
                              name: allads[index].name));
                          image = null;
                          setState(() {});
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: SnackBarContent(
                                    appreciation: "",
                                    error_text: "ADS Delete Successfully",
                                    icon: Icons.check,
                                    sec: 2,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                              });
                          Get.to(ShowAd(
                            newUserModel: widget.newUserModel,
                          ));
                        },
                        onclick: () {},
                        newUserModel: widget.newUserModel);
                  })
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            "Updated on  23 Feb 2024  14 : 58  ",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            "Total Seen 1542",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            "(Active)",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      pickimage();
                                    },
                                    icon: Icon(Icons.edit_square))
                              ],
                            )),
                        image == null
                            ? Column(
                                children: [Text("No ADS Added")],
                              )
                            : Image.file(File(image!.path)),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: headcontroller,
                            minLines: 3,
                            maxLines: 5,
                            style: TextStyle(
                                fontFamily: 'Sans-serif', fontSize: 17),
                            decoration: InputDecoration(
                              hintText: "Write Link here",
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: main_color)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: main_color)),
                              // labelText: 'Write Here',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: Get.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () async {
                                  SearchProfile().addtoadminnotification(
                                      userid: "",
                                      useremail: "",
                                      userimage: "",
                                      title:
                                          '${userSave.displayName} CREATE ADVERTISEMENT-${widget.id} FOR ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} ',
                                      email: "",
                                      subtitle: "");
                                  SearchProfile().addtoadminnotification(
                                      userid: widget.newUserModel!.id!,
                                      useremail: widget.newUserModel!.email!,
                                      userimage: widget
                                              .newUserModel!.imageurls!.isEmpty
                                          ? ""
                                          : widget.newUserModel!.imageurls![0],
                                      title:
                                          "${userSave.displayName} SHOW ADVERTISEMENT-${widget.id} TO ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid}",
                                      email: userSave.email!,
                                      subtitle: "");
                                  final cloudinary =
                                      CloudinaryPublic("dfkxcafte", "jhr5a7vo");
                                  CloudinaryResponse response =
                                      await cloudinary.uploadFile(
                                          CloudinaryFile.fromFile(image!.path,
                                              folder: "user"));
                                  String imageurl = response.secureUrl;
                                  AdminService().addtoads(
                                      adsid: widget.id,
                                      description: headcontroller.text,
                                      email: widget.newUserModel.email,
                                      image: imageurl);
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: SnackBarContent(
                                            appreciation: "",
                                            error_text:
                                                "ADS create Successfully",
                                            icon: Icons.check,
                                            sec: 2,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        );
                                      }).whenComplete(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                            EdgeInsets.symmetric(vertical: 20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            side: BorderSide(
                                                color: Colors.white))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
