import 'dart:developer';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip_model.dart';
import 'package:matrimony_admin/screens/navigation/audio_clip/audio_clip_service.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../admin_options/service/admin_service.dart';

class AudioClipScreen extends StatefulWidget {
  String? uid;
    NewUserModel? newUserModel;

  final String isBulk;
  AudioClipScreen({super.key, required this.isBulk, this.uid,  this.newUserModel});

  @override
  State<AudioClipScreen> createState() => _AudioClipScreenState();
}

class _AudioClipScreenState extends State<AudioClipScreen> {
  String? _filePath;
  bool _isUploading = false;
  String? audiourl;
  List<AudioClipModel> allClipModel=[];
  Future<void> _pickAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        if (file.size > 1048576) {
          print('File size must be less than 1MB');
          return;
        }

        setState(() {
          _filePath = file.path;
          _isUploading = true; // Start loading
        });

        CroppedFile croppedFile = CroppedFile(file.path!);
        await uploadAudio(croppedFile);
      }
    } catch (e) {
      print('Error picking audio: $e');
    } finally {
      setState(() {
        _isUploading = false; // Stop loading regardless of success/failure
      });
    }
  }

  Future<String> uploadAudio(CroppedFile audioFile) async {
    try {
      final cloudinary = CloudinaryPublic("dfkxcafte", "jhr5a7vo");

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          audioFile.path,
          resourceType: CloudinaryResourceType.Raw,
          folder: "user_audio",
        ),
      );

      String audioUrl = response.secureUrl;
      print('Upload successful: $audioUrl');
      audiourl = audioUrl;
      setState(() {});
      return audioUrl;
    } catch (err) {
      print("Upload Error: $err");
    }
    return "";
  }

  final PageController _pageController = PageController(initialPage: 0);
  IO.Socket? socket;
  @override
  void initState() {
    super.initState();
    getallaudioClips();
    _initSocket();
  }
void getallaudioClips()async{
   AudioClipModel firstAudioClip=AudioClipModel(email: "email", audioLink: "");
  allClipModel.insert(0, firstAudioClip); 
  setState(() {
    
  });
PaginatedAudioClip? allclips= await AudioClipService(). fetchAudioClips(widget.newUserModel?.email??"");
if(allclips!=null){
  allClipModel.addAll(allclips.users);
  setState(() {});  }
}
  void _initSocket() {
    socket = IO.io("$baseurl/audioClip", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('Connected with ID: ${socket!.id}');
    });

    // Handle incoming audio request
  }

  void _sendAudio(String audioUrl) {
    socket!.emit('sendAudio', {
      'audioUrl': audioUrl,
      'recipientId': widget.uid ?? "",
    });
    AudioClipService().sendAudioClip(widget.newUserModel?.email??"", audioUrl, userSave.name??"", "pending");
     AdminService().addtosendlink(
                    email: widget.newUserModel?.email??"", value: "Audio Clip").whenComplete((){
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
                            userSave: widget.newUserModel!,
                          )));
                    });
                 
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isBulk);
    return Scaffold(
        appBar: CustomAppBar(
            title: "Send Audio Clip", iconImage: "images/icons/music.png"),
        body: PageView.builder(
          itemCount: allClipModel.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return index==0?Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            width: Get.width * 0.95,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _filePath == null
                                    ? Column(
                                        children: [
                                          IconButton(
                                            onPressed: _isUploading
                                                ? null
                                                : () {
                                                    _pickAudio();
                                                  },
                                            icon: _isUploading
                                                ? CircularProgressIndicator(
                                                    color: main_color,
                                                  )
                                                : Icon(Icons.add, size: 35),
                                          ),
                                          Text(
                                            "Upload a Audio Clip",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )
                                    : InkWell(
                                        onTap: _isUploading
                                            ? null
                                            : () {
                                                _pickAudio();
                                              },
                                        child: Column(
                                          children: [
                                            _isUploading
                                                ? CircularProgressIndicator(
                                                    color: main_color,
                                                  )
                                                : Text(
                                                    _filePath != null
                                                        ? 'Picked file: ${_filePath!.split('/').last}'
                                                        : 'No file picked.',
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ],
                                        ),
                                      ),
                              ],
                            )),
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
                                  ? Container()
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

                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.95,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            EdgeInsets.symmetric(vertical: 13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          // side: BorderSide(
                          //   color: (value == false)
                          //       ? Colors.white
                          //       : main_color,
                          // )
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text(
                      "Send ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      // }else{
                      _sendAudio(audiourl ?? "");
                      // }
                    },
                  ),
                ),
              SizedBox(height: 10,)
              ],
            ): Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            width: Get.width * 0.95,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                   Text(
                                           
                                                 'Audio file: ${allClipModel[index].audioLink.split('/').last}',
                                            
                                            textAlign: TextAlign.center,
                                          ),
                                  ],
                                ),
                              ],
                            )),
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
                                  ? Container()
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
                      index == 0
                          ? Center()
                          : Column(
                              children: [
                                Text(
                                  "${allClipModel[index].status}",
                                  style: TextStyle(color:allClipModel[index].status=="pending"? Colors.green: Colors.red),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
               
                SizedBox(
                  height: 10,
                ),
                index == 0
                    ? Center()
                    : Column(
                        children: [
                          Text("Send by ${allClipModel[index].name}"),
                          Text("21 May 2023 10:20"),
                          widget.isBulk == "false" ? Center() : Text("Bulk"),
                        ],
                      ),
                      SizedBox(height: 5,),
                widget.isBulk == "false"
                    ? Center()
                    : Column(
                        children: [
                          Text("Users"),
                          Text("Pending:200"),
                          Text("Received:100"),
                          Text("Cut:50"),
                        ],
                      )
              ],
            );
          },
        ));
  }
}
