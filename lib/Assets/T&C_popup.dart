import 'package:matrimony_admin/globalVars.dart';
import 'package:flutter/material.dart';

import '../screens/SignIn.dart';

bool color_done2 = false;

class TCPopup extends StatefulWidget {
  const TCPopup({super.key});

  @override
  State<TCPopup> createState() => _TCPopupState();
}

class _TCPopupState extends State<TCPopup> {
  String termcondition =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sed magna hendrerit, tristique nibh id, lobortis elit. In hac habitasse platea dictumst. Nulla facilisi. Sed eget erat turpis. Vestibulum pulvinar facilisis purus et sagittis. Etiam tincidunt placerat vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sapien dolor, sagittis luctus sapien in, eleifend pharetra augue. Nam malesuada dolor ut dolor sagittis efficitur. Etiam dignissim eros ut mi laoreet, quis luctus quam cursus. Curabitur blandit lectus nec justo mollis commodo. Mauris ac ultricies nisi, porttitor faucibus mauris. Fusce lectus justo, vulputate sed posuere ac, consequat in elit. Aliquam eget nulla turpis. Integer ut lacus at lorem porta tincidunt sit amet a nisi. Sed augue risus, interdum et fringilla non, posuere vel libero.Proin euismod velit eu lectus faucibus facilisis. Phasellus nunc neque, viverra eget tincidunt eu, lobortis luctus dui. Donec cursus dui a nulla faucibus bibendum nec vitae turpis. Proin ut nulla non risus ornare finibus eu et tellus. Vestibulum eget commodo neque. Sed eu leo condimentum, sodales eros ultricies, tempor quam. Nullam facilisis sem id suscipit fermentum.Morbi convallis purus nulla, id mollis diam accumsan posuere. Integer vel dui velit. Praesent venenatis congue nisl ut lobortis. Donec tempor ex eget sem efficitur molestie. Sed hendrerit felis tellus, sit amet rhoncus enim facilisis eget. Vivamus nunc enim, pellentesque eget scelerisque et, molestie ac mauris. Nunc eleifend efficitur volutpat. Vestibulum sed leo euismod, fermentum nunc a, ornare tortor. Etiam sollicitudin eu metus sed viverra. Vivamus aliquam finibus nisi, eget iaculis eros. Ut blandit neque et massa sagittis, sed consectetur lectus viverra. Nulla sit amet elementum nibh. In commodo, ante et commodo mollis, dui elit mattis dolor, vitae rhoncus nibh turpis vitae odio. Quisque ac felis lobortis, varius nisl ut, maximus lacus. Nunc scelerisque sapien sapien. Maecenas gravida, est rhoncus dictum finibus, ante ante mattis mauris, quis lobortis nisi quam id velit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam elementum est lectus, a interdum ex viverra et. Donec porta consequat magna consequat tincidunt. Aliquam mattis rutrum felis, eget suscipit metus molestie id. Aliquam mauris nisl, auctor ac dui sed, posuere consectetur justo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nibh dolor, pellentesque eu orci vel, pharetra egestas eros. Aenean in justo volutpat, gravida felis vulputate, maximus velit.";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Terms & Conditions',
        style: TextStyle(color: main_color),
      ),
      content: Scrollbar(
        //always show scrollbar
        thickness: 4, //width of scrollbar
        radius: Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(termcondition),
              // CustomSpecialButtom(
              //     shadowColor:
              //         MaterialStateColor.resolveWith((states) => Colors.black),
              //     // shadowcolor: Colors.red,
              //     text: "Agree",
              //     bordercolor: Colors.black,
              //     button_pressed: () {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (builder) => SignInScreen()));
              //     })
              Container(
                margin: EdgeInsets.only(left: 6),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            EdgeInsets.symmetric(vertical: 17)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    side: BorderSide(
                                      color: (color_done2 == false)
                                          ? Colors.white
                                          : main_color,
                                    ))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {
                      setState(() {
                        color_done2 = true;
                      });

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => SignInScreen()));
                    },
                    child: Text(
                      "Agree",
                      style: (color_done2 == false)
                          ? TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w700)
                          : TextStyle(
                              color: main_color,
                              fontSize: 20,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w700),
                    )),
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(color: main_color),
          ),
        ),
      ],
    );
  }
}
