import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/screens/profie_types/advertisment_types/when_sign_up.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';
import '../service/search_profile.dart';
import 'advertisement_details.dart';

class ManageAdvertisiment extends StatefulWidget {
  const ManageAdvertisiment({super.key});

  @override
  State<ManageAdvertisiment> createState() => _ManageAdvertisimentState();
}

class _ManageAdvertisimentState extends State<ManageAdvertisiment> {
  List<dynamic> ads = [
    {"name": "Starting of App (Before Click on Gmail)", "id": "1"},
    {"name": "When User Would Click on Email for Sign Up", "id": "2"},
    {"name": "After Click on Other Option in Education (Sign up)", "id": "3"},
    {"name": "After Submit Other Education in Sign up", "id": "4"},
    {"name": "After Click on Other Option in Profession (Sign Up)", "id": "5"},
    {"name": "After Submit Other Profession in Sign up", "id": "6"},
    {"name": "After Sign up complete", "id": "7"},
    {"name": "After Every Sign in", "id": "8"},
    {"name": "When Use App Again During login (Every Time)", "id": "9"},
    {"name": "After Slide 10 Profiles", "id": "10"},
    {"name": "When click on more-1 every 5 users", "id": "11"},
    {"name": "When click on more-2 every 5 users", "id": "12"},
    {"name": "When Every click on Matching Score Ball", "id": "13"},
    {"name": "After Every 5 Interest Sent", "id": "14"},
    {"name": "After Cancel Every 5 Interest", "id": "15"},
    {"name": "After Every 5 Users Block", "id": "16"},
    {"name": "After Every 5 Users Unblock", "id": "17"},
    {"name": "After Every 5 Users Report", "id": "18"},
    {"name": "After Every 5 Users Unreport", "id": "19"},
    {"name": "After Every 5 Users Shortlist", "id": "20"},
    {"name": "After Every 5 Users Unshortlist", "id": "21"},
    {"name": "After Click on Every Accept Interest Button", "id": "22"},
    {"name": "After Click on Every Decline Interest Button", "id": "23"},
    {"name": "When user click on left menu icon", "id": "24"},
    {"name": "When User Click on Home (Refresh)", "id": "25"},
    {"name": "After Click on Search Profile Left Menu", "id": "26"},
    {"name": "When Search Profile by Profile ID", "id": "27"},
    {"name": "When User Search Profile by Only Distance", "id": "28"},
    {"name": "When Search Profile by Criteria", "id": "29"},
    {"name": "When user click Save Preference left menu", "id": "30"},
    {"name": "After Click on Save Button in save preference", "id": "31"},
    {"name": "After Click on Reset Button in save preference", "id": "32"},
    {"name": "After Click on Online Users Left Menu", "id": "33"},
    {"name": "When User Click on Profile Verified", "id": "34"},
    {"name": "When User Click on Free Personalised Matchmaking", "id": "35"},
    {"name": "After Click on Live Matchmaker (FPM)", "id": "36"},
    {"name": "By Click on Audio Call to Matchmaker (FPM)", "id": "37"},
    {"name": "By Click on Video Call to Matchmaker (FPM)", "id": "38"},
    {"name": "After Click on Live Astrologer (FPM)", "id": "39"},
    {"name": "By Click on Audio Call to Astrologer (FPM)", "id": "40"},
    {"name": "By Click on Video Call to Astrologer (FPM)", "id": "41"},
    {"name": "After Click on Chat Left Menu", "id": "42"},
    {"name": "After Click on Live Matchmaker (CHAT)", "id": "43"},
    {"name": "By Click on Audio Call to Matchmaker (CHAT)", "id": "44"},
    {"name": "By Click on Video Call to Matchmaker (CHAT)", "id": "45"},
    {"name": "After Click on Live Astrologer (CHAT)", "id": "46"},
    {"name": "By Click on Audio Call to Astrologer (CHAT)", "id": "47"},
    {"name": "By Click on Video Call to Astrologer (CHAT)", "id": "48"},
    {"name": "When User Click on User to User Chatroom", "id": "49"},
    {"name": "After Click on Audio Call (User to User)", "id": "50"},
    {"name": "After Click on Video Call (User to User)", "id": "51"},
    {"name": "After Click on Profile Name in Chatroom", "id": "52"},
    {"name": "Before Reply on Chat", "id": "53"},
    {"name": "After Click on Need Conference call", "id": "54"},
    {"name": "After Click on Block in Chat", "id": "55"},
    {"name": "After Click on Unblock in Chat", "id": "56"},
    {"name": "After Click on Report Chat", "id": "57"},
    {"name": "When User Click on Kundli Match Left Menu", "id": "58"},
    {"name": "After Click on Submit in Kundli Match", "id": "59"},
    {
      "name": "After Click on Download Matrimonial Biodata Left Menu",
      "id": "60"
    },
    {"name": "After Click on Download with Contact Button In DMB", "id": "61"},
    {
      "name": "After Click on Download Without Contact Button In DMB",
      "id": "62"
    },
    {"name": "After Click on Share with Contact Button In DMB", "id": "63"},
    {"name": "After Click on Share Without Contact Button In DMB", "id": "64"},
    {"name": "When User Click on Marriage Loan 0%", "id": "65"},
    {"name": "When User Click on Share App", "id": "66"},
    {"name": "When Click on Support", "id": "67"},
    {"name": "After Click on Help & Support in Support", "id": "68"},
    {"name": "After Click on Reply Button in Help & Support", "id": "69"},
    {"name": "When Admin Boost Profile", "id": "70"},
    {"name": "When Admin Invisible Profile", "id": "71"},
    {"name": "When Admin Send Link to Improve About me", "id": "72"},
    {
      "name": "When Admin Send Link to Improve About Partner Preference",
      "id": "73"
    },
    {"name": "When Admin Send Link about Upload Video", "id": "74"},
    {"name": "When Admin Send Link about Save Preference", "id": "75"},
    {"name": "When Admin Send Link about Save Education Manually", "id": "76"},
    {"name": "When Admin Send Link about Save Profession Manually", "id": "77"},
    {"name": "When Admin Send Link to Ask Rating", "id": "78"},
    {"name": "When Admin Send Link to Upload Photo", "id": "79"},
    {"name": "When Admin Send Link to Download Biodata", "id": "80"},
    {"name": "When Admin Send Link to Share App", "id": "81"},
    {"name": "When Admin Send Link to Show Support Reply", "id": "82"},
    {"name": "When Admin Share Profile", "id": "83"},
    {"name": "When User Would Click on Logout", "id": "84"},
    {"name": "When click on delete button", "id": "85"},
    {"name": "After Click on Edit Profile", "id": "86"},
    {"name": "After Click on Pics Locked Button", "id": "87"},
    {"name": "After Click on Pics Unlocked Button", "id": "88"},
    {"name": "After Click on Save Button by Edit Profile", "id": "89"},
    {"name": "When User Click on Notification Bell", "id": "90"},
    {
      "name": "After Click on Interest Sent Successfully Notification",
      "id": "91"
    },
    {
      "name": "After Click on Interest Cancel Successfully Notification",
      "id": "92"
    },
    {"name": "After Click on Receive Interest Notification", "id": "93"},
    {"name": "After Click on Accept Interest Notification", "id": "94"},
    {"name": "After Click on Decline Interest Notification", "id": "95"},
    {"name": "After Click on Block Successfully Notification", "id": "96"},
    {"name": "After Click on Unblock Successfully Notification", "id": "97"},
    {"name": "After Click on Report Successfully Notification", "id": "98"},
    {"name": "After Click on Unreport Successfully Notification", "id": "99"},
    {"name": "After Click on Shortlist Successfully Notification", "id": "100"},
    {
      "name": "After Click on Unshortlist Successfully Notification",
      "id": "101"
    },
    {"name": "When click on Query Resolved notification", "id": "102"},
    {"name": "After Try to Take ScreenShot", "id": "103"},
    {"name": "After Try to Do Screen Recording", "id": "104"},
    {"name": "Birthday wish", "id": "105"},
    {"name": "Occasion Wish", "id": "106"}
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
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

              // middle: Icon(
              //   Icons.supervised_user_circle_outlined,
              //   // color: ma/
              //   size: 30,
              // ),

              middle: Row(
                children: [
                  BigText(
                    text: "Manage Advertisement",
                    size: 20,
                    color: main_color,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),

              // TextSpan(
              //     text: ".in", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Showg")),

              previousPageTitle: "",
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: ads.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            SearchProfile().addtoadminnotification(
                                userid: userSave!.puid!,
                                useremail: userSave.email!,
                                userimage: userSave.imageUrls!.isEmpty
                                    ? ""
                                    : userSave.imageUrls![0],
                                title:
                                    "${userSave.displayName} SEEN ADVERTISIMENT-${index + 1} IN MANAGE ADVERTISIMENT",
                                email: userSave.email!,
                                subtitle: "");
                            if (ads[index] == "when sign up complete") {
                              Get.to(() => WhenSignUp());
                            } else if (ads[index]["name"] == "Occasion Wish") {
                            } else {
                              Get.to(AdvertisementDetails(
                                id: ads[index]["id"],
                              ));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              // side: BorderSide(width: 1, color: Colors.black26),
                              borderRadius: BorderRadius.circular(50)),
                          title: Text("Advertisement-${index + 1}"),
                          subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(ads[index]["name"])),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
