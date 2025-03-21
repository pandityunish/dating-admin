import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/screens/navigation/admin_options/Charts/nextchart_screen.dart';
import '../../../../Assets/ayushWidget/big_text.dart';
import '../../../../models/admin_model.dart';
import '../../../profie_types/create_admin_service.dart';

class AllAdmins extends StatefulWidget {
  const AllAdmins({super.key});

  @override
  _ReligionState createState() => _ReligionState();
}

class _ReligionState extends State<AllAdmins> {
  int value = 0;
  List<AdminModel> alladmins = [];
  void getalladmins() async {
    alladmins = await CreateAdminService().getalladmins();
    setState(() {});
  }

  @override
  void initState() {
    getalladmins();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
        Get.to(NextchartScreen(
          admin: alladmins[value],
          title: "$text Admin",
        ));
      },
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
              const EdgeInsets.symmetric(vertical: 15)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                      color: (value == index) ? main_color : Colors.white))),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? main_color : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
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
          middle: Row(
            children: [
              BigText(
                text: "Admins",
                size: 20,
                color: main_color,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
          previousPageTitle: "",
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              alladmins.isEmpty
                  ? SizedBox(
                      height: Get.height * 0.6,
                      width: Get.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: main_color,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          itemCount: alladmins.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: CustomRadioButton(
                                      alladmins[index].username, index)),
                            );
                          },
                        ),
                      ],
                    )
            ],
          ),
        ));
  }
}
