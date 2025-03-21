import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';

import '../../../../Assets/ayushWidget/big_text.dart';

class FreeChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  const FreeChatScreen({super.key, required this.name, required this.uid});

  @override
  State<FreeChatScreen> createState() => _FreeChatScreenState();
}

class _FreeChatScreenState extends State<FreeChatScreen> {
  @override
  Widget build(BuildContext context) {
    return   CupertinoTheme(
      data: const CupertinoThemeData(
        primaryColor: Colors.white,
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: main_color,
        
            leading: GestureDetector(
              onTap: () {
              Get.back();
              },
              // onTap: Navigator.of(context).push(Materiroute),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25,
              ),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //pic
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Colors.transparent,
                      borderRadius: BorderRadius.circular(35),
                      image: DecorationImage(
                          image: NetworkImage("https://res.cloudinary.com/dfkxcafte/image/upload/v1713673971/ic_launcher_inlm33.png"))),
                ),
                //name and data
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.005),
                  // margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                          BigText(
                              text: widget.name,
                              size: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )
                         ,
                     Container(
                              child: Row(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.only(left: 15),
                                    child: BigText(
                                      text: widget.uid,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                 
                                ],
                              ),
                            ),
                    
                    ],
                  ),
                ),
                //video,audio,call button
                Material(
                  color: Colors.transparent,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                         
                        },
                        icon: const Icon(
                          Icons.video_call,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                      
                          // SendMessage().sendPushMessage(
                          //   "Call",
                          //   "${userSave.name!.substring(0, 1).toUpperCase()} ${userSave.surname!.toUpperCase()}",
                          //   userSave.puid!,
                          //   "audio",
                          //   token,
                          // );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CallSample(
                          //               userId: widget.profileDetail.uid,
                          //               selfId: userSave.uid!,
                          //               callType: 0,
                          //             )));
                        },
                        // enable:false,
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                      
                    ],
                  ),
                )
              ],
            ),
            previousPageTitle: "",
          ),
          child: Material(
            color: Colors.white,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 25),
              height: MediaQuery.of(context).size.width * 2.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                
                  const Divider(
                    color: Colors.black,
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