import 'package:flutter/material.dart';
import 'package:final_pro/screens/Client%20Screen/client_Signup.dart';
import 'package:final_pro/screens/Venders%20Screen/venders_Signup.dart';
import 'package:final_pro/screens/signup_screen.dart';
import 'package:get/get.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  late final String userRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 70),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 21, 220, 184),
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/images/welcome_image1.png",
              width: 220,
              height: 240,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 35, right: 35, top: 20),
              child: Text(
                "The only ecommerce platform you’ll ever need.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),

            // Vendor Container
            const SizedBox(
              height: 60,
            ),
            Container(
              //width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              // height: MediaQuery.of(context).size.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  // Client Select
                  GestureDetector(
                    onTap: () {
                      Get.to(const ClientSignUp());
                    },
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(
                            0xff132137), // Change this to your desired background color
                        borderRadius: BorderRadius.circular(
                            10.0), // Optional: Add rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(
                                0, 3), // Offset in the x and y directions
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/Client.png",
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Client",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Vendors Select
                  GestureDetector(
                    onTap: () {
                      Get.to(const VenderSignUp());
                    },
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(
                            0xff132137), // Change this to your desired background color
                        borderRadius: BorderRadius.circular(
                            10.0), // Optional: Add rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(
                                0, 3), // Offset in the x and y directions
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/store.png",
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Venders",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
