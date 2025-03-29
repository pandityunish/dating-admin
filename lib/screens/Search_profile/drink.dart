import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/screens/data_collection/smoke.dart';

import '../../globalVars.dart';

String? DrinkStatus;

class Drink extends StatefulWidget {
  Drink({
    super.key,
    required this.value,
    required this.option,
  });
  List<int> value;
  List<String> option;
  @override
  State<Drink> createState() => _ReligionState();
}

class _ReligionState extends State<Drink> {
  List<int> value = [];

  @override
  void initState() {
    // TODO: implement initState
    value = widget.value;
  }

  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        // print("clicked");
        if (index == 0) {
          if (value.contains(index)) {
            setState(() {
              value.clear();
            });
          } else {
            value.clear();
            for (var i = 0; i < widget.option.length; i++) {
              print(i);
              setState(() {
                // DrinkStatus = text;
                value.add(i);
                // setData();
              });
            }
          }
        } else {
          if (value.contains(0)) {
            value.clear();
          }
          if (value.contains(index)) {
            setState(() {
              value.remove(index);
            });
          } else {
            setState(() {
              // DrinkStatus = text;
              value.add(index);
              // setData();
            });
          }
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value.contains(index)) ? main_color : Colors.black,
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value.contains(index))
                          ? main_color
                          : Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(
      children: [
        // SizedBox(
        //   height: 10,
        // ),
        Center(
            child: Container(
          // height: MediaQuery.of(context).size.height * 0.68,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Expanded(
                // child:
                // Column(
                //   children: [
                //     SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.9,
                //         child: CustomRadioButton("Any", 0)),
                //   ],
                // ),

                ListView.builder(
                    itemCount: widget.option.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          // Column(
                          //   children: [
                          //     Container(
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.9,
                          //         child: CustomRadioButton("Any", 0)),
                          //   ],
                          // ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: CustomRadioButton(
                                  widget.option[index], index)),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
                // // )
              ],
            ),
          ),
        ))
      ],
    ));
  }
}

// dynamic setData() async{
//   print(DrinkStatus);
//   final docUser = FirebaseFirestore.instance
//       .collection('user_data')
//       .doc(uid);

//   final json = {
//     'Drink': DrinkStatus,
//     // 'dob': dob
//   };

//   await docUser.update(json).catchError((error) => print(error));
// }
/*dynamic setData() async {
  SharedPref sharedPref = SharedPref();
  final json2 = await sharedPref.read("uid");
  var uid = json2['uid'];
  print(DrinkStatus);
  final docUser = FirebaseFirestore.instance.collection('user_data').doc(uid);
  try {
    User? userSave = User.fromJson(await sharedPref.read("user"));
    print(userSave.toString());

    userSave.Drink = DrinkStatus;
    print(userSave.toJson().toString());
    final json = userSave.toJson();

    await docUser.update(json).catchError((error) => print(error));

    sharedPref.save("user", userSave);
  } catch (Excepetion) {
    print(Excepetion);
  }
}*/
