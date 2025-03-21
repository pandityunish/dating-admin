import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/ads_model.dart';
import 'package:matrimony_admin/screens/profie_types/ads_service.dart';
import 'package:matrimony_admin/screens/profie_types/manage_advertisiment.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

import '../../service/search_profile.dart';

class AdsDetails extends StatefulWidget {
  final String url;
  final AdsModel ads;
  final String id;
  final int index;
  final PageController pageController;
  final int adscount;
  const AdsDetails({super.key, required this.url, required this.ads, required this.id, required this.pageController, required this.index, required this.adscount});

  @override
  State<AdsDetails> createState() => _AdsDetailsState();
}

class _AdsDetailsState extends State<AdsDetails> {
    VideoPlayerController? _controller;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
XFile? pickedvideo;
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    pickedvideo=video;
    if (video != null) {
      _controller = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          setState(() {}); // Update the UI after initialization.
          _controller?.play();
        });
    }
  }

   XFile? image; 

  void pickimage()async{
    final pickimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    image=pickimage;
    setState(() {
      
    });
  }
TextEditingController headcontroller=TextEditingController();

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(
            "Choose option",
            style: TextStyle(color: main_color, fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickimage();
                    Navigator.pop(context);
                  },
                  title: const Text("Photo"),
                  leading:  Icon(
                    Icons.account_box,
                    color: main_color,
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    _pickVideo();
                    Navigator.pop(context);
                  },
                  title: const Text("Video"),
                  leading:  Icon(
                    Icons.camera,
                    color: main_color,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _togglePlayPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
    });
  }
  @override
  void initState() {
   
    if (widget.ads.video != "") {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.ads.video))
        ..initialize().then((_) {
          setState(() {}); // Update the UI after initialization.
          _controller?.play();
        });
    }
      headcontroller.text=widget.ads.description;
    setState(() {
      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return      Column(
      children: [
        Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                 
                 
                  SizedBox(
                    width: Get.width,
                    child:widget. ads.isActive==true? Text(
                      "(Active)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: main_color),
                    ):Text(
                      "(Inactive)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                   SizedBox(
                    width: Get.width,
                    child: Text(
                      "Total Click (123)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: main_color),
                    )
                  ),
                  SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async{
                                AdsService().updateads(id:widget.ads.id);
                             
                                setState(() {
                                });
                                   SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!,
                               userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
  title: "${userSave.displayName} DELETE ADVERTISEMENT-${widget.id} IN ADVERTISEMENT", email: userSave.email!, subtitle: "");
                               await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return  AlertDialog(
                                            content: SnackBarContent(
                                              appreciation: "",
                                              error_text:
                                                  "Advertisement ${widget.id} Delete \n Successfully",
                                              icon: Icons.check,
                                              sec: 2,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          );
                                        }).whenComplete((){
                                        Get.to(ManageAdvertisiment());
                                        });
                                      
                              },
                              icon: Icon(Icons.delete_outlined)),
                          IconButton(
                              onPressed: () {
                               _showChoiceDialog(context);
                              }, icon: Icon(Icons.edit_square))
                        ],
                      )),
                 (image == null && _controller == null)
                  ? (widget.ads.video.isEmpty
                      ? SizedBox(
                         width: Get.width,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                               InkWell(
                                onTap: ()=>{
                              widget.   pageController.previousPage( duration: Duration(milliseconds: 500),
                                       curve: Curves.easeInOut,)
                               },
                                child: Icon(Icons.arrow_back_ios)),
                                Container(
                                  width: Get.width*0.7,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(widget.url),
                        )),            
                               InkWell(
                                onTap: ()=>{
                                 widget.pageController.nextPage( duration: Duration(milliseconds: 500),
                                       curve: Curves.easeInOut,)
                               },
                                child: Icon(Icons.arrow_forward_ios)),
                           ],
                         ),
                       )
                      : _controller != null && _controller!.value.isInitialized
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                ),
                                GestureDetector(
                                  onTap: _togglePlayPause,
                                  child: Icon(
                                    _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 80.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : CircularProgressIndicator())
                  : (image != null
                      ? Image.file(File(image!.path))
                      : _controller != null && _controller!.value.isInitialized
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                ),
                                GestureDetector(
                                  onTap: _togglePlayPause,
                                  child: Icon(
                                    _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 80.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : CircularProgressIndicator()),
            
          
                  
                  Container(
                        margin: EdgeInsets.only(left: 15, right: 15,top: 20),
                        child: TextField(
                          controller: headcontroller,
                          minLines: 3,
                          maxLines: 5,
                         
                          style:
                              TextStyle(fontFamily: 'Sans-serif', fontSize: 17),
                          decoration: InputDecoration(
                            hintText: "Write Link here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: main_color)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: main_color)),
                            // labelText: 'Write Here',
                          ),
                        ),
                      ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 30),
  //                   child: Align(
  //                   alignment: Alignment.center,
  //                   child: SizedBox(
  //                     width: Get.width * 0.9,
  //                     child: ElevatedButton(
  //                       onPressed: () async{
  //                         //
  //                         if(pickedvideo!=null){
  //                            print(pickedvideo!.path);
  //  final cloudinary = CloudinaryPublic("dfkxcafte", "jhr5a7vo");
  //                           CloudinaryResponse response = await cloudinary
  //                             .uploadFile(CloudinaryFile.fromFile(pickedvideo!.path, folder: "user"));
  //                         String imageurl = response.secureUrl;
  //                         AdsService().createads(adsid: widget.id, image: "",link: headcontroller.text,video: imageurl);
  //                                                   print(imageurl);
  //  SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!,
  //                              userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
  // title: "${userSave.displayName} CHANGE ADVERTISEMENT-${widget.id} IN ADVERTISEMENT", email: userSave.email!, subtitle: "");
  //                        await showDialog(
  //                                       context: context,
  //                                       builder: (context) {
  //                                         return  AlertDialog(
  //                                           content: SnackBarContent(
  //                                             appreciation: "",
  //                                             error_text:
  //                                                 "Advertisement ${widget.id} Create \n Successfully",
  //                                             icon: Icons.check,
  //                                             sec: 2,
  //                                           ),
  //                                           backgroundColor: Colors.transparent,
  //                                           elevation: 0,
  //                                         );
  //                                       }).whenComplete((){
  //                                         Navigator.pop(context);
  //                                       });
  //                         }else if(image!=null){
  //                              final cloudinary = CloudinaryPublic("dfkxcafte", "jhr5a7vo");
  //                           CloudinaryResponse response = await cloudinary
  //                             .uploadFile(CloudinaryFile.fromFile(image!.path, folder: "user"));
  //                         String imageurl = response.secureUrl;
  //                         AdsService().createads(adsid: widget.id, image: imageurl,link: headcontroller.text,video: "");
  //                        await showDialog(
  //                                       context: context,
  //                                       builder: (context) {
  //                                         return  AlertDialog(
  //                                           content: SnackBarContent(
  //                                             appreciation: "",
  //                                             error_text:
  //                                                 "Advertisement ${widget.id} Create \n Successfully",
  //                                             icon: Icons.check,
  //                                             sec: 2,
  //                                           ),
  //                                           backgroundColor: Colors.transparent,
  //                                           elevation: 0,
  //                                         );
  //                                       }).whenComplete((){
  //                                         Navigator.pop(context);
  //                                       });
  //                         }else{
  //                            AdsService().createads(adsid: widget.id, image: widget.url,link: headcontroller.text,video: "");
  //                        await showDialog(
  //                                       context: context,
  //                                       builder: (context) {
  //                                         return  AlertDialog(
  //                                           content: SnackBarContent(
  //                                             appreciation: "",
  //                                             error_text:
  //                                                 "Advertisement ${widget.id} Create \n Successfully",
  //                                             icon: Icons.check,
  //                                             sec: 2,
  //                                           ),
  //                                           backgroundColor: Colors.transparent,
  //                                           elevation: 0,
  //                                         );
  //                                       }).whenComplete((){
  //                                         Navigator.pop(context);
  //                                       });
  //                         }
                        
  //                       },
  //                       child: Text(
  //                         "Submit",
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                       style: ButtonStyle(
  //                           padding:
  //                               MaterialStateProperty.all<EdgeInsetsGeometry?>(
  //                                   EdgeInsets.symmetric(vertical: 20)),
  //                           shape:
  //                               MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                   RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(60.0),
  //                                       side: BorderSide(color: Colors.white))),
  //                           backgroundColor:
  //                               MaterialStateProperty.all<Color>(Colors.white)),
  //                     ),
  //                   ),
  //                                   ),
  //                 ),
   SizedBox(
                    width: Get.width,
                    child: Text(
                      "Updated by ${widget.ads.name} on ${ DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(widget.ads.createdAt).toLocal())}   ",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
     
      ],
    );
  }
}