import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globalVars.dart';
import '../../models/user_model.dart';

class HeightScreens extends StatefulWidget {
  const HeightScreens({super.key});

  @override
  State<HeightScreens> createState() => _HeightScreensState();
}

class _HeightScreensState extends State<HeightScreens> {
  SearchDataList sdl = SearchDataList();
  int _minHeight = 0; 
  int _maxHeight = 60; 
  late List<DropdownMenuItem<int>> _minHeightDropdownItems;
  late List<DropdownMenuItem<int>> _maxHeightDropdownItems;

  List<DropdownMenuItem<double>> _getDropdownItems(int start, int end) {
    List<DropdownMenuItem<double>> items = [];
    for (int i = start; i <= end; i += 1) {
      items.add(
        DropdownMenuItem(
          value: i *1.0,
          child: Text(sdl.Height[i]),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            List<String> res = [_minHeight.toString(), _maxHeight.toString()];
            Navigator.of(context).pop(res);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: main_color,
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImageIcon(
                AssetImage('images/icons/height.png'),
                size: 18,
                color: main_color,
              ),
              Text(
                "Height",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: main_color,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Please Select Height Preference",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'Sans-serif'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 223, 223),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 26,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: Text(
                                "Min Height",
                                style:
                                    TextStyle(color: main_color, fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: Text(
                                "Max Height",
                                style:
                                    TextStyle(color: main_color, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 26,
                              width: 70,
                              decoration: BoxDecoration(color: main_color),
                              child: Center(
                                  child: Text(
                                sdl.Height[_minHeight],
                                style: TextStyle(color: Colors.white),
                              ))),
                          Container(
                              height: 26,
                              width: 70,
                              decoration: BoxDecoration(color: main_color),
                              child: Center(
                                  child: Text(
                                sdl.Height[_maxHeight],
                                style: TextStyle(color: Colors.white),
                              ))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 26,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: DropdownButton<double>(
                                value: _minHeight *1.0 ,
                                style: TextStyle(fontSize: 12,color: main_color),
                                iconSize: 12,
                                items: _getDropdownItems(0, 60),
                                onChanged: (double? value) {
                                  setState(() {
                                    _minHeight = value!~/1;
                                    if (_maxHeight < _minHeight) {
                                      _maxHeight = _minHeight;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: DropdownButton<double>(
                                value: _maxHeight *1.0,
                                style: TextStyle(fontSize: 12,color: main_color),
                                iconSize: 12,
                                iconEnabledColor: main_color,
                                items: _getDropdownItems(_minHeight, 60),
                                onChanged: (double? value) {
                                  setState(() {
                                    _maxHeight = value!~/1;
                                    if (_maxHeight < _minHeight) {
                                      _minHeight = _maxHeight;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
