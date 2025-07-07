import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/data_collection/custom_app_bar.dart';
import 'package:matrimony_admin/screens/navigation/howToUse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matrimony_admin/screens/navigation/navigator.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import '../../common/widgetAll/circular_bubles.dart';
import '../../globalVars.dart';
import 'help&supp.dart';

class Support extends StatefulWidget {
  final NewUserModel newUserModel;
  const Support({Key? key, required this.newUserModel}) : super(key: key);

  @override
  State<Support> createState() => _ReligionState();
}

class _ReligionState extends State<Support> {
  int value = 0;
  int currentPageIndex = 0;
  var data;
  void getallsupprot() async {
    data = await SearchProfile().getsupports(widget.newUserModel.id);
    setState(() {});
  }

  @override
  void initState() {
    getallsupprot();
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(title: "Support", iconImage: 'images/icons/community.png'),
        body: Stack(
          children: [
            Container(
             
              child: SingleChildScrollView(
                child: data == null
                    ? Center()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1591969851586-adbbd4accf81?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: false),
                                        autoPlay: true)
                                    // .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1513279922550-250c2129b13a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1531747056595-07f6cbbe10ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.2, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1637870996864-65dc1c00f4dc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.3, duration: 3000.ms)
                                    .then()
                                    .slideY(end: 0.3, duration: 3000.ms)
                                    .then()
                                    .slideX(end: -0.3, duration: 3000.ms)
                                    .then()
                                    .slideY(end: -0.3, duration: 3000.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1481841580057-e2b9927a05c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://media.istockphoto.com/id/1435198934/photo/this-is-my-life.jpg?s=612x612&w=is&k=20&c=ap2OM4yROkRUDD0KF08n_yjpMkgEKvmx-8zPoc2jYA4=")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.4, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.4, duration: 3000.ms)
                                    .then()
                                    .slideY(end: 0.05, duration: 1000.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 400.ms)
                                    .then()
                                    // .slideY(end: 0.4, duration: 400.ms)
                                    // .then()
                                    .slideX(end: -0.1, duration: 400.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 400.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1591969851586-adbbd4accf81?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: false),
                                        autoPlay: true)
                                    // .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                                SizedBox(
                                  width: 50,
                                ),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1513279922550-250c2129b13a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1531747056595-07f6cbbe10ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1000.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1559435578-231f6137aac5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1501901609772-df0848060b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.2, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.2, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1558037865-65d4bcdc37ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1396&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://plus.unsplash.com/premium_photo-1676690624558-d05cf3f1d1bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: 0.1, duration: 1500.ms)
                                    .then()
                                    .slideX(end: -0.1, duration: 1500.ms)
                                    .then()
                                    .slideY(end: -0.1, duration: 1500.ms)
                                    .then(),
                                CircularBubles(
                                        url:
                                            "https://images.unsplash.com/photo-1556229868-7b2d4b56b909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80")
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                        autoPlay: true)
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideX(end: -0.2, duration: 1000.ms)
                                    .then()
                                    .slideY(end: 0.2, duration: 1000.ms)
                                    .then(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
              ),
            ),
            // RiveAnimation.asset(
            //   "RiveAssets/onboard_animation.riv",
            // ),
            data == null
                ? Center()
                : Center(
                    child: SizedBox(
                      height: 330,
                      width: Get.width * 0.9,
                      child: Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Help & Support",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Text("Query Raised",style: TextStyle(fontWeight: FontWeight.bold),),

                                SizedBox(
                                  height: 180,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                   data.isEmpty ?Center():   GestureDetector(
                                          onTap: () {
                                            _pageController.previousPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: Icon(Icons.arrow_back_ios)),
                                      if (data.isEmpty) ...[
                                        Card(
                                           elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                          child: SizedBox(
                                            height: 290,
                                            width: Get.width * 0.6,
                                          
                                            child: Center(
                                              child: Text("No data"),
                                            ),
                                          ),
                                        )
                                      ] else ...[
                                        SizedBox(
                                          height: 290,
                                          width: Get.width * 0.7,
                                          child: PageView.builder(
                                            controller: _pageController,
                                            onPageChanged: _onPageChanged,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Card(
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: Get.width * 0.6,
                                                        height: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: SingleChildScrollView(

                                                          child: Text(data[index]
                                                              ["description"]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                 
                                                  Text(
                                                  "Query-${data.length - index} Send on ${  DateFormat(
                                                            'EEEE MMMM d y H:m')
                                                        .format(DateTime.parse(
                                                                data[index][
                                                                    "updatedAt"])
                                                            .toLocal())}",style: TextStyle(color: Colors.black,fontSize: 12),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                   data.isEmpty?Center():   GestureDetector(
                                          onTap: () {
                                            _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: Icon(Icons.arrow_forward_ios)),
                                    ],
                                  ),
                                ),
                                  if (data.isEmpty) ...[
                                        
                                      ] else if (currentPageIndex == 0) ...[
                                SizedBox(
                                  width: Get.width * 0.6,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (data[0]["isAdmin"] == false) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HelpSupport(
                                                      newUserModel:
                                                          widget.newUserModel,
                                                    )));
                                      }
                                    },
                                    child: Text(
                                      data[0]["isAdmin"] == false
                                          ? 'Reply'
                                          : "Replied",
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                            EdgeInsets.symmetric(
                                                horizontal: 70, vertical: 12)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                                side: BorderSide(
                                                    color: Colors.white))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                  ),
                                ),
                                ],
                              ],
                            ),
                          )),
                    ),
                  ),
          ],
        ));
  }
}
