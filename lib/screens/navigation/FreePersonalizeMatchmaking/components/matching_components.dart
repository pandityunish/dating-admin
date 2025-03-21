import 'package:flutter/material.dart';

import '../../../../globalVars.dart';

class MatchingComponents extends StatelessWidget {
  final String title;
  const MatchingComponents({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           Divider(),
                  Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
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
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dfkxcafte/image/upload/v1713673971/ic_launcher_inlm33.png",
                ),
                radius: 25,
              ),
              
            ),
          ),
          Divider(),
      ],
    );
  }
}