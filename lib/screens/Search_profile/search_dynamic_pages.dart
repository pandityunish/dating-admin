import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drink.dart';

String? DrinkStatus;

class DynamicPage extends StatefulWidget {
  DynamicPage(
      {super.key,
      required this.icon,
      required this.head,
      required this.options,
      required this.selectedopt});
  var icon;
  String head;
  List<String> options;
  List<dynamic> selectedopt;
  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  List<int> valueList = [];
  @override
  void initState() {
    super.initState();
    if (widget.selectedopt.isNotEmpty) {
      for (var i = 0; i < widget.selectedopt.length; i++) {
        valueList.add(widget.options
            .indexWhere((element) => widget.selectedopt[i] == element));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      appBar: PreferredSize(
         preferredSize: const Size.fromHeight(120),
        child: AppBar(
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(100.0), // Set the height here
          //   child: ,
          // ),
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              List<String> ds = [];
              for (var i = 0; i < valueList.length; i++) {
                if (valueList[i] != 0) {
                  ds.add(widget.options[valueList[i]]);
                }
              }
              Navigator.of(context).pop(ds);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: main_color,
            ),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              // Icon(
              //   widget.icon,
              //   color: main_color,
              // ),
              ImageIcon(
                AssetImage(widget.icon),
                size: 25,
                color: main_color,
              ),
              // SizedBox(
              //   width: 4,
              // ),
              Text(
                widget.head,
                style: TextStyle(
                    color: main_color,
                    fontFamily: 'Sans-serif',
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              )
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async{
           List<String> ds = [];
            for (var i = 0; i < valueList.length; i++) {
              if (valueList[i] != 0) {
                ds.add(widget.options[valueList[i]]);
              }
            }
            
            Navigator.of(context).pop(ds);

return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  children: [
                    Drink(value: valueList, option: widget.options),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
