// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSlide extends StatefulWidget {
  final String newdate;
  final String olddate;
  const DateSlide({super.key, required this.newdate, required this.olddate});
  @override
  State<DateSlide> createState() => _DateSlideState();
}

class _DateSlideState extends State<DateSlide> {
  List allitems = [];
  @override
  void initState() {
    allitems = [widget.newdate, widget.olddate];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      height: 15,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.white
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 50,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          aspectRatio: 16 / 9,
          viewportFraction: 1,
        ),
        itemCount: allitems.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Text(
          DateFormat('d MMMM y', 'en_US')
              .format(DateTime.parse(allitems[itemIndex])),
          style: TextStyle(
            fontFamily: "Sans-serif",
            fontSize: 14,
            color: itemIndex == 1 ? Colors.white : Colors.green,
            // color: Colors.white,
            fontWeight: FontWeight.w400,
            shadows: <Shadow>[
              Shadow(
                  color: itemIndex == 1 ? Colors.black : Colors.green,
                  blurRadius: 5.0)
            ],
          ),
        ),
      ),
    );
  }
}
