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
    this.height = 110,
    this.onBackButtonPressed,
    required this.iconImage,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? 110);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Disable default back button
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          height: preferredSize.height,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              IconButton(
                onPressed:
                    onBackButtonPressed ?? () => Navigator.of(context).pop(),
                icon:
                    Icon(Icons.arrow_back_ios_new, color: main_color, size: 25),
              ),

              // Expanded Center Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage(iconImage),
                      size: 30,
                      color: main_color,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: TextStyle(
                        color: main_color,
                        fontFamily: 'Sans-serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Placeholder to balance the back button space on the right
              SizedBox(
                  width: 48), // Same width as IconButton to keep it centered
            ],
          ),
        ),
      ),
    );
  }
}
