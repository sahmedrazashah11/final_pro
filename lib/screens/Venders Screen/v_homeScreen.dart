import 'package:flutter/material.dart';
import 'package:final_pro/screens/Venders%20Screen/dashboard.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeVender extends StatefulWidget {
  const HomeVender({super.key});

  @override
  State<HomeVender> createState() => _HomeVenderState();
}

User? getCurrentUser() {
  final userProfile = FirebaseAuth.instance.currentUser;
  return userProfile;
}

class _HomeVenderState extends State<HomeVender> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    User? userProfile = getCurrentUser();
    if (userProfile != null) {
      print('User UID: ${userProfile.uid}');
      print('User Email: ${userProfile.email}');
      print('User Display Name: ${userProfile.phoneNumber}');
    }
    int selectedIndex = 0;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          Dashboard(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 18, 64, 215),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          child: GNav(
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(108, 119, 142, 216),
            gap: 8,
            padding: const EdgeInsets.all(14),
            duration: const Duration(milliseconds: 300),
            onTabChange: _changePage,
            tabs: const [
              GButton(
                icon: Icons.dashboard_customize_rounded,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.add_box_outlined,
                text: 'Order',
              ),
              GButton(
                icon: Icons.production_quantity_limits_rounded,
                text: 'Product',
              ),
              GButton(
                icon: Icons.supervised_user_circle_rounded,
                text: 'Customer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
