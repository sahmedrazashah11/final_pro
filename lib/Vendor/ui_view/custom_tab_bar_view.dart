import 'package:flutter/material.dart';

class CustomTabBarView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final List<Widget> _tabs = [
    const FirstTab(),
    const SecondTab(),
  ];

  CustomTabBarView(
      {Key? key,
      this.titleTxt = "",
      this.subTxt = "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    DefaultTabController(
                      length: 3,
                      child: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.flight)),
                          Tab(icon: Icon(Icons.directions_transit)),
                          Tab(icon: Icon(Icons.directions_car)),
                        ],
                      ),
                    ),
                    TabBarView(
                      children: [
                        Icon(Icons.flight, size: 350),
                        Icon(Icons.directions_transit, size: 350),
                        Icon(Icons.directions_car, size: 350),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tab 1 Content'),
    );
  }
}

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tab 2 Content'),
    );
  }
}
