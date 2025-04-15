import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';
import 'package:matrimony_admin/screens/profie_types/profileservice.dart';
import 'package:matrimony_admin/screens/profie_types/sort_profile.dart';
import 'package:matrimony_admin/screens/profie_types/sort_search.dart';


import '../../Assets/ayushWidget/big_text.dart';

class SortProfileScreen extends StatelessWidget {
  const SortProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  text: "Sort By",
                  size: 20,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),

           
trailing: GestureDetector(
  onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SortSearch(
          
        )
    ));
  },
  child: Icon(Icons.search,color: main_color,)),
            previousPageTitle: "",
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                ListView.builder(
                  itemCount: profileActions.length,
                  shrinkWrap: true,
                  
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () async{
                        
                        List<NewUserModel> allprofiles=await ProfileService(). getsortdata(page: 1,searchtext:"New Profile To Old Profile" );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SortProfile(searchText:"New Profile To Old Profile" ,user_list: allprofiles,)));
                      
                      },
                     
                      child: SizedBox(
                                 width: Get.width*0.9,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            profileActions[index]["name"],
                            style: TextStyle(
                                color:profileActions[index]["name"]=="RESET"?Colors.red: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                    ],
                  );
                }, ),
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
