import 'package:flutter/material.dart';

class CustomSpecialButtom extends StatelessWidget {
  final String text;
  final Color bordercolor;
  var shadowColor;
  final button_pressed;
  CustomSpecialButtom(
      {super.key,
      required this.text,
      this.shadowColor,
      required this.bordercolor,
      required this.button_pressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: button_pressed,
      
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              // border: Border.all(
              //   color: bordercolor,
              // )
              ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black,  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
