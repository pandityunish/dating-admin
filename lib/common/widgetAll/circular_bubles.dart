import 'dart:io';

import 'package:flutter/material.dart';

import '../../globalVars.dart';

class CircularBubles extends StatelessWidget {
  final String url;
  const CircularBubles({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: main_color, width: 3),
          image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              fit: BoxFit.cover)),
    );
  }
}

class CircularBubles1 extends StatelessWidget {
  final String url;
  final VoidCallback? onclick;
  final String? fileimage;
  final int index;
  const CircularBubles1({super.key, required this.url, this.onclick, this.fileimage,required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: main_color, width: 3),
              image:fileimage==null? DecorationImage(
                  image: NetworkImage(
                    url,
                  ),
                  fit: BoxFit.cover):DecorationImage(
                  image: FileImage(
                    File(fileimage!),
                  ),
                  fit: BoxFit.cover)),
        ),
     index==0?   Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              onPressed: onclick,
             icon: Icon( Icons.edit_square,
              color: main_color,),
            )):Container()
      ],
    );
  }
}
