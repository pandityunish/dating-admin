import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/colors.dart';
import 'package:matrimony_admin/globalVars.dart';

class MatchingComponents extends StatelessWidget {
  final String title;
  const MatchingComponents({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          //  Divider(),
                  Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: ListTile(
              title:Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            
              leading: CircleAvatar(
                backgroundColor: main_color,
                backgroundImage: AssetImage(
                  "images/newlogo.png",
                ),
                radius: 20,
              ),
              
            ),
          ),
          Divider(color: dividerColor,),
      ],
    );
  }
}