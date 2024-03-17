import 'dart:async';

import 'package:flutter/material.dart';

class CardSliderWidget extends StatefulWidget {
  const CardSliderWidget({super.key});

  @override
  State<CardSliderWidget> createState() => _CardSliderWidgetState();
}

class _CardSliderWidgetState extends State<CardSliderWidget>
    with TickerProviderStateMixin {
  int secondecurrentindex = 2;
  PageController mysecondcontroller =
      PageController(initialPage: 3, viewportFraction: 0.7);
  mysecondfunction() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      secondecurrentindex++;
      mysecondcontroller.animateToPage(secondecurrentindex,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              physics:
                  const BouncingScrollPhysics(), //for not scrollable NeverScrollableScrollPhysics()
              controller: mysecondcontroller,
              onPageChanged: (value) {
                secondecurrentindex = value;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                      width: 200,
                      assets[index % assets.length],
                      fit: BoxFit.fill),
                );
              },
            ),
          ),
          TabPageSelector(
            controller: TabController(
                length: assets.length,
                vsync: this,
                initialIndex: secondecurrentindex % assets.length),
          ),
        ],
      ),
    );
  }
}

List<String> assets = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.png',
  'assets/images/banner1.jpg',
  // 'assets/images/facebook_logo',
  // 'assets/images/facebook_logo',
  // 'assets/images/facebook_logo',
];
final colors = [
  Colors.red.shade100,
  Colors.green.shade100,
  Colors.greenAccent.shade100,
  Colors.amberAccent.shade100,
  Colors.blue.shade100,
  const Color.fromARGB(255, 223, 169, 9),
];
