import 'package:flutter/material.dart';
import 'package:final_pro/Vendor/order/vendor_order_show_screen.dart';

class ShowOrder extends StatefulWidget {
  const ShowOrder({super.key});

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              VendorOrderShowScreen(),
            ],
          ),
        ));
  }
}
