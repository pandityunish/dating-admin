import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String image;
  final String name;
  const SocialButton({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        // width: MediaQuery.of(context).size.width * 0.8,
        width: 320,
        height: 65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color.fromARGB(255, 226, 226, 226))),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
