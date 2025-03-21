import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import '../../../../Assets/ayushWidget/big_text.dart';
import 'package:fl_chart/fl_chart.dart';

class UserDemographic extends StatelessWidget {
  const UserDemographic({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = [
      {"name": "Male", "number": 30.0, "color": getRandomColor()},
      {"name": "Female", "number": 50.1, "color": getRandomColor()},
    ];
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
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
              children: [
                BigText(
                  text: "Demographic",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            trailing: Icon(Icons.calendar_month),
            previousPageTitle: "",
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Indicator(
                            color: data[index]["color"],
                            text: data[index]["name"],
                            isSquare: false,
                            size: 30,
                            textColor: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.5,
                  child: PieChart(
                    PieChartData(
                      sections: data.map((value) {
                        double malePercentage = (value["number"] / 100) * 100;
                        return PieChartSectionData(
                          color: value["color"],
                          value: value["number"],
                          title: "$malePercentage%",
                          titleStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      borderData: FlBorderData(show: true),
                      sectionsSpace: 4,
                      centerSpaceRadius: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.isSquare = false,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
