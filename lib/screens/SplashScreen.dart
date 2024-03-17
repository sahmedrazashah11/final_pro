import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../introduction_animation/introduction_animation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate to the next screen
        // Use Navigator.pushReplacement to avoid coming back to the splash screen
        Get.to(const IntroductionAnimationScreen()); // Replace with your route
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 21, 220, 184),
        child: Center(
          child: FadeTransition(
            opacity: _animationController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/svWhite_logo.png',
                  width: 250,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/loading.gif',
                  width: 100,
                  height: 100,
                ),
                // Text(
                //   'Your App Name',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
