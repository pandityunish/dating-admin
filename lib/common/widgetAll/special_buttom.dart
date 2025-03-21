import 'package:flutter/material.dart';

class SpecialButtom extends StatelessWidget {
  final String text;
  const SpecialButtom({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black,width: 2)
                        ),
                        child: Center(
                          child: Text(text,style: TextStyle(color: Colors.black),),
                        ),
                      );
  }
}