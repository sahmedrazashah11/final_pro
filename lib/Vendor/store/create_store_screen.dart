import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'form_store/form_company_overview.dart';
import 'form_store/form_product_basic _info.dart';
import 'form_store/form_product_description.dart';
import 'form_store/form_product_specification.dart';
import 'form_store/form_production_capacity.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Store'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildExpansionTile(
              'Product Information',
              _buildSubheadings(
                context,
                [
                  'Product Basic Info',
                ],
              ),
            ),
            _buildVerticalDivider(),
            _buildExpansionTile(
              'Product Details',
              _buildSubheadings(
                context,
                [
                  // Add subheadings for Product Details here
                  "Product Description",
                  "Product Specification",
                  "Packaging & Delivery",
                  "FAQ",
                ],
              ),
            ),
            _buildVerticalDivider(),
            _buildExpansionTile(
              'Company Profile',
              _buildSubheadings(
                context,
                [
                  // Add subheadings for Company Profile here
                  "Company OverView",
                  "Production Capacity",
                  "Factory Inspection Report",
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, List<Widget> children) {
    return Theme(
      data: ThemeData(hintColor: Colors.blue),
      child: ListTileTheme(
        dense: true,
        iconColor: Colors.blue,
        textColor: Colors.blue,
        child: ExpansionTile(
          title: Row(
            children: [
              const Icon(
                Icons.circle, // Circle icon
                size: 16,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: children,
        ),
      ),
    );
  }

  List<Widget> _buildSubheadings(
      BuildContext context, List<String> subheadings) {
    return subheadings.map((title) => _buildListTile(context, title)).toList();
  }

  Widget _buildListTile(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        _showToast(context, title);
      },
      child: ListTile(
        title: Row(
          children: [
            const Icon(
              Icons.circle_outlined, // Dot icon
              size: 12,
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return const Divider(
      color: Colors.blue,
      thickness: 2,
      height: 10,
    );
  }

  void _showToast(BuildContext context, String title) {
    if (title == 'Product Basic Info') {
      Get.to(const FormProductBasicInfo());
    } else if (title == 'Product Description') {
      Get.to(const FormProductDescription());
    } else if (title == 'Product Specification') {
      Get.to(const FormProductSpecification());
    } else if (title == 'Company OverView') {
      Get.to(const FormCompanyOverview());
    } else if (title == 'Production Capacity') {
      Get.to(const FormProductionCapacity());
    }
    Fluttertoast.showToast(
      msg: title,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
