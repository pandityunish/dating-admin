import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../globalVars.dart';

class CircularBubles extends StatelessWidget {
  final String url;
  const CircularBubles({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: main_color, width: 3),
          image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              fit: BoxFit.cover)),
    );
  }
}
