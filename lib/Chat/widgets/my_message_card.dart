import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:matrimony_admin/Chat/widgets/message_video_player.dart';
import 'package:matrimony_admin/models/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/colors.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../globalVars.dart';
import '../../models/new_user_model.dart';
import '../../models/user_model.dart';
import '../../screens/profile/imageslider.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: 30,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child:identifyTextType(message) == "Website URL"
                    ? AnyLinkPreview(
                        link: message,
                        displayDirection: UIDirection.uiDirectionVertical,
                        showMultimedia: true,
                        bodyMaxLines: 5,
                        removeElevation: true,
                        backgroundColor: main_color,
                        bodyTextOverflow: TextOverflow.ellipsis,
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        bodyStyle: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    : identifyTextType(message) == "Image URL"
                        ? Image.network(
                            message,
                            height: 300,
                          )
                        : identifyTextType(message) == "Video URL"
                            ? MessageVideoPlayer(videoUrl: message)
                            : identifyTextType(message) == "Audio URL"
                                ? VoiceMessageView(
                                  backgroundColor: main_color,
                                  activeSliderColor: Colors.white, 
                                  circlesColor: Colors.black,
                                  playPauseButtonLoadingColor: const Color.fromRGBO(0, 0, 0, 1),

                                  controller: VoiceController(
                                    isFile: false,
                                    
                                    maxDuration: Duration(minutes: 5),
                                    audioSrc:
                                        message,
                                    onComplete: () {
                                      /// do something on complete
                                    },
                                    onPause: () {
                                      /// do something on pause
                                    },
                                    onPlaying: () {
                                      /// do something on playing
                                    },
                                    onError: (err) {
                                      /// do somethin on error
                                    },
                                  ),
                                 
                                  innerPadding: 12,
                                  cornerRadius: 20,
                                )
                                :  Text(
                  message,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: main_color,
                      fontFamily: 'Sans-serif'),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 8,
                        fontFamily: 'Sans-serif',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    // Icon(
                    //   Icons.done_all,
                    //   size: 20,
                    //   color: main_color,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyImageCard extends StatefulWidget {
  final String url;
  final String date;
  final String imageName;

  const MyImageCard(
      {Key? key,
      required this.url,
      required this.date,
      required this.imageName})
      : super(key: key);

  @override
  State<MyImageCard> createState() => _MyImageCardState();
}

class _MyImageCardState extends State<MyImageCard> {
  String imagepath = '';

  @override
  void initState() {
    super.initState();
    if (imgDict.doesUrlExistInSet(widget.url)) {
      setState(() {
        imagepath = imgDict.path(widget.url);
      });
    } else {
      downloadImage();
    }
  }

  downloadImage() async {
    // PermissionStatus permissionResult =
    //     await Permission.WriteExternalStorage;
    if (await Permission.storage.isGranted) {
      // code of read or write file in external storage (SD card)
      var file = await DefaultCacheManager().getSingleFile(widget.url);
      var directory = await getExternalStorageDirectory();
      var newPath = directory!.path + '/image.jpg';
      await file.copy(newPath);

      imgDict.imageDictionary!.add(ImagePathInfo(
          imageUrl: widget.url,
          imgname: widget.imageName,
          imgpath: newPath,
          timestamp: DateTime.now().millisecondsSinceEpoch));
      setState(() {
        imagepath = newPath;
      });
      SharedPref().save("imgdict", imgDict);
    } else {
      print("no permission");
      // permissionResult = await SimplePermissions.requestPermission(
      //     Permission.WriteExternalStorage);
      // downloadImage();
    }
  }

//   Future<File> getImageFile(ImageInfo imageInfo) async {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
          maxHeight: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: main_color,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 30,
                    top: 5,
                    bottom: 20,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageSliderPopUp(
                              currentindex: 0,
                              profileData: NewUserModel(About_Me: "About_Me", id: "id",
                              unapproveActivites: [],
                               Diet: "Diet", Disability: "Disability", Drink: "Drink", 
                               status: "status", Education: "Education", Height: "Height",
                               adminlat: 1231,
                               showads: [],
                               adminlng: 212,
                                Income: "Income", placeofbirth: "placeofbirth", 
                                timeofbirth: "timeofbirth", Partner_Prefs: "Partner_Prefs",
                                 Smoke: "Smoke", displayname: "displayname", email: "email",
                                  religion: "religion", name: "name", surname: "surname", 
                                  phone: "phone", gender: "gender", KundaliDosh: "KundaliDosh",
                                   MartialStatus: "MartialStatus", Profession: "Profession",
                                    Location: "Location", city: "city", state: "state", 
                                    imageurls: [], blocklists: [],
                                     reportlist: [], shortlist: [],
                                      country: "country", token: "token", puid: "puid", 
                                      dob: 34543, age: "1", lat: 0.0, lng: 0.0,
                                       verifiedstatus: "",
                                        pendingreq: [], sendreq: [],
                                         friends: [], videolink: "videolink",
                                          notifications: []),
                                  galleryItems: [widget.url],
                                )));
                      },
                      child: (imagepath == '')
                          ? Container()
                          : Image(image: AssetImage(imagepath)))
                  // child: Text(
                  //   url,
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 20,
                          color: main_color,
                          fontFamily: 'Sans-serif'),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    // Icon(
                    //   Icons.done_all,
                    //   size: 20,
                    //   color: main_color,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
