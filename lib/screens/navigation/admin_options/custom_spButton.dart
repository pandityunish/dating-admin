import 'package:flutter/material.dart';
import 'package:matrimony_admin/globalVars.dart';

class CustomSpecialButtom extends StatefulWidget {
  final String text;
  final Color bordercolor;
  final VoidCallback? onTap;
  const CustomSpecialButtom(
      {super.key, required this.text, required this.bordercolor, this.onTap});

  @override
  State<CustomSpecialButtom> createState() => _CustomSpecialButtomState();
}

class _CustomSpecialButtomState extends State<CustomSpecialButtom> {
  Color borderColor = Colors.white;
  
  void _animateBorder() {
    setState(() {
      borderColor = main_color;
    });
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          borderColor = Colors.white;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _animateBorder();
          widget.onTap!();
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.height * 0.84,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: borderColor,
                  width: 1.5,
                )),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
    ));
  }
}
