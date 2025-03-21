import 'package:flutter/material.dart';

import '../../globalVars.dart';
import '../../models/new_user_model.dart';

class AgeSelectionScreen extends StatefulWidget {
  
  const AgeSelectionScreen({super.key, });

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int _minAge =18;
  int _maxAge = 70;

  List<DropdownMenuItem<int>> _getDropdownItems(int start, int end) {
    List<DropdownMenuItem<int>> items = [];
    for (int i = start; i <= end; i++) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
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
            List<String> res = [ _minAge.toString(), _maxAge.toString()];
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
                AssetImage('images/icons/calender.png'),
                size: 25,
                color: main_color,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Age",
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
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Please Select Age Preference",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
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
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: Text("Min Age",style: TextStyle(color: main_color)),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              child: Text("Max Age",style: TextStyle(color: main_color),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: main_color),
                              child: Center(
                                  child: Text(
                                _minAge.toString(),
                                style: TextStyle(color: Colors.white),
                              ))),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: main_color),
                              child: Center(
                                  child: Text(
                                _maxAge.toString(),
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
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              // child: DropdownButton(
                              //     alignment: Alignment.center,
                              //     style: const TextStyle(
                              //         fontSize: 20, color: Colors.black),
                              //     items: porductCategories.map((String item) {
                              //       return DropdownMenuItem(
                              //           value: item, child: Text(item));
                              //     }).toList(),
                              //     value: categoty,
                              //     icon: const Icon(Icons.keyboard_arrow_down),
                              //     onChanged: (String? newval) {
                              //       setState(() {
                              //         categoty = newval!;
                              //       });
                              //     }),
                              child: DropdownButton<int>(
                                value: _minAge,
                                style: TextStyle(color: main_color),
                                iconEnabledColor: main_color,
                                items: _getDropdownItems(
                                    18,
                                    70),
                                onChanged: (int? value) {
                                  setState(() {
                                    _minAge = value!;
                                    if (_maxAge < _minAge) {
                                      _maxAge = _minAge;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: main_color, width: 1)),
                            child: Center(
                              // child: DropdownButton(
                              //     alignment: Alignment.center,
                              //     style: const TextStyle(
                              //         fontSize: 20, color: Colors.black),
                              //     items: porductCategories1.map((String item) {
                              //       return DropdownMenuItem(
                              //           value: item, child: Text(item));
                              //     }).toList(),
                              //     value: categoty1,
                              //     icon: const Icon(Icons.keyboard_arrow_down),
                              //     onChanged: (String? newval) {
                              //       setState(() {
                              //         categoty1 = newval!;
                              //       });
                              //     }),
                              child: DropdownButton<int>(
                                value: _maxAge,
                                 style: TextStyle(color: main_color),
                                iconEnabledColor: main_color,
                                items: _getDropdownItems(_minAge+1, 70),
                                onChanged: (int? value) {
                                  setState(() {
                                    _maxAge = value!;
                                    if (_maxAge < _minAge) {
                                      _minAge = _maxAge;
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
