import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_string/json_string.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_admin/models/admin_model.dart';

import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';

import '../../../../Assets/ayushWidget/big_text.dart';

class NumbericalScreen extends StatefulWidget {
  final AdminModel? admin;
  const NumbericalScreen({super.key, this.admin});

  @override
  State<NumbericalScreen> createState() => _NumbericalScreenState();
}

class _NumbericalScreenState extends State<NumbericalScreen> {
  bool isLoading = false;
  getUserDetails() async {
    try {
      http.Response res = await http.get(
        Uri.parse(finadminuserurl)
            .replace(queryParameters: {'email': widget.admin?.email ?? ""}),
        headers: {
          'Content-Type': 'Application/json',
        },
      );
      // print(jsonDecode(res.body));
      final json = JsonString(res.body.toString());
      print(json);
      // generateValues(json.decodedValueAsList);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Material(
        child: CupertinoPageScaffold(
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
                  text: "${widget.admin!.username} Numerical Chart",
                  size: 16,
                  color: main_color,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            trailing:  Icon(Icons.calendar_month,color: main_color,),
            previousPageTitle: "",
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: numericalData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            
                
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 5),
                               child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: Get.width * 0.9,
                                    child: Text(
                                      " ${numericalData[index]["name"]}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                             ),
                            
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
