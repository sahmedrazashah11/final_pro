import 'package:flutter/material.dart';
import 'package:custom_sidemenu/custom_sidemenu.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});
  List<CustomMenuItem> menuItemsList = [
    CustomMenuItem(
      callback: () {
        //Callback function to route to page on Click
      },
      title: 'Home',
      leadingIcon: Icons.home,
      iconSize: 22,
      titleSize: 16,
    ),
    CustomMenuItem(
      callback: () {
        //Callback function to route to page on Click
      },
      title: 'History',
      leadingIcon: Icons.history,
      iconSize: 22,
      titleSize: 16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomDrawer(
      homeWidget: const Center(
        child: Text('Your Home Widget'),
      ),
      menuItemsList: menuItemsList,
      appBarActions: const [],
      appBarTitle: const Text('Your Home Widget'),
      menuIcon: const Icon(Icons.menu),
    ));
  }
}
