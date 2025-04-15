import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/profie_types/ads_service.dart';
import 'package:matrimony_admin/screens/profie_types/advertisment_types/ads_details.dart';
import 'package:matrimony_admin/screens/profie_types/manage_advertisiment.dart';
import 'package:video_player/video_player.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../models/ads_model.dart';
import '../service/search_profile.dart';

class AdvertisementDetails extends StatefulWidget {
  final String id;
  const AdvertisementDetails({super.key, required this.id});

  @override
  State<AdvertisementDetails> createState() => _AdvertisementDetailsState();
}

class _AdvertisementDetailsState extends State<AdvertisementDetails> {
  DateTime? selectedDate = DateTime.now();
  XFile? image;

  void pickimage() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = pickimage;
    setState(() {});
  }

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
    SearchProfile().addtoadminnotification(
        userid: userSave!.puid!,
        useremail: userSave.email!,
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title:
            "${userSave.displayName} SEEN ADS OF ${DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(picked.toString()).toLocal())}",
        email: userSave.email!,
        subtitle: "");
  }

  List<AdsModel> allads = [];
 void getthedetails() async {
  allads = await AdsService().getallusers(adsid: widget.id);

  // Check if there’s at least one inactive ad
  if (allads.any((item) => item.isActive == false)) {
    var firstInactiveAd = allads.firstWhere((item) => item.isActive == false);
    AdsModel adsModel = AdsModel(
      image: "image",
      isActive: false,
      createdAt: "",
      clicked: 0,
      seen: 0,
      adsid: "",
      id: "",
      description: "",
      video: "",
      name: "",
    );
    allads = [adsModel, ...allads];
  }

  setState(() {});
}

  @override
  void initState() {
    getthedetails();
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController headcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
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
      
          trailing: IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: Icon(
                Icons.calendar_month,
                color: main_color,
              )),
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
        body: allads.isNotEmpty
            ? PageView.builder(
                controller: _pageController,
                itemCount: allads.length,
                onPageChanged: (index) {},
                itemBuilder: (BuildContext context, int index) {
                  if (allads[index].image == "image") {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           
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
                                ?  Column(
                                    children: [
                                      Text("No Ads"),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: SizedBox(
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .end,
                                            children: [
                                             
                                              IconButton(
                                                  icon: Icon(Icons
                                                      .arrow_forward_ios),
                                                  onPressed: () => {
                                                        _pageController
                                                            .nextPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves
                                                              .easeInOut,
                                                        )
                                                      }),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
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
                                      final cloudinary = CloudinaryPublic(
                                          "dfkxcafte", "jhr5a7vo");
                                      CloudinaryResponse response =
                                          await cloudinary.uploadFile(
                                              CloudinaryFile.fromFile(
                                                  image!.path,
                                                  folder: "user"));
                                      String imageurl = response.secureUrl;
                                      AdsService().createads(
                                          adsid: widget.id,
                                          image: imageurl,
                                          link: headcontroller.text,
                                          video: "");
                                      SearchProfile().addtoadminnotification(
                                          userid: userSave!.puid!,
                                          useremail: userSave.email!,
                                          userimage:
                                              userSave.imageUrls!.isEmpty
                                                  ? ""
                                                  : userSave.imageUrls![0],
                                          title:
                                              "${userSave.displayName} CREATE ADVERTISEMENT-${widget.id} IN ADVERTISEMENT",
                                          email: userSave.email!,
                                          subtitle: "");
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SnackBarContent(
                                                appreciation: "",
                                                error_text:
                                                    "Advertisement ${widget.id} Create \n Successfully",
                                                icon: Icons.check,
                                                sec: 2,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
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
                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                            EdgeInsets.symmetric(
                                                vertical: 20)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        60.0),
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
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AdsDetails(
                          url: allads[index].image,
                          ads: allads[index],
                          id: widget.id,
                          pageController: _pageController,
                          index: index,
                          adscount: allads.length,
                        )),
                  );
                })
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
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
                          ? const Column(
                              children: [
                                Text("No Ads (Active)"),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
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
                                final cloudinary =
                                    CloudinaryPublic("dfkxcafte", "jhr5a7vo");
                                CloudinaryResponse response =
                                    await cloudinary.uploadFile(
                                        CloudinaryFile.fromFile(image!.path,
                                            folder: "user"));
                                String imageurl = response.secureUrl;
                                AdsService().createads(
                                    adsid: widget.id,
                                    image: imageurl,
                                    link: headcontroller.text,
                                    video: "");
                                SearchProfile().addtoadminnotification(
                                    userid: userSave!.puid!,
                                    useremail: userSave.email!,
                                    userimage: userSave.imageUrls!.isEmpty
                                        ? ""
                                        : userSave.imageUrls![0],
                                    title:
                                        "${userSave.displayName} CREATE ADVERTISEMENT-${widget.id} IN ADVERTISEMENT",
                                    email: userSave.email!,
                                    subtitle: "");
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SnackBarContent(
                                          appreciation: "",
                                          error_text:
                                              "Advertisement ${widget.id} Create \n Successfully",
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
    );
  }
}
