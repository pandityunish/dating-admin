import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       home: ChatPagetemp(),
//     );
//   }
// }

class ChatPagetemp extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPagetemp> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Chat> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*.7,
                      height: 200,
                      child: Image(image: NetworkImage(chats[index].imageUrl),fit: BoxFit.cover,)),
                    ListTile(
                      title: Text('Message ${index + 1}'),
                      subtitle: Text(chats[index].message),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  // Upload the image file to the Firebase Storage bucket.
                  ImagePicker _picker = ImagePicker();

                  var imageFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  var storageRef = _storage.ref();
                  var imageRef = storageRef.child('images/${imageFile!.name}');
                  File file = File(imageFile.path);
                  await imageRef.putFile(file);

                  // Get the download URL for the image file.
                  final downloadUrl = await imageRef.getDownloadURL();

                  // Add a new message to the chat list.
                  setState(() {
                    chats.add(
                      Chat(
                        message: _messageController.text,
                        imageUrl: downloadUrl,
                      ),
                    );
                    print(chats.toString());
                  });

                  // Clear the message text field.
                  _messageController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Chat {
  String message;
  String imageUrl;

  Chat({this.message = "", this.imageUrl = ""});
}
