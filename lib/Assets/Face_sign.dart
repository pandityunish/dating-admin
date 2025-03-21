// import 'dart:io';
// import 'package:matrimony_admin/screens/data_collection/LetsStart.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

// class Facebook_sign extends StatelessWidget {
//   // final plugin = FacebookLogin(debug: true);

//   Facebook_sign({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3,
//       // child: MyHome(plugin: plugin),
//     );
//   }
// }

// class MyHome extends StatefulWidget {
//   // final FacebookLogin plugin;

//   // const MyHome({Key? key, required this.plugin}) : super(key: key);

//   @override
//   _MyHomeState createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   String? _sdkVersion;
//   FacebookAccessToken? _token;
//   FacebookUserProfile? _profile;
//   String? _email;
//   String? _imageUrl;

//   @override
//   void initState() {
//     super.initState();

//     _getSdkVersion();
//     _updateLoginInfo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLogin = _token != null && _profile != null;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Login via Facebook example'),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 2),
//         // padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               // if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
//               if (isLogin)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   // child: _buildUserInfo(context, _profile!, _token!, _email),
//                   child: _buildUserInfo(context, _profile!, _token!, _email),
//                 ),
//               Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Center(
//                     child: SignInButton(
//                       Buttons.FacebookNew,
//                       padding: EdgeInsets.all(5),
//                       onPressed: () {
//                         _onPressedLogInButton();
//                       },
//                     ),
//                   )
//                   // ElevatedButton(
//                   //   style: ElevatedButton.styleFrom(
//                   //       backgroundColor: Colors.white,
//                   //       textStyle: TextStyle(fontSize: 30),
//                   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
//                   //   ),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.start,
//                   //     children: [
//                   //       Container(
//                   //         height: 30.0,
//                   //         width: 30.0,
//                   //         decoration: BoxDecoration(
//                   //           image: DecorationImage(
//                   //               image:
//                   //               AssetImage('images/facebook.png'),
//                   //               fit: BoxFit.cover),
//                   //           shape: BoxShape.circle,
//                   //         ),
//                   //       ),
//                   //       SizedBox(
//                   //         width: 20,
//                   //       ),
//                   //       Text("Sign In with Facebook" , style: GoogleFonts.poppins(color: Colors.black))
//                   //     ],
//                   //   ),
//                   //
//                   //   // by onpressed we call the function signup function
//                   //   onPressed: () {
//                   //     _onPressedLogInButton();
//                   //   },
//                   // ),
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
//       FacebookAccessToken accessToken, String? email) {
//     final avatarUrl = _imageUrl;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (avatarUrl != null)
//           Center(
//             child: Image.network(avatarUrl),
//           ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Text('User: '),
//             Text(
//               '${profile.firstName} ${profile.lastName}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         // const Text('AccessToken: '),
//         // Text(
//         //   accessToken.token,
//         //   softWrap: true,
//         // ),
//         if (email != null) Text('Email: $email'),
//       ],
//     );
//   }

//   Future<void> _onPressedLogInButton() async {
//     await widget.plugin.logIn(permissions: [
//       FacebookPermission.publicProfile,
//       FacebookPermission.email,
//     ]);
//     await _updateLoginInfo();
//     final prefs = await SharedPreferences.getInstance();
//     bool loggedin = true;
//     await prefs.setBool('loggedin', loggedin);
//   }

//   Future<void> _onPressedExpressLogInButton(BuildContext context) async {
//     final res = await widget.plugin.expressLogin();
//     if (res.status == FacebookLoginStatus.success) {
//       await _updateLoginInfo();
//     } else {
//       await showDialog<Object>(
//         context: context,
//         builder: (context) => const AlertDialog(
//           content: Text("Can't make express log in. Try regular log in."),
//         ),
//       );
//     }
//   }

//   Future<void> _onPressedLogOutButton() async {
//     await widget.plugin.logOut();
//     await _updateLoginInfo();
//   }

//   Future<void> _getSdkVersion() async {
//     final sdkVersion = await widget.plugin.sdkVersion;
//     setState(() {
//       _sdkVersion = sdkVersion;
//     });
//   }

//   // Future<void> _updateLoginInfo() async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Future<void> _updateLoginInfo() async {
//     final plugin = widget.plugin;
//     final token = await plugin.accessToken;
//     FacebookUserProfile? profile;
//     String? email;
//     String? imageUrl;
//     if (token != null) {
//       profile = await plugin.getUserProfile();
//       if (token.permissions.contains(FacebookPermission.email.name)) {
//         email = await plugin.getUserEmail();
//       }
//       imageUrl = await plugin.getProfileImageUrl(width: 100);
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (builder) => LetsStart()));
//     }
//     // else{
//     //   var snackBar =
//     //   SnackBar(content: Text('Not able to signed in '));
//     //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     // }
//     // print(profile);
//     setState(() {
//       _token = token;
//       _profile = profile;
//       _email = email;
//       _imageUrl = imageUrl;
//     });
//   }
// }

// //Facebook Sign In

