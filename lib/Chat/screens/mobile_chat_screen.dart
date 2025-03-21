// import 'dart:convert';
// import 'dart:html';

// import 'dart:html';

import 'dart:io';

import 'package:get/get.dart';
import 'package:matrimony_admin/Chat/service/chat_service.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_admin/Chat/widgets/chat_list.dart';
import 'package:matrimony_admin/models/message_model.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/navigation/FreePersonalizeMatchmaking/audio_call.dart';
import 'package:matrimony_admin/screens/navigation/FreePersonalizeMatchmaking/video_call.dart';

import '../../Assets/ayushWidget/big_text.dart';
import 'searchPage.dart';

class MobileChatScreen extends StatefulWidget {
  MobileChatScreen(
      {Key? key,
      required this.roomid,
      required this.profileDetail,
        required this.newUserModel,
      required this.profilepic})
      : super(key: key);

  var roomid;
  NewUserModel profileDetail;
  var profilepic;
  NewUserModel newUserModel;
  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  TextEditingController msg = TextEditingController(text: "Initial value");
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late DatabaseReference _dbref;
  late DatabaseReference _dbref2;
  // DateTime time2 = DateTime.now();
  List<Map<dynamic, dynamic>> messages = [];
  MessageText temp = MessageText();
  var connectivity = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msg.text = "";
    _dbref2 = FirebaseDatabase.instance.ref();
    _dbref = FirebaseDatabase.instance.ref().child("firstchat");
    setdata();
    setconnection();
    getallmessages();
  }

  setconnection() {
    _dbref2 = _dbref2.child("onlineStatus");
    _dbref2.child(widget.profileDetail.id).onValue.listen((event) {
      // var values = event.snapshot.value as Map<dynamic, dynamic>;
      try {
        var res = event.snapshot.child('status').value;
        // connectivity = values[0]['status'];
        // List<Map<dynamic, dynamic>> updatedList = [];
        // connectivity = snapshot.ValueKey('status');
        // print(res.toString());

        setState(() {
          print(res);

          connectivity = res.toString();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  setdata() async {
    // if (await docexist(_dbref.child(widget.roomid))) {
    print(true);
    _dbref.child(widget.roomid).orderByChild('time').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      // List<Map<dynamic, dynamic>> updatedList = [];
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      messages.clear();
      values.forEach((snapshot, value) {
        messages.add(value);
        setState(() {
          messages.sort((a, b) => a['time'].compareTo(b['time']));
        });
      });
      // print("messages : $messages");
    });
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
  ScrollController _scrollController = ScrollController();
List<MessageModelChats> chats=[];
 void getallmessages()async{
  try {
    if(widget.profileDetail.email==widget.newUserModel.email){
      chats=await  ChatService().getallmessage(to: widget.profileDetail.id, from:"12345");
    }else{
  chats=await  ChatService().getallmessage(to: widget.profileDetail.id, from:widget.newUserModel.id);

    }
  setState(() {
    
  });
  for (var i = 0; i < chats.length; i++) {
    messages.add({
  "text":chats[i].text,
        "type":"source",
        "uid":chats[i].uid,
        "time":chats[i].time,
       "status":chats[i].status,
    });
  }
  setState(() {
    
  });
  //  SchedulerBinding.instance.addPostFrameCallback((_) {
  //           _scrollController
  //               .jumpTo(_scrollController.position.maxScrollExtent);
  //         });
  } catch (e) {
    print(e.toString());
  }
 }
  void setMessage(String type, String message, String uid) {
    // MessageModel messageModel = MessageModel(
    //     type: type,
    //     message: message,
    //     time: DateTime.now().toString().substring(10, 16));
    print(messages);
    DateTime myDateTime = DateTime.now();

    // Convert the DateTime object to a Unix timestamp in milliseconds.
    int timestampInMilliseconds = myDateTime.millisecondsSinceEpoch;

    if (this.mounted) {
      setState(() {
        messages.add({
          "text": message,
          "type": type,
          "uid": uid,
          "time": timestampInMilliseconds,
          "status": "unseen",
        });
      });
    }
  }
 
  void sendMessage(String message, String sourceId, String targetId) async {
    DateTime myDateTime = DateTime.now();
    int timestampInMilliseconds = myDateTime.millisecondsSinceEpoch;
    if (messages.isEmpty) {
      ChatService().setusermessage(
        username: widget.profileDetail.surname,
        userimage: widget.profilepic,
        userid: widget.profileDetail.id,
        lasttime: timestampInMilliseconds,
        sendemail: widget.newUserModel.email,
        lastmessage: msg.text,
      );
    } else {
      ChatService()
          .updatelastmessage(
              lasttime: timestampInMilliseconds,
              senderemail: widget.profileDetail.email,
              lastmessage: msg.text,
              email: userSave.email!)
          .onError((error, stackTrace) => printError());
    }

    setMessage("source", message, userSave.uid!);
    // socket.emit("message", {
    //   "message": message,
    //   "sourceId": sourceId,
    //   "targetId": targetId,
    //   "type": "source",
    //   "uid": userSave.uid,
    //   "time": timestampInMilliseconds,
    //   "status": "unseen",
    // });
    if (msg.text != null && msg.text != "") {
      var filteredMessage = msg.text;
      // await player.setSource(AssetSource('sound/chat.wav'));
      // await player.setVolume(0.1);
      // await player.resume();
      ChatService().sendmessages(
          text: msg.text,
          to: widget.profileDetail.id,
          token: "token",
          from: "12345",
          time: timestampInMilliseconds,
          status: "unseen");
      DateTime time = DateTime.now().toUtc();
      // ChatService().sendmessages(text: msg.text,
      //  to: widget., from: from, time: time, status: status)

      int millisecondsSinceEpoch = time.millisecondsSinceEpoch;
      print(widget.profileDetail.token);
      try {
        // sendPushMessage.sendPushMessage(
        //     "'${filteredMessage}'",
        //     "${userSave.name!.substring(0, 1).toUpperCase()} ${userSave.surname!.substring(0, 1).toUpperCase() + userSave.surname!.substring(1).toUpperCase()} SENT MESSAGE",
        //     userSave.email!,
        //     "Chat",
        //     widget.profileDetail!.token);
      } catch (e) {
        print(e);
      }
      //  try {
      //     sendPushMessage.sendPushMessage(
      //       "'${filteredMessage}'",
      //       "${userSave.name!.substring(0, 1).toUpperCase()} ${userSave.surname!.substring(0, 1).toUpperCase() + userSave.surname!.substring(1).toUpperCase()} SENT MESSAGE",
      //       userSave.uid!,
      //       "chat",
      //       widget.profileDetail.token,
      //       sound: 'chatnot'
      //     );
      //   } catch (e) {
      //     if (kDebugMode) {
      //       print(e);
      //     }
      //   }
      temp = MessageText(
          text: filteredMessage,
          uid: userSave.uid!,
          time: millisecondsSinceEpoch,
          type: "txt",
          status: "unseen");
      msg.text = "";
    }
    //    else {
    //     try {
    //        var filteredMessage = censorMessage(msg.text);
    //       sendPushMessage.sendPushMessage(
    //         "'${filteredMessage}'",
    //         "${userSave.name!.substring(0, 1).toUpperCase()} ${userSave.surname!.substring(0, 1).toUpperCase() + userSave.surname!.substring(1).toUpperCase()} SENT MESSAGE",
    //         userSave.uid!,
    //         "chat",
    //         widget.profileDetail.token,
    //         sound: 'chatnot'
    //       );
    //     } catch (e) {
    //       if (kDebugMode) {
    //         print(e);
    //       }
    //     }
    //  }
    ChatService().updateusernumberofunseenmes(
        from: userSave.uid!, to: widget.profileDetail!.id);
    setState(() {});
    msg.clear();
    // _scrollToEnd();
  }

  // () {}

  sendImage() async {
    ImagePicker _picker = ImagePicker();

    var imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var storageRef = _storage.ref();
      var imageRef = storageRef.child('images/${imageFile.name}');
      File file = File(imageFile.path);
      await imageRef.putFile(file);

      // Get the download URL for the image file.
      final downloadUrl = await imageRef.getDownloadURL();
      DateTime time = DateTime.now().toUtc();
      int millisecondsSinceEpoch = time.millisecondsSinceEpoch;
      temp = MessageText(
          text: downloadUrl,
          uid: userSave.uid!,
          imgname: imageFile.name,
          time: millisecondsSinceEpoch,
          type: "img");
      if (await docexist(_dbref.child(widget.roomid))) {
        _dbref.child(widget.roomid).push().update(temp.toJson());
      } else {
        _dbref.child(widget.roomid).push().set(temp.toJson());
      }
    }
  }

  Future<bool> docexist(DatabaseReference databaseReference) async {
    DatabaseEvent dataSnapshot = await databaseReference.once();
    print(dataSnapshot.snapshot.value);
    return dataSnapshot.snapshot.value != null;
  }

  _onBackPress() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress(),
      child: CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: Colors.white,
        ),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: main_color,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              // onTap: Navigator.of(context).push(Materiroute),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Icon(Icons.arrow_back_ios),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image: NetworkImage(widget.profilepic))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 17),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BigText(
                            text: (widget.profileDetail.name != null &&
                                    widget.profileDetail.name != '')
                                ? "${widget.profileDetail.name!.substring(0, 1)} ${widget.profileDetail.surname}"
                                : "",
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                       
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCall(currentProfilePic: widget.profilepic, profilepic: widget.profilepic, profileDetail: widget.newUserModel),));

                        },
                        icon: const Icon(
                          Icons.video_call,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AudioCall(profilepic: widget.profilepic, profileDetail: widget.newUserModel),));
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          List<Map<dynamic, dynamic>> data =
                              messages; // your list of maps
                          List<MessageText> messages2 = data
                              .map((map) => MessageText(
                                    text: (map['text'] != null)
                                        ? map['text']
                                        : "",
                                    uid: (map['uid'] != null) ? map['uid'] : "",
                                    type: (map['type'] != null)
                                        ? map['type']
                                        : "",
                                    imgname: (map['imgname'] != null)
                                        ? map['imgname']
                                        : "",
                                    time: (map['time'] != null)
                                        ? map['time']
                                        : "",
                                  ))
                              .toList();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => MySearchPage(
                                    messages: messages2,
                                  )));
                        },
                        icon: const Icon(
                          Icons.more_vert,
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
              margin: EdgeInsets.only(top: 25),
              height: MediaQuery.of(context).size.width * 2.3,
              child: Column(
                children: [
                  Expanded(
                    // FutureBuilder(
                    //   future: _dbref,
                    //   initialData: InitialData,
                    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //     return;
                    //   },
                    // ),
                    child: ChatList(
                      messages: messages,
                      uid: widget.newUserModel.id,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
           widget.profileDetail.email==widget.newUserModel.email?       Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(top: 15),
                    color: Colors.white,
                    child: Row(
                      children: [
                     const   SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            minLines: 2,
                            maxLines: 4,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sans-serif',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            controller: msg,
                            // onSubmitted: sendMessage,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: main_color, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    print("clicked");
                                    sendImage();
                                  },
                                  child: Icon(
                                    Icons.attach_file,
                                    color: main_color,
                                  ),
                                ),
                              ),
                              hintText: 'Type a message!',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            sendMessage(msg.text,"12345",widget.newUserModel.id);
                          },
                          child: Icon(
                            Icons.send,
                            color: main_color,
                          ),
                        ),
                      ],
                    ),
                  ):Center(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}
