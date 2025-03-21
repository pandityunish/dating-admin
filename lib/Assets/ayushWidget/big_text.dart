import 'package:flutter/cupertino.dart';

//step 1 : stateless widget dala
class BigText extends StatelessWidget {
  Color? color; //?--it is so that color is optional
  final String text;
  double? size;
  TextOverflow overflow;
  var fontWeight;

  BigText(
      {Key? key,
      this.color = const Color(0xFF2C3333),
      required this.text,
      this.size = 20,
      this.fontWeight = FontWeight.w400,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Sans-serif',
          color: color,
          fontWeight: fontWeight,
          fontSize: size),
    );
  }
}
