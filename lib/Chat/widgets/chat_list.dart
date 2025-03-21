import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/info.dart';
import 'package:matrimony_admin/Chat/widgets/my_message_card.dart';
import 'package:matrimony_admin/Chat/widgets/sender_message_card.dart';

class ChatList extends StatefulWidget {
  ChatList({Key? key, this.messages,this.uid}) : super(key: key);
  var messages;
  var uid;
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  var messages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages = widget.messages;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]['uid'] ==widget. uid) {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(messages[index]['time']);
          return
              // Column(
              // children: [
              // MyImageCard(
              //   url: "dslkj",imageName: "adlskj",
              //   // date: messages[index]['time'].toString(),
              //   date: DateTime.now().toString().substring(11, 16),
              // ),
              (messages[index]['type'].toString() == 'img')
                  // ? MyImageCard(
                  //     url: messages[index]['text'].toString(),
                  //     date: dateTime.toString().substring(11, 16),
                  //     imageName: messages[index]['imgname'].toString())
                  ?Container()
                  : MyMessageCard(
                      message: messages[index]['text'].toString(),
                      // date: messages[index]['time'].toString(),
                      date: dateTime.toString().substring(11, 16),
                      // ),
                      //   ],
                    );
        } else {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(messages[index]['time']);
          return SenderMessageCard(
            date: dateTime.toString().substring(11, 16),
            message: messages[index]['text'].toString(),
            // date: messages[index]['time'].toString().substring(11, 16),
          );
        }
      },
    );
  }
}
