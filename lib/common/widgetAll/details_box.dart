import 'package:matrimony_admin/common/global.dart';
import 'package:flutter/material.dart';

class DetailsBox extends StatelessWidget {
  final String name;
  final IconData iconData;
  const DetailsBox({super.key, required this.name, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 108,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primarycolor, width: 1)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: primarycolor,
              ),
              Text(
                name,
                style: const TextStyle(color: primarycolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
