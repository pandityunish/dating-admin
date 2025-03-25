import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:matrimony_admin/Assets/Error.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:photo_view/photo_view.dart';

import '../../globalVars.dart';

class ImageSliderPopUp extends StatefulWidget {
  ImageSliderPopUp({
    super.key,
    this.galleryItems,
    required this.profileData,
     required this.currentindex,
  });
  var galleryItems;
  NewUserModel profileData;
   int currentindex;

  @override
  State<ImageSliderPopUp> createState() => _ImageSliderPopUpState();
}

class _ImageSliderPopUpState extends State<ImageSliderPopUp> {
  var galleryItems;
  @override
  void initState() {
    super.initState();
    setState(() {
      galleryItems = widget.galleryItems;
    });
  }

  List<Widget> _createImgList() {
    if (galleryItems == null) {
      return [Text("image not found")];
    } else {
      return List<Widget>.generate(galleryItems.length, (int index) {
        return PhotoView(
           minScale: PhotoViewComputedScale.contained,
  maxScale: PhotoViewComputedScale.covered * 2, 
          imageProvider: NetworkImage(
            galleryItems[index],
            // fit: BoxFit.cover,
          ),
        );
      });
    }
  }
   Future<void> block() async {
    // final docUser = FirebaseFirestore.instance
    //     .collection('user_data')
    //     .doc(widget.profileData!.id);
    // try {
      print(widget.profileData!.status);
      setState(() {
        widget.profileData!.status = "blocked";
      });
      HomeService().addtoblock(email: widget.profileData!.email);
      ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const SnackBarContent(
                    error_text: "Profile Blocked",
                    appreciation: "",
                    icon: Icons.check,
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
    //   final json = widget.profileData!.toJson();
    //   await docUser
    //       .update(json)
    //       .then((value) => ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               duration: Duration(seconds: 1),
    //               content: const SnackBarContent(
    //                 error_text: "Profile Blocked",
    //                 appreciation: "",
    //                 icon: Icons.check,
    //                 sec: 2,
    //               ),
    //               margin: EdgeInsets.only(
    //                   bottom: MediaQuery.of(context).size.height * 0.25,
    //                   left: MediaQuery.of(context).size.width * 0.06),
    //               behavior: SnackBarBehavior.floating,
    //               backgroundColor: Colors.transparent,
    //               elevation: 0,
    //             ),
    //           ))
    //       .catchError((error) => print(error));
    // } catch (Excepetion) {
    //   print(Excepetion);
    // }
  }
Future<void> approveProfile() async {
    if (widget.profileData!.status == "report") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: const SnackBarContent(
            error_text: "Please unreport profile First to Approve",
            appreciation: "",
            icon: Icons.check,
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
    }
    else if (widget.profileData!.status == "blocked") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: const SnackBarContent(
            error_text: "Please unblock profile First to Approve",
            appreciation: "",
            icon: Icons.check,
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
    }else{
      HomeService().approveuser(widget.profileData!.email);
         setState(() {
          widget.profileData!.status = "approved";
        });
       ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    content: const SnackBarContent(
                      error_text: "Profile Approved",
                      appreciation: "",
                      icon: Icons.check,
                      sec: 2,
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.06),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );}
    }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            child: ImageSlideshow(
                indicatorRadius: 5,
                initialPage: widget. currentindex,
                height: MediaQuery.of(context).size.height * 1,
                // height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,

                /// The color to paint the indicator.
                indicatorColor: main_color,
                isLoop: false,
                children: _createImgList() //returns list of images

                ),
          ),
          // Container(
          //   child: Positioned(
          //     top: 40,
          //     left: MediaQuery.of(context).size.width * 0.01,
          //     // right: 25,
          //     child: PopupMenuButton(
          //       icon: const Icon(
          //         Icons.more_vert,
          //         color: Colors.white,
          //         shadows: <Shadow>[
          //           Shadow(color: Colors.black, blurRadius: 15.0)
          //         ],
          //       ),
          //       itemBuilder: (context) => [
          //         PopupMenuItem(
          //             child: Text(
          //             widget.profileData!.status=='approved'?"Approved":"Approve",
          //             ),
          //             onTap: () {
          //               approveProfile();
          //             }),
          //         PopupMenuItem(
          //             child: Text(
          //              widget.profileData.status=="blocked"?  'Unblock':"Block",
          //             ),
          //             onTap: () {
          //               block();
          //             }),
          //         PopupMenuItem(
          //             child: Text(
          //               'Delete',
          //             ),
          //             onTap: () {}),
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   child: Positioned(
          //     top: 50,
          //     left: MediaQuery.of(context).size.width * 0.85,
          //     // right: 25,
          //     child: GestureDetector(
          //       onTap: () {
          //         // print("Print");
          //         Navigator.of(context).pop();
          //       },
          //       child: Container(
          //         width: 30,
          //         height: 30,
          //         // decoration: BoxDecoration(
          //         //     color: Colors.white,
          //         //     borderRadius: BorderRadius.circular(40)),
          //         child: ImageIcon(
          //           AssetImage(
          //             'images/icons/Close_icon.png',
          //           ),
          //           // fontWeight:FontWeight.w700,
          //           color: main_color,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
           Container(
            child: Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width * 0.85,
              // right: 25,
              child: GestureDetector(
                onTap: () {
                  // print("Print");
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: main_color,
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(Icons.close,color: Colors.white,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ImageSliderPopUp extends StatefulWidget {
//     ImageSliderPopUp({
//     super.key,
//     this.galleryItems,
//   });
//   var galleryItems;
//   @override
//   State<ImageSliderPopUp> createState() => _ImageSliderPopUpState();
// }

// class _ImageSliderPopUpState extends State<ImageSliderPopUp> {
//   String dropdownValue="";

//   @override
//   void initState() {
//     super.initState();
//     dropdownValue = widget.galleryItems[0];
//   }

//   List<Widget> _createImgList() {
//     if (widget.galleryItems == null) {
//       return [Text("image not found")];
//     } else {
//       return List<Widget>.generate(widget.galleryItems.length, (int index) {
//         return Image.network(
//           widget.galleryItems[index],
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           Container(
//             child: ImageSlideshow(
//               indicatorRadius: 5,
//               initialPage: 0,
//               height: MediaQuery.of(context).size.height * 1,
//               width: MediaQuery.of(context).size.width,
//               indicatorColor: Colors.white,
//               isLoop: true,
//               children: _createImgList(),
//             ),
//           ),
//           Container(
//             child: Positioned(
//               top: 50,
//               left: MediaQuery.of(context).size.width * 0.1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   DropdownButton<String>(
//                     value: dropdownValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue = newValue!;
//                       });
//                     },
//                     items: widget.galleryItems.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(
//                       Icons.close_rounded,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
