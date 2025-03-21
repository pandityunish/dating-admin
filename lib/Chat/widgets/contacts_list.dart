import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/colors.dart';
import 'package:matrimony_admin/Chat/info.dart';
import 'package:matrimony_admin/Chat/screens/mobile_chat_screen.dart';
import 'package:matrimony_admin/models/new_user_model.dart';

import '../../Assets/Error.dart';
import '../../globalVars.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../service/chat_service.dart';

class ContactsList extends StatefulWidget {
  final NewUserModel newusermodel;
  const ContactsList({Key? key, required this.newusermodel}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  // late DatabaseReference _dbref;
  var res = [];
  @override
  initState() {
    super.initState();
    // print("initstate run");
    // _dbref = FirebaseDatabase.instance.ref();

    setData();
  }

  setData() {
    if(widget.newusermodel.chats!.isEmpty){
      showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SnackBarContent(
                    error_text: "No Record Found",
                    appreciation: "",
                    icon: Icons.error,
                    sec: 2,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
              }); 
    }
    // _dbref = _dbref.child("chatroomids").child(userSave.uid!);
    // _dbref.orderByChild('lmtime').onValue.listen((event) {
    //   try {
    //     var values = event.snapshot.value as Map<dynamic, dynamic>;
    //     res.clear();
    //     if (values.isNotEmpty) {
    //       values.forEach((snapshot, value) {
    //         res.add(value);
    //         setState(() {
    //           res.sort((a, b) => a['time'].compareTo(b['time']));
    //         });
    //       });
    //       print(res.toString());
    //     } else {
    //       showDialog(
    //           barrierDismissible: false,
    //           context: context,
    //           builder: (context) {
    //             return AlertDialog(
    //               content: SnackBarContent(
    //                 error_text: "No Record Found",
    //                 appreciation: "",
    //                 icon: Icons.error,
    //                 sec: 2,
    //               ),
    //               backgroundColor: Colors.transparent,
    //               elevation: 0,
    //             );
    //           });
    //     }
    //     // connectivity = values[0]['status'];
    //     // List<Map<dynamic, dynamic>> updatedList = [];
    //     // connectivity = snapshot.ValueKey('status');
    //     // print(res.toString());
    //   } catch (e) {
    //     print(e);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        // itemCount: info.length,
        itemCount: widget.newusermodel.chats!.length,
        itemBuilder: (context, index) {
          return ChatlistTile(res: widget.newusermodel.chats![index],newUserModel: widget.newusermodel,);
        
        },
      ),
    );
  }
}

class ChatlistTile extends StatefulWidget {
  ChatlistTile({super.key, required this.res,required this.newUserModel});
  ChatsModel res;
  NewUserModel newUserModel;
  @override
  State<ChatlistTile> createState() => _ChatlistTileState();
}

class _ChatlistTileState extends State<ChatlistTile> {
    NewUserModel? newUserModel;
  var time;
  var imgurl =
      "https://firebasestorage.googleapis.com/v0/b/couplematch-47708.appspot.com/o/impImage%2Fnoimage.jpg?alt=media&token=4c0d4bc9-761e-48af-b947-4a05a0eaa6d2";
  // User? Profile2;
  setImgUrl() async {
      if(widget.res.email=="Live Astrologer" || widget.res.email=="Live Matchmaker"){

    }else{
if(newUserModel!.imageurls.isNotEmpty){
  imgurl=newUserModel!.imageurls[0];
  setState(() {
    
  });}
}
    // User? profile = User.fromdoc(await FirebaseFirestore.instance
    //     .collection("user_data")
    //     .doc(widget.res['frienduid'])
    //     .get());
    // setState(() {
    //   Profile2 = profile;
    // });
    // if (profile.imageUrls != null && profile.imageUrls!.isNotEmpty) {
    //   setState(() {
    //     imgurl = profile.imageUrls![0];
    //   });
    // }
  }

  late DatabaseReference _dbref;
  Map<dynamic, dynamic>? lastMessage;

  @override
  void initState() {
    super.initState();
    // time = DateTime.fromMillisecondsSinceEpoch(widget.res['lmtime']);
   
    _dbref = FirebaseDatabase.instance.ref().child("firstchat");
    setdata();
  }

  setdata() async {
    if(widget.res.email=="Live Astrologer" || widget.res.email=="Live Matchmaker"){

    }else{
    newUserModel=await ChatService().getuserdata(widget.res.email);

    }
setState(() {
  
});
 setImgUrl();
    // if (await docexist(_dbref.child(widget.roomid))) {
    // print(true);
    // _dbref
    //     .child(widget.res['roomid'])
    //     .orderByChild('time')
    //     .onValue
    //     .listen((event) {
    //   DataSnapshot snapshot = event.snapshot;
    //   // List<Map<dynamic, dynamic>> updatedList = [];
    //   Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    //   // values.forEach((snapshot, value) {
    //   //   messages.add(value);
    //   //   setState(() {
    //   //     messages.sort((a, b) => a['time'].compareTo(b['time']));
    //   //   });
    //   // });
    //   lastMessage = values[0];
    //   // print("messages : $messages");
    // });
    // }
    // } else {
    //   DateTime time = DateTime.now().toUtc();
    //   int millisecondsSinceEpoch = time.millisecondsSinceEpoch;
    //   temp = MessageText(
    //       text: msg.text, uid: userSave.uid!, time: millisecondsSinceEpoch);
    //   // messages.add(temp.toJson());
    //   _dbref.child(widget.roomid).push().set(temp.toJson());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MobileChatScreen(
                  newUserModel:widget.newUserModel,
                  roomid: widget.res.email,
                  profileDetail: newUserModel!,
                  profilepic: imgurl,
                ),
              ),
            );
          },
          child:newUserModel==null?Center(): Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: ListTile(
              title: Text(
                (newUserModel!.name != null && newUserModel!.name != '')
                    ? "${newUserModel!.name!.substring(0, 1)} ${newUserModel!.surname}"
                    : "",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              // subtitle: Padding(
              //   padding: const EdgeInsets.only(top: 6.0),
              //   child: Text(
              //     lastMessage.toString(),
              //     style: const TextStyle(fontSize: 15, color: Colors.grey),
              //   ),
              // ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  imgurl,
                ),
                radius: 25,
              ),
              // trailing: Text(
              //   time.toString().substring(11, 16),
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 13,
              //   ),
              // ),
            ),
          ),
        ),
        const Divider(color: dividerColor),
      ],
    );
    
  }
}
