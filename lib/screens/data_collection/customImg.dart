// import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Assets/ImageDart/images.dart';
import 'package:path_provider/path_provider.dart';
import '../../Assets/Error.dart';
import '../../Storage/storage_repo.dart';
import '../../globalVars.dart';
import '../../models/new_user_model.dart';
import '../../models/shared_pref.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../sendUtils/notiFunction.dart';
import '../service/search_profile.dart';

class CustomImageContainer extends StatefulWidget {
  const CustomImageContainer({
    Key? key,
    this.imageUrl,
    required this.num,
    required this.isBlur,
    this.userSave,
  }) : super(key: key);
  final String? imageUrl;
  final int num;
  final NewUserModel? userSave;
  final bool isBlur;
  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  late final String? imageUrl;
  late final int num;
  bool imagepicked = false;
  var imgPath = File("/");
  @override
  initState() {
    super.initState();
    num = widget.num;
    if (widget.imageUrl == null) {
      imageUrl = "";
    } else {
      imageUrl = widget.imageUrl;
    }
  }

  final imageurls = ImageUrls();

  Future<void> onPressed() async {
    // print("clicked");
    CroppedFile? croppedFile;
    ImagePicker _picker = ImagePicker();
    // final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    final _image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (_image == null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SnackBarContent(
                error_text: "No Image was Selected",
                appreciation: "",
                icon: Icons.error,
                sec: 1,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
    } else {
      // imagepicked = true;
//function
      try {
        croppedFile = await ImageCropper().cropImage(
          sourcePath: _image.path,
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
      } catch (e) {
        print(e);
      }
      if (croppedFile != null) {
        setState(() {
          imagepicked = true;
        });
        // print("cropped image path : ${croppedFile!.path}");
        setState(() {
          // imgPath = File(_image.path);
          imgPath = File(croppedFile!.path);
        });
        print(croppedFile);
        StorageRepo().uploadImage(
          croppedFile,
        );
        // print("cropped image name : ");
        // StorageRepo().uploadImage(croppedFile);

        Future.delayed(const Duration(seconds: 1), () {
          imagepicked = false;
        });
        SearchProfile().addtoadminnotification(
            userid: widget.userSave!.id!,
            useremail: widget.userSave!.email!,
            userimage: widget.userSave!.imageurls!.isEmpty
                ? ""
                : widget.userSave!.imageurls![0],
            title: "${userSave.displayName} UPLOAD PHOTO SUCCESSFULLY",
            email: userSave.email!,
            subtitle: "");
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "No Image was Selected",
                  appreciation: "",
                  icon: Icons.error,
                  sec: 1,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    }
    // print("something is happening");
  }

  Future<XFile?> urlToXFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/filename.png'; // Set the desired file name and extension
        File file = File(filePath);

        await file.writeAsBytes(bytes, flush: true);

        return XFile(file.path);
      }
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }

  onPressed2(imageurl) async {
    XFile? xFile = await urlToXFile(imageurl);
    //  ImageUrls().deleteLink(num);
    // // print("num : $num");
    // CroppedFile? croppedFile;
    // ImagePicker _picker = ImagePicker();
    // // final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    // final _image = await _picker.pickImage(
    //   source: ImageSource.gallery,
    //   imageQuality: 30,
    // );
    // if (_image == null) {
    //   showDialog(
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: SnackBarContent(
    //             error_text: "No Image was Selected",
    //             appreciation: "",
    //             icon: Icons.error,
    //             sec: 1,
    //           ),
    //           backgroundColor: Colors.transparent,
    //           elevation: 0,
    //         );
    //       });
    // } else {
    // imagepicked = true;
//function
    print(imageurl);
    CroppedFile? croppedFile;
    try {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: xFile!.path,
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
    } catch (e) {
      print(e);
    }
    if (croppedFile != null) {
      setState(() {
        imagepicked = true;
      });
      // print("cropped image path : ${croppedFile!.path}");
      setState(() {
        // imgPath = File(_image.path);
        imgPath = File(croppedFile!.path);
      });
      print(croppedFile);
      StorageRepo().uploadImage(
        croppedFile,
      );
      // print("cropped image name : ");
      // StorageRepo().uploadImage(croppedFile);
      SearchProfile().addtoadminnotification(
          userid: widget.userSave!.id!,
          useremail: widget.userSave!.email!,
          userimage: widget.userSave!.imageurls!.isEmpty
              ? ""
              : widget.userSave!.imageurls![0],
          title:
              "${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} CROP PHOTO SUCCESFULLY OF ${widget.userSave!.puid} ${widget.userSave!.name!.substring(0, 1)} ${widget.userSave!.surname!.toUpperCase()}",
          email: userSave.email!,
          subtitle: "");
      Future.delayed(const Duration(seconds: 1), () {
        imagepicked = false;
      });

      // NotificationFunction.setNotification(
      //   "admin",
      //   "${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} ${userSave.puid} EDIT PROFILE UPLOAD PHOTO",
      //   'editphoto',
      // );
      // NotificationFunction.setNotification(
      //   "user1",
      //   "PHOTO UPLOADED SUCCESSFULLY",
      //   'photoupload',
      // );
      ImageUrls().deleteLink(num);
    }
  }

  deleteImg() async {
    SharedPref sharedPref = SharedPref();

    print("deleting image");

    try {
      ImageUrls().deleteLink(num);
      SearchProfile().addtoadminnotification(
          userid: widget.userSave!.id!,
          useremail: widget.userSave!.email!,
          userimage: widget.userSave!.imageurls!.isEmpty
              ? ""
              : widget.userSave!.imageurls![0],
          title:
              "${userSave.name!.substring(0, 1)} ${userSave.surname!.toUpperCase()} DELETE PHOTO SUCCESFULLY OF ${widget.userSave!.puid} ${widget.userSave!.name!.substring(0, 1)} ${widget.userSave!.surname!.toUpperCase()}",
          email: userSave.email!,
          subtitle: "");
    } catch (Excepetion) {
      print(Excepetion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ImageUrls(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          final urls = value as List<String>;
          var imageCount = imageurls.length;
          var url = (imageurls.imageUrl(atIndex: num) == null)
              ? ""
              : imageurls.imageUrl(atIndex: num);

          return (!imagepicked)
              ? (imageCount <= num)
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: (imageUrl == "")
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: FloatingActionButton(
                                heroTag: "btn$num",
                                onPressed: onPressed,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    // child: Image.network(url!, fit: BoxFit.cover)
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: NetworkImage(url!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      // make sure we apply clip it properly
                                      child: widget.isBlur == true
                                          ? BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10, sigmaY: 10),
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                              ),
                                            )
                                          : Center(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          onPressed2(url);
                                        },
                                        child: Icon(
                                          Icons.abc,
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 15.0)
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: deleteImg,
                                          child: Image.asset(
                                              "images/icons/delete.png"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            // child: Image.network(url!, fit: BoxFit.cover)
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: NetworkImage(url!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ClipRRect(
                              // make sure we apply clip it properly
                              child: widget.isBlur == true
                                  ? BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                    )
                                  : Center(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onPressed2(url);
                                  },
                                  child: Image.asset("images/icons/edit.png"),
                                ),
                                GestureDetector(
                                    onTap: deleteImg,
                                    child:
                                        Image.asset("images/icons/delete.png"))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
              : Container(
                  height: 75,
                  width: 75,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(main_color)),
                );
        });
  }
}

class CustomImageContainer1 extends StatefulWidget {
  const CustomImageContainer1({
    Key? key,
    this.imageUrl,
    required this.num,
    required this.isBlur,
  }) : super(key: key);
  final String? imageUrl;
  final int num;
  final bool isBlur;
  @override
  State<CustomImageContainer1> createState() => _CustomImageContainer1State();
}

class _CustomImageContainer1State extends State<CustomImageContainer1> {
  late final String? imageUrl;
  late final int num;
  bool imagepicked = false;
  var imgPath = File("/");
  @override
  initState() {
    super.initState();
    num = widget.num;
    print(widget.imageUrl);
    if (widget.imageUrl == null) {
      imageUrl = "";
    } else {
      imageUrl = widget.imageUrl;
    }
  }

  final imageurls = ImageUrls1();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ImageUrls1(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          final urls = value as List<String>;
          var imageCount = imageurls.length;
          var url = (imageurls.imageUrl(atIndex: num) == null)
              ? ""
              : imageurls.imageUrl(atIndex: num);
          print(url);
          return (!imagepicked)
              ? (imageCount <= num)
                  ? Container(
                      height: 100,
                      width: 100,
                      child: (imageUrl == "")
                          ? SizedBox(
                              height: 100,
                              width: 100,
                              child: FloatingActionButton(
                                heroTag: "btn$num",
                                onPressed: () {},
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    // child: Image.network(url!, fit: BoxFit.cover)
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: NetworkImage(url!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      // make sure we apply clip it properly
                                      child: widget.isBlur == true
                                          ? BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10, sigmaY: 10),
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                              ),
                                            )
                                          : Center(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              "images/icons/edit.png")),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              "images/icons/delete.png"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            // child: Image.network(url!, fit: BoxFit.cover)
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: NetworkImage(url!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ClipRRect(
                              // make sure we apply clip it properly
                              child: widget.isBlur == true
                                  ? BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                    )
                                  : Center(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [],
                          )
                        ],
                      ),
                    )
              : Container(
                  height: 75,
                  width: 75,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(main_color)),
                );
        });
  }
}
