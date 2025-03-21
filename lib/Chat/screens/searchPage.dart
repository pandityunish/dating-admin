import 'package:flutter/material.dart';

import '../info.dart';

class MySearchPage extends StatefulWidget {
  final List<MessageText> messages;

  MySearchPage({required this.messages});

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List<MessageText> filteredMessages = [];

  @override
  void initState() {
    super.initState();
    filteredMessages = widget.messages;
  }

  void filterMessages(String query) {
    List<MessageText> tempMessages = [];
    tempMessages.addAll(widget.messages);
    if (query.isNotEmpty) {
      List<MessageText> filteredList = [];
      tempMessages.forEach((message) {
        if (message.type == 'txt' && message.text.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(message);
        }
      });
      setState(() {
        filteredMessages = filteredList;
      });
    } else {
      setState(() {
        filteredMessages = widget.messages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Messages'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterMessages(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search messages...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredMessages[index].text),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
