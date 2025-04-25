import 'package:flutter/material.dart';
import 'package:matrimony_admin/globalVars.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
final String iconImage;
final double? height;
  const CustomAppBar({
    Key? key,
    required this.title,
this.height=75,
    this.onBackButtonPressed, required this.iconImage,
  }) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(height??110); // Customize height here

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
  preferredSize: const Size.fromHeight(10), // Adjust AppBar height
  child: AppBar(
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        color: main_color,
        size: 25,
      ),
    ), 
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 20), // Adjust padding for alignment
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
               AssetImage(iconImage),
              size: 30,
              color: main_color,
            ),
            const SizedBox(
              height: 8,
            ),
             DefaultTextStyle(
              style: TextStyle(
                color: main_color,
                fontFamily: 'Sans-serif',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              child: Text(title),
            ),
          ],
        ),
      ),
    ),
  ),
);
  }
}
