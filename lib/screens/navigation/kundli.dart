import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Assets/ayushWidget/big_text.dart';
import '../../globalVars.dart';

class Kundli extends StatefulWidget {
  const Kundli({super.key});

  @override
  State<Kundli> createState() => _KundliState();
}

class _KundliState extends State<Kundli> {
  DateTime? pickedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.only(top: 25, left: 20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: main_color,
                      size: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    BigText(
                      text: "Kundli Match",
                      size: 20,
                      color: main_color,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 25, right: 8, bottom: 15),
                  child: BigText(text: "Groom's Information")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoTextField(
              placeholder: "Groom's Name",
              // controller: name,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.black,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (name) => {
                setState(() {
                  // this.User_Name = name;
                })
              },
              onSubmitted: (User_Name) => print('Submitted $User_Name'),
            ),
          ),
          Row(
            children: [
              Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 25, right: 8, bottom: 15),
                  child: BigText(text: "Date Of Birth")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.width / 6,
                    child: Center(
                        child: TextField(
                      // controller: dateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        // labelText: "Enter Date" //label text of field
                      ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate!);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16

                          DateTime birthday = DateTime(pickedDate!.year,
                              pickedDate!.month, pickedDate!.day);

                          DateDuration duration;

                          // Find out your age as of today's date 2021-03-08
                          duration = AgeCalculator.age(birthday);

                          print(
                              'Your age is $duration'); // Your age is Years: 24, Months: 0, Days: 3

                          // setState(() {
                          //   dateInput.text =
                          //       formattedDate; //set output date to TextField value.
                          //   dob = duration.toString();
                          // });
                        } else {}
                      },
                    )))),
          ),
          //   DefaultTextStyle(
          //       style: GoogleFonts.poppins(
          //         color: Colors.black,
          //         fontSize: 25,
          //       ),
          //       child: Text("$dob")),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Pick Birth Time'),
            color: main_color,
          )
        ],
      ),
    );
  }
}
