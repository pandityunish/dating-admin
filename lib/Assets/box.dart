import 'package:flutter/material.dart';

import '../globalVars.dart';

class Box extends StatelessWidget {
  const Box({
    super.key,
    this.width,
    // ignore: non_constant_identifier_names
    required this.box_text,
    required this.icon,
  });
  // ignore: prefer_typing_uninitialized_variables
  final width;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  final box_text;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: box_text,
        style: TextStyle(fontSize: 12),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    final textWidth = textPainter.maxIntrinsicWidth;

    return Container(
      margin: const EdgeInsets.only(bottom: 2, right: 2),
      height: MediaQuery.of(context).size.height * 0.0205,
      // width: (width == null) ? box_text.length * 8 + 32.0 : width,
      width: textWidth + 32 + textWidth * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.0),
        border: Border.all(color: main_color, width: 0.5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          ImageIcon(
            AssetImage(icon),
            size: 16,
            color: main_color,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            box_text,
            // textScaleFactor: 1.0,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: main_color,
            ),
          )
        ],
      ),
    );
  }
}
