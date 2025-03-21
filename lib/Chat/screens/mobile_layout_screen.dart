// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/Error.dart';

import 'package:matrimony_admin/Chat/colors.dart';
import 'package:matrimony_admin/Chat/screens/match_maker_send_message.dart';
import 'package:matrimony_admin/Chat/widgets/contacts_list.dart';
import 'package:matrimony_admin/Chat/widgets/match_component.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/chat_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';

import '../../screens/navigation/navigator.dart';

class MobileLayoutScreen extends StatefulWidget {
final  NewUserModel newusermodel;
  const MobileLayoutScreen({
    Key? key,
    required this.newusermodel,
  }) : super(key: key);

  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen> {
   @override
  initState() {
    super.initState();
    // print("initstate run");
    // _dbref = FirebaseDatabase.instance.ref();
    
 

  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
               preferredSize: const Size.fromHeight(120),
              child: AppBar(
                  flexibleSpace: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10,),
                                    ImageIcon(
                                      AssetImage('images/icons/chat.png'),
                                      size: 30,
                                      color: main_color,
                                    ),
              
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        color: main_color,
                                        fontFamily: 'Sans-serif',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                      child: Text("Chatnow"),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: CupertinoSearchTextField(
                                                        // controller: _searchController,
                                                        onChanged: (value) {
                                                          setState(() {});
                                                        },
                                                        // onSubmitted: (value) {
                                                        //   _search(_searchController.text);
                                                        // },
                                                        onSuffixTap: () {
                                                          // setState(() {
                                                          //   _searchController.clear();
                                                          // });
                                                          // _search(_searchController.text);
                                                        },
                                                      ),
                                    ),
                                   
                                    // actions: [CupertinoSearchTextField(
                                    //   controller: _searchController,
                                    //   onChanged: _search,
                                    // ),],
                                  ],
                                ),
                              ),
                leading: GestureDetector(
                  onTap: () {
                 Navigator.pop(context);
                    // Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: main_color,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
              
              ),
            ),
      //  AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       // Navigator.of(context).pushReplacement(
      //       //     MaterialPageRoute(builder: (builder) => MyProfile()));
      //       Navigator.of(context).pop();
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: main_color,
      //     ),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
      //     TextSpan(
      //         text: "Free",
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontFamily: "Showg",
      //             color: Colors.black)),
      //     TextSpan(
      //         text: "rishteywala",
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             color: main_color,
      //             fontFamily: "Showg")),
      //     // TextSpan(
      //     //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),
      //   ])),
      //   actions: [
      //     IconButton(
      //       icon: ImageIcon(
      //         AssetImage('images/icons/search.png'),
      //         size: 25,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {},
      //     )
      //   ],
      //   // bottom: TabBar(
      //   //   indicatorColor: main_color,
      //   //   indicatorWeight: 4,
      //   //   labelColor: main_color,
      //   //   unselectedLabelColor: Colors.black,
      //   //   labelStyle: TextStyle(
      //   //     fontWeight: FontWeight.bold,
      //   //   ),
      //   //   // tabs: [
      //   //   //   Container(
      //   //   //     width: MediaQuery.of(context).size.width * 2,
      //   //   //     color: main_color,
      //   //   //     child: Tab(
      //   //   //       text: 'CHATS',
      //   //   //     ),
      //   //   //   ),
      //   //   //   // Tab(
      //   //   //   //   text: 'STATUS',
      //   //   //   // ),
      //   //   //   // Tab(
      //   //   //   //   text: 'CALLS',
      //   //   //   // ),
      //   //   // ],
      //   // ),
      // ),
      // body: const ContactsList(),
      body: Column(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   color: main_color,
          //   child: Center(
          //     child: Text(
          //       "Chat",
          //       style: TextStyle(
          //           fontFamily: "Sans-serif",
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700,
          //           color: Colors.black),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
           GestureDetector(
                onTap: () {
                Get.to(MatchMakerSendMessage(roomid: "Live Matchmaker", profileDetail: widget.newusermodel, profilepic: "https://res.cloudinary.com/dfkxcafte/image/upload/v1713673971/ic_launcher_inlm33.png"));
                },
                child: MatchingComponents(title: "Live Matchmaker",)),
               GestureDetector(
                  onTap: () {
                Get.to(MatchMakerSendMessage(roomid: "Live Astrologer", profileDetail: widget.newusermodel, profilepic: "https://res.cloudinary.com/dfkxcafte/image/upload/v1713673971/ic_launcher_inlm33.png"));
                  
                },
                child: MatchingComponents(title: "Live Astrologer",)),
           Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
      child: Column(
        children: [
        ListView.builder(
            shrinkWrap: true,
            // itemCount: info.length,
            itemCount: widget.newusermodel.chats!.length,
            itemBuilder: (context, index) {
              // print(widget.res.length);
            //  final nameuser=widget.newusermodel.chats![index].username;
              //  if(_searchController.text.isEmpty){
       return ChatlistTile(res: widget.newusermodel.chats![index],newUserModel: widget.newusermodel,);
              //  }
                // else if(nameuser.toLowerCase().contains(_searchController.text.toLowerCase())){
      //  return ChatlistTile(res: message[index]);
              //  }
             
              //   return Column(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (context) => MobileChatScreen(
              //                 roomid: res[index]['roomid'],
              //               ),
              //             ),
              //           );
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.only(bottom: 8.0),
              //           child: ListTile(
              //             title: Text(
              //               info[index]['name'].toString(),
              //               style: const TextStyle(
              //                 fontSize: 18,
              //                 color: Colors.black,
              //               ),
              //             ),
              //             subtitle: Padding(
              //               padding: const EdgeInsets.only(top: 6.0),
              //               child: Text(
              //                 info[index]['message'].toString(),
              //                 style:
              //                     const TextStyle(fontSize: 15, color: Colors.grey),
              //               ),
              //             ),
              //             leading: CircleAvatar(
              //               backgroundImage: NetworkImage(
              //                 info[index]['profilePic'].toString(),
              //               ),
              //               radius: 30,
              //             ),
              //             trailing: Text(
              //               info[index]['time'].toString(),
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //                 fontSize: 13,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const Divider(color: dividerColor, indent: 85),
              //     ],
              //   );
            },
          ),
        ],
      ),
            ),
          ),
        ],
      ),
     
    );
  }
}
