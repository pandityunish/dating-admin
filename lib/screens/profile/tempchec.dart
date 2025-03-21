// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ParentWidget extends StatefulWidget {
//   @override
//   _ParentWidgetState createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {
//   bool _isChecked = false;

//   void _onCheckboxChanged(bool newValue) {
//     setState(() {
//       _isChecked = newValue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Parent Widget'),
//         Checkbox(
//           value: _isChecked,
//           onChanged: _onCheckboxChanged,
//         ),
//         ChildWidget(isChecked: _isChecked),
//       ],
//     );
//   }
// }

// class ChildWidget extends StatefulWidget {
//   final bool isChecked;

//   ChildWidget({this.isChecked});

//   @override
//   _ChildWidgetState createState() => _ChildWidgetState();
// }

// class _ChildWidgetState extends State<ChildWidget> {
//   bool _isTextVisible = false;

//   void _toggleTextVisibility() {
//     setState(() {
//       _isTextVisible = !_isTextVisible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         RaisedButton(
//           child: Text('Toggle Text'),
//           onPressed: _toggleTextVisibility,
//         ),
//         Visibility(
//           visible: _isTextVisible,
//           child: Text(
//             widget.isChecked
//                 ? 'Checkbox is checked'
//                 : 'Checkbox is not checked',
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ),
//       ],
//     );
//   }
// }
