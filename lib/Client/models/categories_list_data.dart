import 'package:final_pro/Client/categories/fabrics/fabrics_screen.dart';
import 'package:final_pro/Client/categories/trims/trims_screen.dart';

import 'package:get/get.dart';

import '../categories/Yarn/yarn_screen.dart';
import '../categories/apparel/apparel_screen.dart';

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
    required this.onTap,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;
  final Function onTap;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/introduction_animation/mood_dairy_image.png',
      titleTxt: 'Apparels',
      kacl: 525,
      meals: <String>['Shirts,', 'Polo Shirts,', 'Garments'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
      onTap: () {
        Get.to(const ApparelScreen());
      },
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/yarn.png',
      titleTxt: 'Yarn',
      kacl: 602,
      meals: <String>['Spun Yarns,', 'Filament Yarns,', 'Core-Spun'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
      onTap: () {
        Get.to(const YarnScreen());
      },
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/yarn.png',
      titleTxt: 'Fabrics',
      kacl: 200,
      meals: <String>['Cotton,', 'Chiffon,', 'Chenille', 'etc'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
      onTap: () {
        Get.to(const FabricsScreen());
      },
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/trims.png',
      titleTxt: 'Trims',
      kacl: 10,
      meals: <String>['Visible Trimmings,', 'invisible trimmings'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
      onTap: () {
        Get.to(const TrimsScreen());
      },
    ),
  ];
}
