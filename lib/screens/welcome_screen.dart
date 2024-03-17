import 'package:flutter/material.dart';
import 'package:final_pro/screens/select_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  alignment: Alignment.topRight,
                  width: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/welcome_image1.png",
                  width: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Find Your",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Dream Product",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 93, 242)),
                ),
                const Text(
                  "Here!",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Explore all the most exciting products based on your interest.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(const SelectScreen());
              },
              child: Container(
                //alignment: Alignment.topLeft,
                // decoration: BorderRadius.circular(4),
                width: 50,
                height: 50,

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color.fromARGB(255, 48, 93, 242),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
