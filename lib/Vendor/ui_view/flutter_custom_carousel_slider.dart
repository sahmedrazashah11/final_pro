import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

class CorauselCustom extends StatefulWidget {
  const CorauselCustom({super.key});

  @override
  State<CorauselCustom> createState() => _CorauselCustomState();
}

class _CorauselCustomState extends State<CorauselCustom> {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://miro.medium.com/max/1400/1*RpaR1pTpRa0PUdNdfv4njA.png',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
          'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://pbs.twimg.com/profile_banners/1444928438331224069/1633448972/600x200',
      ),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                CustomCarouselSlider(
                  items: itemList,
                  height: 150,
                  subHeight: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  autoplay: true,
                  showSubBackground: false,
                  //showIndicator: false,
                  showText: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
