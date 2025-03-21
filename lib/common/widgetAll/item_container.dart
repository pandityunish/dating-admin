import 'package:matrimony_admin/common/global.dart';
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final IconData iconData;
  final String text;
  const ItemContainer({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: primarycolor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
