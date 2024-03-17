import 'package:flutter/material.dart';
import 'package:final_pro/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingIconDropdown extends StatefulWidget {
  @override
  _SettingIconDropdownState createState() => _SettingIconDropdownState();
}

class _SettingIconDropdownState extends State<SettingIconDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Set up the fade-in animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: PopupMenuButton<String>(
        onSelected: (value) {
          // Handle menu item selection
          if (value == 'Profile') {
            // Navigate to profile screen or perform profile-related action
          } else if (value == 'Logout') {
            // Perform logout action
            _logout(context);
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: 'settings',
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  title: Text('Settings'),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Logout',
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  title: Text('Logout'),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Setting Icon Dropdown Widget Example'),
          actions: [
            Spacer(),
            SettingIconDropdown(),
          ],
        ),
        body: Center(
          child: Text('Your content goes here'),
        ),
      ),
    );
  }
}

// Function to handle logout
void _logout(BuildContext context) {
  // Add your logout logic here, such as clearing user session
  // For example, you might use a state management solution to manage the user's authentication state
  // After logging out, navigate to the login screen
  Get.to(LoginScreen());
}
