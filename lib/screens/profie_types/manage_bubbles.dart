import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
import 'package:matrimony_admin/screens/profie_types/bubble_service.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../common/widgetAll/circular_bubles.dart';
import '../../globalVars.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../service/search_profile.dart';

class ManageBubbles extends StatefulWidget {
  const ManageBubbles({super.key});

  @override
  State<ManageBubbles> createState() => _ManageBubblesState();
}

class _ManageBubblesState extends State<ManageBubbles> {
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
    data = await BubbleService().getbubblesbydate(selectedDate.toString());
    SearchProfile().addtoadminnotification(
        userid: userSave!.puid!,
        useremail: userSave.email!,
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title:
            "${userSave.displayName} SEEN BUBBLE PIC OF ${DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(picked.toString()).toLocal())}",
        email: userSave.email!,
        subtitle: "");
    setState(() {});
    // getdailyuser()
  }

  XFile? image;
  XFile? image2;
  XFile? image3;
  XFile? image4;
  XFile? image5;
  XFile? image6;
  XFile? image7;
  XFile? image8;
  XFile? image9;
  XFile? image10;
  XFile? image11;
  XFile? image12;
  XFile? image13;
  XFile? image14;
  XFile? image15;
  XFile? image16;
  XFile? image17;
  var data;
  void getallbubbles() async {
    data = await BubbleService().getbubbles();
    setState(() {});
  }

  Future<String> uploadphoto(String image) async {
    final cloudinary = CloudinaryPublic("dfkxcafte", "jhr5a7vo");
    CloudinaryResponse response = await cloudinary
        .uploadFile(CloudinaryFile.fromFile(image, folder: "user"));
    String imageurl = response.secureUrl;
    return imageurl;
  }

  @override
  void initState() {
    getallbubbles();
    SearchProfile().addtoadminnotification(
        userid: userSave!.puid!,
        useremail: userSave.email!,
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title:
            "${userSave.displayName} SEEN BUBBLE PIC ACCORDING DATED ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(DateTime.now().toString()).toLocal())}",
        email: userSave.email!,
        subtitle: "");
    super.initState();
  }

  String? imageurl1;
  String? imageurl2;
  String? imageurl3;
  String? imageurl4;
  String? imageurl5;
  String? imageurl6;
  String? imageurl7;
  String? imageurl8;
  String? imageurl9;
  String? imageurl10;
  String? imageurl11;
  String? imageurl12;
  String? imageurl13;
  String? imageurl14;
  String? imageurl15;
  String? imageurl16;
Future<XFile> pickCropImage(String image)async{
 final croppedFile = await ImageCropper().cropImage(
      sourcePath: image,
     
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Free Rishtey Wala',
            toolbarColor: main_color,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            activeControlsWidgetColor: main_color,
            statusBarColor: Colors.white),
      ],
    );
    return XFile(croppedFile!.path);


}
  void pickimage() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image =await pickCropImage(pickimage!.path);
    imageurl1 = await uploadphoto(image!.path);

    setState(() {});
  }

  void pickimage2() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // image2 = pickimage;
    image2 =await pickCropImage(pickimage!.path);

    imageurl2 = await uploadphoto(image2!.path);
    setState(() {});
  }

  void pickimage3() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // image3 = pickimage;
    image3 =await pickCropImage(pickimage!.path);

    imageurl3 = await uploadphoto(image3!.path);
    setState(() {});
  }

  void pickimage4() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image4 =await pickCropImage(pickimage!.path);

    imageurl4 = await uploadphoto(image4!.path);
    
    setState(() {});
  }

  void pickimage5() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image5 =await pickCropImage(pickimage!.path);

    imageurl5 = await uploadphoto(image5!.path);
    setState(() {});
  }

  void pickimage6() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image6 =await pickCropImage(pickimage!.path);

    imageurl6 = await uploadphoto(image6!.path);
    setState(() {});
  }

  void pickimage7() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image7 =await pickCropImage(pickimage!.path);

    imageurl7 = await uploadphoto(image7!.path);
    setState(() {});
  }

  void pickimage8() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image8 =await pickCropImage(pickimage!.path);

    imageurl8 = await uploadphoto(image8!.path);
    setState(() {});
  }

  void pickimage9() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image9 =await pickCropImage(pickimage!.path);

    imageurl9 = await uploadphoto(image9!.path);
    setState(() {});
  }

  void pickimage10() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image10 =await pickCropImage(pickimage!.path);

    imageurl10 = await uploadphoto(image10!.path);
    setState(() {});
  }

  void pickimage11() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image11=await pickCropImage(pickimage!.path);

    imageurl11 = await uploadphoto(image11!.path);
    setState(() {});
  }

  void pickimage12() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image12 =await pickCropImage(pickimage!.path);

    imageurl12 = await uploadphoto(image12!.path);
    setState(() {});
  }

  void pickimage13() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image13 =await pickCropImage(pickimage!.path);

    imageurl13 = await uploadphoto(image13!.path);
    setState(() {});
  }

  void pickimage14() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image14 =await pickCropImage(pickimage!.path);

    imageurl14 = await uploadphoto(image14!.path);
    setState(() {});
  }

  void pickimage15() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image15 =await pickCropImage(pickimage!.path);

    imageurl15 = await uploadphoto(image15!.path);
    setState(() {});
  }

  void pickimage16() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image15 =await pickCropImage(pickimage!.path);

    imageurl16 = await uploadphoto(image15!.path);
    image16 = pickimage;
    setState(() {});
  }

  void pickimage17() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image17 = pickimage;
    setState(() {});
  }

  final PageController _pageController = PageController(initialPage: 0);
  void checkImages() async {
    List<String?> imageUrls = [
      imageurl1,
      imageurl2,
      imageurl3,
      imageurl4,
      imageurl5,
      imageurl6,
      imageurl7,
      imageurl8,
      imageurl9,
      imageurl10,
      imageurl11,
      imageurl12,
      imageurl13,
      imageurl14,
      imageurl15,
      imageurl16,
    ];

    List<int> nonNullImages = [];

    for (int i = 0; i < imageUrls.length; i++) {
      if (imageUrls[i] != null) {
        nonNullImages.add(i + 1); // Store image number (index + 1)
      }
    }

    if (nonNullImages.isEmpty) {
      print("No images are changed");
    } else if (nonNullImages.length == 1) {
      print("Image ${nonNullImages.first} is changed");

      SearchProfile().addtoadminnotification(
          userid: userSave!.puid!,
          useremail: userSave.email!,
          userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
          title:
              "${userSave.displayName} CHANGE ${nonNullImages.first} BUBBLE PIC ",
          email: userSave.email!,
          subtitle: "");
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SnackBarContent(
                appreciation: "",
                error_text: "${nonNullImages.first} Bubble Chnage Successfully",
                icon: Icons.check,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
    } else {
      print("Multiple image changes: ${nonNullImages.join(', ')}");
      SearchProfile().addtoadminnotification(
          userid: userSave!.puid!,
          useremail: userSave.email!,
          userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
          title: "${userSave.displayName} CHANGE (MULTIPLE) BUBBLE PIC ",
          email: userSave.email!,
          subtitle: "");
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SnackBarContent(
                appreciation: "",
                error_text: "Multiple Bubble Chnage Successfully",
                icon: Icons.check,
                sec: 2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: CupertinoNavigationBar(
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
            // middle: Icon(
            //   Icons.supervised_user_circle_outlined,
            //   // color: ma/
            //   size: 30,
            // ),
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
                  text: "Manage Bubbles",
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
          body: data == null
              ? Center()
              : PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {},
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    tz.TZDateTime indianTime = tz.TZDateTime.from(
                        DateTime.parse(data[index]["createdAt"]),
                        tz.getLocation('Asia/Kolkata'));

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/icons/free_ristawala1.png',
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles1(
                                  index: index,
                                        fileimage: image2?.path,
                                        onclick: () {
                                          pickimage2();
                                        },
                                        url: data[index]["image2"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: false),
                                        autoPlay: true)
                                    // .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image3?.path,
                                        onclick: () {
                                          pickimage3();
                                        },
                                        url: data[index]["image3"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image?.path,
                                        onclick: () {
                                          pickimage();
                                        },
                                        url: data[index]["image1"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image4?.path,
                                        onclick: () {
                                          pickimage4();
                                        },
                                        url: data[index]["image4"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image5?.path,
                                        onclick: () {
                                          pickimage5();
                                        },
                                        url: data[index]["image5"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.2, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image6?.path,
                                        onclick: () {
                                          pickimage6();
                                        },
                                        url: data[index]["image6"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image7?.path,
                                        onclick: () {
                                          pickimage7();
                                        },
                                        url: data[index]["image7"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.3, duration: 3000.ms)
                                    .then()
                                    .slideY(end: 0.3, duration: 3000.ms)
                                    .then()
                                    .slideX(end: -0.3, duration: 3000.ms)
                                    .then()
                                    .slideY(end: -0.3, duration: 3000.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image8?.path,
                                        onclick: () {
                                          pickimage8();
                                        },
                                        url: data[index]["image8"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image9?.path,
                                        onclick: () {
                                          pickimage9();
                                        },
                                        url: data[index]["image9"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.4, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.4, duration: 3000.ms)
                                    .then()
                                    .slideY(end: 0.05, duration: 1000.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image10?.path,
                                        onclick: () {
                                          pickimage10();
                                        },
                                        url: data[index]["image10"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 400.ms)
                                    .then()
                                    // .slideY(end: 0.4, duration: 400.ms)
                                    // .then()
                                    .slideX(end: -0.1, duration: 400.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 400.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image11?.path,
                                        onclick: () {
                                          pickimage11();
                                        },
                                        url: data[index]["image11"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: false),
                                        autoPlay: true)
                                    // .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                const SizedBox(
                                  width: 50,
                                ),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image12?.path,
                                        onclick: () {
                                          pickimage12();
                                        },
                                        url: data[index]["image12"])
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image13?.path,
                                        onclick: () {
                                          pickimage13();
                                        },
                                        url: data[index]["image13"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles1(
                                  index: index,

                                        fileimage: image14?.path,
                                        onclick: () {
                                          pickimage14();
                                        },
                                        url: data[index]["image14"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,
                                        fileimage: image15?.path,
                                        onclick: () {
                                          pickimage15();
                                        },
                                        url: data[index]["image15"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles1(
                                  index: index,

                                        fileimage: image16?.path,
                                        onclick: () {
                                          pickimage16();
                                        },
                                        url: data[index]["image16"])
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.2, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          index == 0
                              ? Text(
                                  "(Active)",
                                  style: TextStyle(color: main_color),
                                )
                              : Center(),
                          index == 0
                              ? Container(
                                  // margin: EdgeInsets.only(left: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.black),
                                          padding:
                                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                                  EdgeInsets.symmetric(
                                                      vertical: 14)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(60.0),
                                                  side: BorderSide(color: Colors.white))),
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                                      onPressed: () async {
                                        if (index == 0) {
                                          if (imageurl1 == null &&
                                              imageurl2 == null &&
                                              imageurl3 == null &&
                                              imageurl4 == null &&
                                              imageurl5 == null &&
                                              imageurl6 == null &&
                                              imageurl7 == null &&
                                              imageurl8 == null &&
                                              imageurl9 == null &&
                                              imageurl10 == null &&
                                              imageurl11 == null &&
                                              imageurl12 == null &&
                                              imageurl13 == null &&
                                              imageurl14 == null &&
                                              imageurl15 == null &&
                                              imageurl16 == null) {
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const AlertDialog(
                                                    content: SnackBarContent(
                                                      appreciation: "",
                                                      error_text:
                                                          "Please Make Changes",
                                                      icon: Icons.check_circle,
                                                      sec: 2,
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  );
                                                });
                                          } else {
                                            checkImages();
                                            BubbleService().updatebubbles(
                                              image1: imageurl1 ??
                                                  data[index]["image1"],
                                              image2: imageurl2 ??
                                                  data[index]["image2"],
                                              image3: imageurl3 ??
                                                  data[index]["image3"],
                                              image4: imageurl4 ??
                                                  data[index]["image4"],
                                              image5: imageurl5 ??
                                                  data[index]["image5"],
                                              image6: imageurl6 ??
                                                  data[index]["image6"],
                                              image7: imageurl7 ??
                                                  data[index]["image7"],
                                              image8: imageurl8 ??
                                                  data[index]["image8"],
                                              image9: imageurl9 ??
                                                  data[index]["image9"],
                                              image10: imageurl10 ??
                                                  data[index]["image10"],
                                              image11: imageurl11 ??
                                                  data[index]["image11"],
                                              image12: imageurl12 ??
                                                  data[index]["image12"],
                                              image13: imageurl13 ??
                                                  data[index]["image13"],
                                              image14: imageurl14 ??
                                                  data[index]["image14"],
                                              image15: imageurl15 ??
                                                  data[index]["image15"],
                                              image16: imageurl16 ??
                                                  data[index]["image16"],
                                            );
                                          }
                                        } else {
                                          print(imageurl1 ==
                                              data[index]["image1"]);
                                        }
                                      },
                                      child: Text("Save", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Serif', fontWeight: FontWeight.w700))),
                                )
                              : Center(),
                          SizedBox(
                            height: 5,
                          ),
                          index == 0
                              ? Center()
                              : Text(
                                  "Updated pic 3 By admin ${DateFormat('EEEE MMMM d y HH:mm').format(DateTime.parse(indianTime.toString()).toLocal())}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Sans-serif'),
                                ),
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
