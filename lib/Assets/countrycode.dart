import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          height: 20,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                decoration: const InputDecoration(
                  //decoration for Input Field
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN', //default contry code, NP for Nepal
              ),
            ],
          )),
    );
  }
}
