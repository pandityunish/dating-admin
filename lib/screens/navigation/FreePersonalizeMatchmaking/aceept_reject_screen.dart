import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../globalVars.dart';
import 'free_chat_screen.dart';

class AcceptRejectScreen extends StatefulWidget {
  final String title;
  const AcceptRejectScreen({super.key, required this.title});

  @override
  State<AcceptRejectScreen> createState() => _AcceptRejectScreenState();
}

class _AcceptRejectScreenState extends State<AcceptRejectScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: GestureDetector(
                onTap: () {
              Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: main_color,
                  size: 25,
                ),
              ),
              // middle: Icon(
              //   Icons.supervised_user_circle_outlined,
              //   // color: ma/
              //   size: 30,
              // ),
              middle:
                  Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
                TextSpan(
                    text: widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, )),
              
             
              ])),
              previousPageTitle: "",
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    return ListTile(
                      
                      leading: GestureDetector(
                        onTap: () {
                                                  Get.to(FreeChatScreen(name: "Yunish Pandit",uid: "LKJFALSKJDFLK",));

                        },
                        child: CircleAvatar(
                          radius: 20,
                        ),
                      ),

                      title: GestureDetector(
                        onTap: () {
                          Get.to(FreeChatScreen(name: "Yunish Pandit",uid: "LKJFALSKJDFLK",));
                          
                        },
                        child: Text("Yunish Pandit",style: TextStyle(fontWeight: FontWeight.bold),)),
                      subtitle: Text("FAEKLAJDLKJ"),
                      trailing: SizedBox(
                        width: Get.width*0.42,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: main_color,
                                  width: 2
                                ),
                              ),
                              child: Center(
                                child: Text("Accept",style: TextStyle(fontWeight: FontWeight.bold,color: main_color),),
                              ),
                            ),
                             Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2
                                ),
                              ),
                              child: Center(
                                child: Text("Reject",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  },)
              
                ],
              ),
            ),
            )),
    );
  }
}