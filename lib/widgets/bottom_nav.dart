import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            'Selected Tab: $selectedIndex',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        bottomNavigationBar: MoltenBottomNavigationBar(
          selectedIndex: selectedIndex,
          domeHeight: 25,
          onTabChange: (clickedIndex) {
            setState(() {
              selectedIndex = clickedIndex;
            });
          },
          tabs: [
            MoltenTab(
              icon: const Icon(Icons.search),
            ),
            MoltenTab(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            MoltenTab(
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
