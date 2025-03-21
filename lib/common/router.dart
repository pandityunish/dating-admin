// import 'package:datingapp/common/bottom_navigation.dart';
// import 'package:datingapp/common/splash_screen.dart';
// import 'package:datingapp/features/home/screen/home_screen.dart';
// import 'package:datingapp/features/login/screens/about_screen.dart';
// import 'package:datingapp/features/login/screens/community.dart';
// import 'package:datingapp/features/login/screens/congrulation_screen.dart';
// import 'package:datingapp/features/login/screens/details_page.dart';
// import 'package:datingapp/features/login/screens/diet_screen.dart';
// import 'package:datingapp/features/login/screens/drinks_screen.dart';
// import 'package:datingapp/features/login/screens/education_screen.dart';
// import 'package:datingapp/features/login/screens/height_screen.dart';
// import 'package:datingapp/features/login/screens/income_screen.dart';
// import 'package:datingapp/features/login/screens/profession_screen.dart';
// import 'package:datingapp/features/login/screens/religion_screen.dart';
// import 'package:datingapp/features/login/screens/smoke_screen.dart';
// import 'package:datingapp/features/login/screens/social_login.dart';
// import 'package:datingapp/features/login/screens/upload_images.dart';
// import 'package:flutter/material.dart';

// import '../features/login/screens/marital_status.dart';

// Route<dynamic> generateroute(RouteSettings routeSettings){
//   switch(routeSettings.name){
//     case CommunityScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const CommunityScreen(),);
//     case SocialLogin.routeName:
//     return MaterialPageRoute(builder: (context) =>const SocialLogin(),);
//      case DetailsPage.routeName:
//     return MaterialPageRoute(builder: (context) =>const DetailsPage(),);
//      case ReligionScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const ReligionScreen(),);
//      case MaterialStatus.routeName:
//     return MaterialPageRoute(builder: (context) =>const MaterialStatus(),);
//     case DietScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const DietScreen(),);
//     case DrinksScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const DrinksScreen(),);
//      case SomkeScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const SomkeScreen(),);
//     case HeightScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const HeightScreen(),);
//       case Educationcreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const Educationcreen(),);
//     case ProfessionScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const ProfessionScreen(),);
//     case IncomeScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const IncomeScreen(),);
//     case AboutScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const AboutScreen(),);
//      case UploadImages.routeName:
//     return MaterialPageRoute(builder: (context) =>const UploadImages(),);
//     case CongrulationScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const CongrulationScreen(),);
//      case Homepage.routeName:
//     return MaterialPageRoute(builder: (context) =>const Homepage(),);
//      case SplashScreen.routeName:
//     return MaterialPageRoute(builder: (context) =>const SplashScreen(),);
//     case CustomBottomNavigation.routeName:
//     return MaterialPageRoute(builder: (context) =>const CustomBottomNavigation(),);
    
//     default:
//     return MaterialPageRoute(builder: (context) =>const Scaffold(
//       body: Center(
//         child: Text("NO Screen Found"),
//       ),
//     ),);
//   }
// }