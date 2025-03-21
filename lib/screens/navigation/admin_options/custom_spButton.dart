import 'package:flutter/material.dart';

class CustomSpecialButtom extends StatelessWidget {
  final String text;
  final Color bordercolor;
  const CustomSpecialButtom(
      {super.key, required this.text, required this.bordercolor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white,
              )),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
