import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';

class AudioClipScreen extends StatefulWidget {
  final String isBulk;
  const AudioClipScreen({super.key, required this.isBulk});

  @override
  State<AudioClipScreen> createState() => _AudioClipScreenState();
}

class _AudioClipScreenState extends State<AudioClipScreen> {
  String? _filePath;

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    print(widget.isBulk);
    return Material(
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: main_color,
                size: 25,
              ),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: DefaultTextStyle(
                      style:
                          GoogleFonts.poppins(color: main_color, fontSize: 25),
                      child: Text("Send Audio clip")),
                )
              ],
            ),
            previousPageTitle: "",
          ),
          child: PageView.builder(
            itemCount: 4,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: Get.width * 0.95,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _filePath == null
                                      ? Column(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _pickAudio();
                                                },
                                                icon: Icon(Icons.add)),
                                            Text("Upload a audio clip")
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            _pickAudio();
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                _filePath != null
                                                    ? 'Picked file: ${_filePath}'
                                                    : 'No file picked.',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  index == 0
                                      ? Container()
                                      : IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          onPressed: () => {
                                                _pageController.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                )
                                              }),
                                  IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      onPressed: () => {
                                            _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            )
                                          }),
                                ],
                              ),
                            ),
                          ),
                          index == 0
                              ? Center()
                              : Column(
                                  children: [
                                    Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shadowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.black),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry?>(
                                      EdgeInsets.symmetric(vertical: 13)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    // side: BorderSide(
                                    //   color: (value == false)
                                    //       ? Colors.white
                                    //       : main_color,
                                    // )
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: Text(
                                "Send Audio Clip",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () async {
                                // }else{

                                // }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          index == 0
                              ? Center()
                              : Column(
                                  children: [
                                    Text("Send by admin1"),
                                    Text("21 May 2023 10:20"),
                                    widget.isBulk == "false"
                                        ? Center()
                                        : Text("Bulk"),
                                  ],
                                ),
                          widget.isBulk == "false"
                              ? Center()
                              : Column(
                                  children: [
                                    Text("Users"),
                                    Text("Pending:200"),
                                    Text("Received:100"),
                                    Text("Cut:50"),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ))
                ],
              );
            },
          )),
    );
  }
}
