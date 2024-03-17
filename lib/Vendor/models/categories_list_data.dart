import 'package:final_pro/Client/categories/fabrics/fabrics_screen.dart';
import 'package:final_pro/Client/categories/trims/trims_screen.dart';
import 'package:final_pro/Client/proposal/show_proposal.dart';
import 'package:final_pro/Vendor/order/vendor_order_show_screen.dart';
import 'package:final_pro/Vendor/proposal/vendor_proposal_screen.dart';

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
      imagePath: 'assets/introduction_animation/proposal.png',
      titleTxt: 'Proposal',
      kacl: 525,
      meals: <String>['Hoodie,', 'Polo Shirts,', 'Garments'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
      onTap: () {
        Get.to(const VendorProposalScreen());
      },
    ),
    MealsListData(
      imagePath: 'assets/vendors_icons/yarn.png',
      titleTxt: 'Order',
      kacl: 602,
      meals: <String>['Spun Yarns,', 'Filament Yarns,', 'Core-Spun'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
      onTap: () {
        Get.to(const VendorOrderShowScreen());
      },
    ),
  ];
}
