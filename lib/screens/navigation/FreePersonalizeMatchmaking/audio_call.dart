// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';

import '../../../models/new_user_model.dart';


class AudioCall extends StatefulWidget {
  final String profilepic;
  final NewUserModel profileDetail;
  const AudioCall({
    Key? key,
    required this.profilepic,
    required this.profileDetail,
  }) : super(key: key);

  @override
  State<AudioCall> createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  TextEditingController _searchController = TextEditingController();
  bool isAudio = false;
  bool isSpeaker = false;
  bool isButton = false;
  bool isSearch=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF38B9F3),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Color(0xFF38B9F3),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.profilepic),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    (widget.profileDetail.name != '')
                        ? "${widget.profileDetail.name.substring(0, 1).toUpperCase()} ${widget.profileDetail.surname.substring(0, 1).toUpperCase() + widget.profileDetail.surname.substring(1).toLowerCase()}"
                        : "",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.profileDetail.puid,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Outgoing Audio Call",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
            isButton
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isButton = !isButton;
                            isSearch = !isSearch;
                          });
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.more_vert),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                     isSearch? Column(
                      children: [
                      SizedBox(
                        width: 200,
                        child: CupertinoSearchTextField(
                          controller: _searchController,
                          backgroundColor: Colors.white,
                          onChanged: (value) {
                         
                          },
                          onSubmitted: (value) {
                          
                          },
                          onSuffixTap: () {
                          setState(() {
                           _searchController.clear();
                          });
                          },
                        ),
                      ),
                      ]): InkWell(
                        onTap: (){
                          setState(() {
                            isSearch = !isSearch;
                          });
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: main_color,
                            ),
                          ),
                        ),
                      ),
                 

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                          child: Icon(
                            Icons.call_end,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: Get.width * 0.5,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isSpeaker=!isSpeaker;
                                  });
                                },
                                child: Image.asset("images/icons/Speaker.png",color:isSpeaker? main_color:Colors.black,)),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      isButton = !isButton;
                                    });
                                  },
                                  child: Icon(Icons.more_vert)),
                            isAudio?
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isAudio=!isAudio;
                                });
                              },
                              child: Icon(Icons.mic_off)):
                            InkWell(
                               onTap: () {
                                setState(() {
                                  isAudio=!isAudio;
                                });
                              },
                              child: Icon(Icons.mic))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
