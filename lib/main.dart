import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:final_pro/Vendor/Vendor_home_screen.dart';
import 'package:final_pro/route.dart';
import 'package:final_pro/screens/Client%20Screen/client_Signup.dart';
import 'package:final_pro/screens/Client%20Screen/client_login_screen.dart';
import 'package:final_pro/screens/SplashScreen.dart';
import 'package:final_pro/screens/Venders%20Screen/v_homeScreen.dart';
import 'package:final_pro/screens/Venders%20Screen/venders_Signup.dart';
import 'package:final_pro/screens/home_screen.dart';
import 'package:final_pro/screens/login_screen.dart';
import 'package:final_pro/screens/select_screen.dart';
import 'package:final_pro/screens/signup_screen.dart';
import 'package:final_pro/screens/welcome_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'Client/Client_home_screen.dart';
import 'introduction_animation/introduction_animation_screen.dart';

Future<void> main() async {
  debugPaintSizeEnabled = true; // Visualize widget sizes
  debugRepaintRainbowEnabled = true; // Visualize widget repaints
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        MainRoutes.HomeScreen: (context) => const HomeScreen(),
        MainRoutes.LoginScreen: (context) => const LoginScreen(),
        MainRoutes.SignUpScreen: (context) => const SignUpScreen(),
        MainRoutes.SplashScreen: (context) => const SplashScreen(),
        MainRoutes.WelcomeScreen: (context) => const WelcomeScreen(),
        MainRoutes.SelectScreen: (context) => const SelectScreen(),

        // Opening App Screens
        MainRoutes.IntroductionAnimationScreen: (context) =>
            const IntroductionAnimationScreen(),

        //Clients Routes
        //new
        MainRoutes.ClientHomeScreen: (context) => const ClientHomeScreen(),
        MainRoutes.Client_signUp: (context) => const ClientSignUp(),
        MainRoutes.Client_login: (context) => const ClientLogin(),

        // Venders Routes
        MainRoutes.VendorHomeScreen: (context) => const VendorHomeScreen(),
        MainRoutes.vender_Signup: (context) => const VenderSignUp(),
        MainRoutes.v_homeScreen: (context) => const HomeVender(),
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 2) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
