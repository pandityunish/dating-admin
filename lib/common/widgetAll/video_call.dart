import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/globalVars.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isSearch = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              top: 40,
              right: 30,
              child: Container(
                height: 250,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1503443207922-dff7d543fd0e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80"),
                        fit: BoxFit.cover)),
              )),
          Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isSearch
                        ? Column(children: [
                            SizedBox(
                              width: 200,
                              child: CupertinoSearchTextField(
                                controller: _searchController,
                                backgroundColor: Colors.white,
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                onSuffixTap: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                },
                              ),
                            ),
                          ])
                        : InkWell(
                            onTap: () {
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                          child: Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 223, 223, 223),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.volume_off)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.videocam_off)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.mic_off))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
