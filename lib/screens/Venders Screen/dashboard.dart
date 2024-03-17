import 'package:flutter/material.dart';

import '../../widgets/flutter_custom_carousel_slider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 64, 215),
        title: Image.asset('assets/images/logo.png'),
        actions: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://hips.hearstapps.com/hmg-prod/images/gettyimages-693134468.jpg?crop=1xw:1.0xh;center,top&resize=1200:*'),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Create Store'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Settings'),
              )
            ],
            onSelected: (int menu) {
              if (menu == 1) {
                //Get.to(CreateStore());
              } else {}
            },
          )
        ],
      ),
      body: Container(
        child: const Column(
          children: [
            Text(
              "Hey, SM Shah",
              style: TextStyle(
                color: Color.fromARGB(206, 79, 79, 78),
                fontFamily: AutofillHints.familyName,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            // CardSliderWidget(),
            CorauselCustom(),
           
          ],
        ),
      ),
    );
  }
}
