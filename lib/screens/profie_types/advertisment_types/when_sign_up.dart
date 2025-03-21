import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Assets/ayushWidget/big_text.dart';
import 'package:matrimony_admin/globalVars.dart';

import '../../../Assets/Error.dart';


class WhenSignUp extends StatefulWidget {
  const WhenSignUp({super.key});

  @override
  State<WhenSignUp> createState() => _WhenSignUpState();
}

class _WhenSignUpState extends State<WhenSignUp> {
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
  
  String? videoupload;
  late File _videoFile = File('');
  Future _pickVideoFromGallery() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    // setState(() {
    if (pickedFile != null) {
      // _videoFile = File(pickedFile.path);
      var size = await pickedFile.length();
      if (size < 2e+7) {
        setState(() {
          _videoFile = File(pickedFile.path);
        });
       
        // NotificationFunction.setNotification(
        //   "admin",
        //   "${userSave.name!.substring(0, 1)} ${userSave.surname} ${userSave.uid?.substring(userSave!.uid!.length - 5)} TRIED TO UPLOAD VIDEO (JUST LIKE THAT )",
        //   'videouploadjlt',
        // );
      } else {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SnackBarContent(
                  error_text: "Video size must be less than 20 MB",
                  appreciation: "",
                  icon: Icons.check,
                  sec: 2,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
            });
      }
    } else {}
    // });
  }
  XFile? image; 

  void pickimage()async{
    final pickimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    image=pickimage;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
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
            // middle: Icon(
            //   Icons.supervised_user_circle_outlined,
            //   // color: ma/
            //   size: 30,
            // ),
 trailing: Material(
        child: IconButton(onPressed: (){
          _selectDate(context);
        }, icon: Icon(Icons.calendar_month,color: main_color,)),
      ),
            middle: Row(
              children: [
                BigText(
                  text: "Advertisement-2",
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
          child: SingleChildScrollView(
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
                      "Updated on 23 Feb 2023  14 : 58  ",
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
                              onPressed: () {},
                              icon: Icon(Icons.delete_outlined)),
                          IconButton(
                              onPressed: () {
                                // pickimage();
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: 60,
                                      child: Column(
                                        children: [
                                         InkWell(
                                          onTap: () {
                                        _pickVideoFromGallery();
                                          },
                                           child: Row(
                                            children: [
                                              Icon(Icons.video_call),
                                              SizedBox(width: 5,),
                                               Text("Video",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            ],
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         InkWell(
                                          onTap: () {
                                            pickimage();
                                          },
                                           child: Row(
                                            children: [
                                              Icon(Icons.image),
                                              SizedBox(width: 5,),
                                               Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            ],
                                           ),
                                         ),
                                        ],
                                      ),
                                    ),
                                  );
                                },);
                              }, icon: Icon(Icons.edit_square))
                        ],
                      )),
                      image==null?Column(
children: [
  SizedBox(
                    width: Get.width,
                    child: Text(
                      "जरूरी सूचना",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      " हमारी कंपनी किसी भी प्रकार का पैसा नहीं लेती है, यह सुविधा बिल्कुल मुफ्त है, कृपया सावधान रहें।",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            " Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Our company newer charge any money it is totally free platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/saurabh.png"),
                            // image: NetworkImage(
                            //     "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                            fit: BoxFit.cover)),
                  ),
                  const Text(
                      "By \nSourabh mehndiratta\n KURUKSHETRA SOCIAL WORKER",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
],
                      ):Image.file(File(image!.path)),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
