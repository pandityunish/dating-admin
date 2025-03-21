
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/Assets/ayushWidget/big_text.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/main.dart';
import 'package:matrimony_admin/screens/profile/profileScroll.dart';

class HoroScopePage extends StatelessWidget {
  const HoroScopePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: GestureDetector(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => SlideProfile(),));
              // Navigator.pop(context);
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
                  text: "Horoscope Matching Point",
                  size: 20,
                  color: main_color,
                  
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            previousPageTitle: "",
          ),
          child: SafeArea(child: Container(
             width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.only(left: 10, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
          Container(
            height: Get.height*0.15,
            width: Get.width,
            color: const Color.fromARGB(255, 230, 230, 230),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("26.0",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 60,

                  color: main_color ,decoration: TextDecoration.none,
                   fontFamily:
                          "Sans-serif",
                  textBaseline: TextBaseline.alphabetic),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    
                    child: Text("/36",style: TextStyle(fontSize: 20,color:main_color ,
                    decoration: TextDecoration.none,textBaseline: TextBaseline.alphabetic,
                     fontFamily:  "Sans-serif",),),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Gagan has Low Mangal Dosha and Sita has High Mangal Dosha",
            
            style: TextStyle(fontSize: 14,color: Colors.black,
             fontFamily:
                                                            "Sans-serif",
            decoration: TextDecoration.none,fontStyle: FontStyle.normal),),
          ),
         SizedBox(height: 15,),
          Container(
            
            width: Get.width,
            color: const Color.fromARGB(255, 230, 230, 230),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    Text("* Horoscope Conclusion:",style: TextStyle(fontSize: 14,color: Colors.black , fontFamily:
                                                            "Sans-serif",decoration: TextDecoration.none,),),
                    SizedBox(height: 5,),
                   Text("This marriage is NOT preferable due to Mangal Dosha and low match points obtainted.",style: TextStyle(fontSize: 14,color: Colors.black ,decoration: TextDecoration.none, fontFamily:
                                                            "Sans-serif",),),
                  ],
                ),
              ),
            ),
          ),
                ],
              ),
            ),
          )),
          ),
          
    );
  }
}