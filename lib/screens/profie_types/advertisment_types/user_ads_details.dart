import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/ads_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/ads_service.dart';
import 'package:matrimony_admin/screens/profie_types/manage_advertisiment.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

import '../../navigation/admin_options/service/admin_service.dart';
import '../../service/search_profile.dart';

class UserAdsDetails extends StatefulWidget {
  final String url;
  final AdsModel ads;
  final String id;
  final int index;
  final PageController pageController;
  final VoidCallback delete;
  final VoidCallback onclick;
  final NewUserModel newUserModel;
  final int adscount;
  const UserAdsDetails({super.key, required this.url, required this.ads, required this.id, required this.pageController, required this.index, required this.adscount, required this.delete, required this.onclick, required this.newUserModel});

  @override
  State<UserAdsDetails> createState() => _AdsDetailsState();
}

class _AdsDetailsState extends State<UserAdsDetails> {
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
print(widget.ads.adsid);
    return      SingleChildScrollView(
      child: Column(
        children: [
          Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                
                    SizedBox(
                      width: Get.width,
                      child:widget. index==0? Text(
                        "(Active)",
                        textAlign: TextAlign.center,
                      ):Text(
                        "(Inactive)",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async{
                                 widget.delete;
                                },
                                icon: Icon(Icons.delete_outlined)),
                            IconButton(
                                onPressed: () {
                                 _showChoiceDialog(context);
                                }, icon: Icon(Icons.edit_square))
                          ],
                        )),
                  // Row(
                  //   children: [
                  //        widget.adscount>0?  IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>{
                  //            widget.   pageController.previousPage( duration: Duration(milliseconds: 500),
                  // curve: Curves.easeInOut,)
                  //             }):Center(),              
                            
                  //      (image == null && _controller == null)
                  //   ? (widget.ads.video.isEmpty
                  //       ? Image.network(widget.url)
                  //       : _controller != null && _controller!.value.isInitialized
                  //           ? Stack(
                  //               alignment: Alignment.center,
                  //               children: [
                  //                 AspectRatio(
                  //                   aspectRatio: _controller!.value.aspectRatio,
                  //                   child: VideoPlayer(_controller!),
                  //                 ),
                  //                 GestureDetector(
                  //                   onTap: _togglePlayPause,
                  //                   child: Icon(
                  //                     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  //                     size: 80.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             )
                  //           : CircularProgressIndicator())
                  //   : (image != null
                  //       ? Image.file(File(image!.path))
                  //       : _controller != null && _controller!.value.isInitialized
                  //           ? Stack(
                  //               alignment: Alignment.center,
                  //               children: [
                  //                 AspectRatio(
                  //                   aspectRatio: _controller!.value.aspectRatio,
                  //                   child: VideoPlayer(_controller!),
                  //                 ),
                  //                 GestureDetector(
                  //                   onTap: _togglePlayPause,
                  //                   child: Icon(
                  //                     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  //                     size: 80.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             )
                  //           : CircularProgressIndicator()),
                  //               IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: ()=>{
                  //               widget.pageController.nextPage( duration: Duration(milliseconds: 500),
                  // curve: Curves.easeInOut,)
                  //             }),
                  //   ],
                  // ),
              ResponsiveMediaRow(
  pageController: widget.pageController,
  adscount: widget.adscount,
  image: image,
  controller: _controller,
  url: widget.url,
  video: widget.ads.video,
  togglePlayPause: _togglePlayPause,
  ads: widget.ads,
),
            
                    //  Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    //   child: SizedBox(
                    //     width: Get.width,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                         
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                        SizedBox(height: 10,),
                            SizedBox(
                      width: Get.width,
                      child: Text(
                        "Updated by ${widget.ads.name} on ${ DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(widget.ads.createdAt).toLocal())}   ",
                        textAlign: TextAlign.center,
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: Get.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async{
                            //
                            if(pickedvideo!=null){
                               print(pickedvideo!.path);
         final cloudinary = CloudinaryPublic("dfkxcafte", "jhr5a7vo");
                              CloudinaryResponse response = await cloudinary
                                .uploadFile(CloudinaryFile.fromFile(pickedvideo!.path, folder: "user"));
                            String imageurl = response.secureUrl;
                            AdsService().createads(adsid: widget.ads.adsid, image: "",link: headcontroller.text,video: imageurl);
                                                      print(imageurl);
         SearchProfile().addtoadminnotification(userid: userSave!.puid!, useremail:userSave.email!,
                                 userimage:userSave.imageUrls!.isEmpty?"":userSave.imageUrls![0], 
        title: "${userSave.displayName} CHANGE ADVERTISEMENT-${widget.id} IN ADVERTISEMENT", email: userSave.email!, subtitle: "");
                           await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return  AlertDialog(
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
                                          }).whenComplete((){
                                            Navigator.pop(context);
                                          });
                            }else if(image!=null){
                                SearchProfile().addtoadminnotification(
                                            userid: "122",
                                            useremail: "121",
                                            userimage: "",
                                            title:
                                                '${userSave.displayName} CHANGE ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} ADVERTISEMENT-${widget.id}',
                                            email: "",
                                            subtitle: "");
                                        final cloudinary = CloudinaryPublic(
                                            "dfkxcafte", "jhr5a7vo");
                                        CloudinaryResponse response =
                                            await cloudinary.uploadFile(
                                                CloudinaryFile.fromFile(
                                                    image!.path,
                                                    folder: "user"));
                                        String imageurl = response.secureUrl;
      
                                        AdminService().addtoads(
                                            adsid: widget.ads.adsid,
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
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              );
                                            });
                            }else{
                                AdminService().addtoads(
                                            adsid: widget.ads.adsid,
                                            description: headcontroller.text,
                                            email: widget.newUserModel.email,
                                            image: widget.url);
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
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              );
                                            });
                            }
                          
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
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(60.0),
                                          side: BorderSide(color: Colors.white))),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white)),
                        ),
                      ),
                                      ),
                    ),
                  ],
                ),
       
        ],
      ),
    );
  }
}

class ResponsiveMediaRow extends StatelessWidget {
  final PageController pageController;
  final int adscount;
  final XFile? image; // Assuming XFile from image_picker
  final VideoPlayerController? controller;
  final String url;
  final String video; // Assuming this is part of widget.ads.video
  final VoidCallback togglePlayPause;
  final AdsModel ads; // Assuming this is the type for widget.ads

  const ResponsiveMediaRow({
    required this.pageController,
    required this.adscount,
    this.image,
    this.controller,
    required this.url,
    required this.video,
    required this.togglePlayPause,
    required this.ads,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Previous Button (Visible only if adscount > 0)
        adscount > 0
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: screenWidth * 0.06, // 6% of screen width, adjustable
                ),
                onPressed: () {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              )
            : SizedBox(width: screenWidth * 0.1), // Placeholder for alignment

        // Media Content (Image or Video)
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5, // Limit height
              maxWidth: screenWidth * 0.7, // 70% of screen width
            ),
            child: _buildMediaContent(context),
          ),
        ),

        // Next Button
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: screenWidth * 0.06, // 6% of screen width, adjustable
          ),
          onPressed: () {
            pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  Widget _buildMediaContent(BuildContext context) {
    if (image == null && controller == null) {
      // Case 1: No local image or video controller
      if (ads.video.isEmpty) {
        return Image.network(
          url,
          fit: BoxFit.contain, // Fit within constraints
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Text('Error loading image'));
          },
        );
      } else if (controller != null && controller!.value.isInitialized) {
        return _buildVideoPlayer(context);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    } else {
      // Case 2: Local image or video
      if (image != null) {
        return Image.file(
          File(image!.path),
          fit: BoxFit.contain, // Fit within constraints
        );
      } else if (controller != null && controller!.value.isInitialized) {
        return _buildVideoPlayer(context);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
        GestureDetector(
          onTap: togglePlayPause,
          child: Icon(
            controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}