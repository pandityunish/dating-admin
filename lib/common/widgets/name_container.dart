import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/Search_profile/search_dynamic_pages.dart';

class NameContainer extends StatefulWidget {
  final String icon;
  final String head;
  final List<String> val;
  final List<String> options;
  final Color? textColor;
  final double? iconSize;
  final double? fontSize;
  final double? arrowSize;
  final double? containerWidth;
  final bool reverse;

  const NameContainer({
    Key? key,
    required this.icon,
    required this.head,
    required this.val,
    required this.options,
    this.textColor,
    this.iconSize = 25,
    this.fontSize = 18,
    this.arrowSize = 20,
    this.containerWidth = 80,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<NameContainer> createState() => _NameContainerState();
}

class _NameContainerState extends State<NameContainer> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = widget.textColor ?? newtextColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(widget.icon),
                size: widget.iconSize,
                color: main_color,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.head,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    
                    color: Colors.black,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Sans-serif',
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var ds = await Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => DynamicPage(
                    icon: widget.icon,
                    head: widget.head,
                    options: widget.options,
                    selectedopt: widget.val)));

            if (ds != null) {
              setState(() {
                widget.val.clear();
              });
              for (var i = 0; i < ds.length; i++) {
                setState(() {
                  widget.val.add(ds[i]);
                });
              }
            }
          },
          child: Row(
            mainAxisAlignment: widget.reverse ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              (widget.val.isEmpty)
                ? Text(
                    "Add",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sans-serif',
                    ),
                  )
                : SizedBox(
                    width: widget.containerWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: widget.reverse,
                      child: Row(
                        mainAxisAlignment: widget.reverse ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.val
                                .toString()
                                .substring(1, widget.val.toString().length - 1),
                            style: GoogleFonts.poppins(
                              decoration: TextDecoration.none,
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textColor,
                size: widget.arrowSize,
              )
            ],
          ),
        )
      ],
    );
  }
}
