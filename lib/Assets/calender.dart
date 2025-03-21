// import 'package:age_calculator/age_calculator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/material.dart';

// List<String> list1 = <String>[
//   'Year',
//   '1990',
//   '1991',
//   '1992',
//   '1993',
//   '1994',
//   '1995',
//   '1996',
//   '1997',
//   '1998',
//   '1999',
//   '2000',
//   '2001',
//   '2002',
//   '2003',
//   '2004',
//   '2005',
//   '2006',
//   '2007',
//   '2008',
//   '2009',
//   '2010',
//   '2011',
//   '2012',
//   '2013',
//   '2014',
//   '2015',
//   '2016',
//   '2017',
//   '2018',
//   '2019',
//   '2020',
//   '2021',
//   '2022',
//   '2023',
//   '2024'
// ]; //'2000',
// List<String> list2 = <String>['Date', 'Two', 'Three', 'Four'];
// List<String> list3 = <String>[
//   'Month',
//   'January',
//   'February',
//   'March',
//   'April',
//   'May',
//   'June',
//   'July',
//   'August',
//   'September',
//   'October',
//   'November',
//   'December'
// ];
// List<String> list4 = <String>['Date'];

// List<String> list5 = <String>[
//   'Date',
//   '01',
//   '02',
//   '03',
//   '04',
//   '05',
//   '06',
//   '07',
//   '08',
//   '09',
//   '10',
//   '11',
//   '12',
//   '13',
//   '14',
//   '15',
//   '16',
//   '17',
//   '18',
//   '19',
//   '20',
//   '21',
//   '22',
//   '23',
//   '24',
//   '25',
//   '26',
//   '27',
//   '28',
//   '29',
//   '30'
// ];

// List<String> list6 = <String>[
//   'Date',
//   '01',
//   '02',
//   '03',
//   '04',
//   '05',
//   '06',
//   '07',
//   '08',
//   '09',
//   '10',
//   '11',
//   '12',
//   '13',
//   '14',
//   '15',
//   '16',
//   '17',
//   '18',
//   '19',
//   '20',
//   '21',
//   '22',
//   '23',
//   '24',
//   '25',
//   '26',
//   '27',
//   '28',
//   '29'
// ];

// List<String> list7 = <String>[
//   'Date',
//   '01',
//   '02',
//   '03',
//   '04',
//   '05',
//   '06',
//   '07',
//   '08',
//   '09',
//   '10',
//   '11',
//   '12',
//   '13',
//   '14',
//   '15',
//   '16',
//   '17',
//   '18',
//   '19',
//   '20',
//   '21',
//   '22',
//   '23',
//   '24',
//   '25',
//   '26',
//   '27',
//   '28'
// ];
// List<String> list8 = <String>['Date'];

// class Calender extends StatefulWidget {
//   const Calender({super.key, required this.pickedDate});
//   final pickedDate;
//   @override
//   State<Calender> createState() => _CalenderState();
// }

// class _CalenderState extends State<Calender> {
//   String dropdownValuem1 = list1.first;
//   String dropdownValuem2 = list2.first;
//   String dropdownValuem3 = list3.first;
//   String dropdownValuem4 = list8.first;
//   String? mmonth;

//   DateDuration? duration;
//   DateDuration? dateOfBirth;

//   DateTime? dateTime;
//   // void pickdate() async {
//   //   dateTime = await showDatePicker(
//   //       context: context,
//   //       initialDate: DateTime.now(),
//   //       firstDate: DateTime(1950),
//   //       lastDate: DateTime(2025));
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () {},
//           child: Card(
//             elevation: 4,
//             color: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             child: SizedBox(
//               height: 46,
//               width: 100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Center(
//                   //     child: Text(
//                   //   "Date",
//                   //   style:
//                   //       TextStyle(fontWeight: FontWeight.bold),
//                   // )),
//                   // Icon(Icons.keyboard_arrow_down)
//                   DropdownButton<String>(
//                     value: dropdownValuem4,
//                     underline: Container(
//                       color: Colors.white,
//                     ),
//                     icon: const Icon(Icons.arrow_drop_down),
//                     style: const TextStyle(color: Colors.black45),
//                     onTap: () {
//                       setState(() {});
//                     },
//                     onChanged: (String? value) {
//                       // This is called when the user selects an item.
//                       dropdownValuem4 = value!;
//                       DateTime dt = DateTime.parse(dropdownValuem1.toString() +
//                           mmonth! +
//                           dropdownValuem4.toString());
//                       print(dt);
//                       duration = AgeCalculator.age(dt);
//                       dateOfBirth = duration;
//                       // dropdownValue1 = list1.first;
//                       // dropdownValue2 = list2.first;
//                       // dropdownValue3 = list3.first;
//                       // dropdownValue4 = list8.first;
//                       setState(() {
//                         widget.pickedDate = dateOfBirth;
//                       });
//                     },
//                     items: list4.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Card(
//             elevation: 4,
//             color: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             child: SizedBox(
//               height: 46,
//               width: 100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Center(
//                   //     child: Text(
//                   //   "Month",
//                   //   style:
//                   //       TextStyle(fontWeight: FontWeight.bold),
//                   // )),
//                   // Icon(Icons.keyboard_arrow_down)
//                   DropdownButton<String>(
//                     value: dropdownValuem3,
//                     underline: Container(
//                       color: Colors.white,
//                     ),
//                     icon: const Icon(Icons.arrow_drop_down),
//                     style: const TextStyle(color: Colors.black45),
//                     onChanged: (String? value) {
//                       // This is called when the user selects an item.

//                       dropdownValuem3 = value!;
//                       if (dropdownValuem3 == 'January') {
//                         mmonth = '01';
//                       } else if (dropdownValuem3 == 'February') {
//                         mmonth = '02';
//                       } else if (dropdownValuem3 == 'March') {
//                         mmonth = '03';
//                       } else if (dropdownValuem3 == 'April') {
//                         mmonth = '04';
//                       } else if (dropdownValuem3 == 'May') {
//                         mmonth = '05';
//                       } else if (dropdownValuem3 == 'June') {
//                         mmonth = '06';
//                       } else if (dropdownValuem3 == 'July') {
//                         mmonth = '07';
//                       } else if (dropdownValuem3 == 'August') {
//                         mmonth = '08';
//                       } else if (dropdownValuem3 == 'September') {
//                         mmonth = '09';
//                       } else if (dropdownValuem3 == 'October') {
//                         mmonth = '10';
//                       } else if (dropdownValuem3 == 'November') {
//                         mmonth = '11';
//                       } else if (dropdownValuem3 == 'December') {
//                         mmonth = '12';
//                       }
//                       if (mmonth == '01' ||
//                           mmonth == '03' ||
//                           mmonth == '05' ||
//                           mmonth == '07' ||
//                           mmonth == '08' ||
//                           mmonth == '10' ||
//                           mmonth == '12') {
//                         list4 = <String>[
//                           'Date',
//                           '01',
//                           '02',
//                           '03',
//                           '04',
//                           '05',
//                           '06',
//                           '07',
//                           '08',
//                           '09',
//                           '10',
//                           '11',
//                           '12',
//                           '13',
//                           '14',
//                           '15',
//                           '16',
//                           '17',
//                           '18',
//                           '19',
//                           '20',
//                           '21',
//                           '22',
//                           '23',
//                           '24',
//                           '25',
//                           '26',
//                           '27',
//                           '28',
//                           '29',
//                           '30',
//                           '31'
//                         ];
//                       }
//                       if (mmonth == '04' ||
//                           mmonth == '06' ||
//                           mmonth == '09' ||
//                           mmonth == '11') {
//                         list4 = list5;
//                       }
//                       if (mmonth == '02' &&
//                           int.parse(dropdownValuem1) % 4 == 0) {
//                         list4 = list6;
//                       }
//                       if (mmonth == '02' &&
//                           int.parse(dropdownValuem1) % 4 != 0) {
//                         list4 = list7;
//                       }
//                       print(mmonth);
//                       setState(() {});
//                     },
//                     items: list3.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Card(
//             elevation: 4,
//             color: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             child: SizedBox(
//               height: 46,
//               width: 100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Center(
//                   //     child: Text(
//                   //   "Year",
//                   //   style:
//                   //       TextStyle(fontWeight: FontWeight.bold),
//                   // )),
//                   // Icon(Icons.keyboard_arrow_down)

//                   DropdownButton<String>(
//                     value: dropdownValuem1,
//                     underline: Container(
//                       color: Colors.white,
//                     ),
//                     icon: const Icon(Icons.arrow_drop_down),
//                     style: const TextStyle(color: Colors.black45),
//                     onChanged: (String? value) {
//                       // This is called when the user selects an item.
//                       setState(() {
//                         dropdownValuem1 = value!;
//                       });
//                     },
//                     items: list1.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
