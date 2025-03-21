// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../globalVars.dart';

// class MainButton extends StatelessWidget {
//   final String text;
//   final Function onpressed;

//   const MainButton({
//     super.key,
//     required this.text,
//     required this.onpressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: ElevatedButton(
//           style: ButtonStyle(
//               shadowColor:
//                   MaterialStateColor.resolveWith((states) => Colors.black),
//               padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
//                   EdgeInsets.symmetric(vertical: 20)),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(60.0),
//                       side: BorderSide(
//                         color:
//                             (color_done == false) ? Colors.white : main_color,
//                       ))),
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
//           onPressed: () {
//             onpressed;
//           },
//           child: Text(
//             text,
//             style: (color_done == false)
//                 ? TextStyle(color: Colors.black)
//                 : TextStyle(color: main_color),
//           )),
//     );
//   }
// }
