import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
 
  final String text;
final Color bordercolor;
  const ItemCard({super.key, required this.text, required this.bordercolor, });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 1,
            color: widget.bordercolor
          )
        ),
        child:Center(
          child: Text(widget.text,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ) ,
      ),
    );
  }
}