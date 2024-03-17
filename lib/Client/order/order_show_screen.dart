import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Client/order/order_form_scree.dart';
import 'package:final_pro/Client/order/progress_bar.dart';
import 'package:final_pro/Client/order/text_form.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:uuid/uuid.dart';

class VendorStoreData {
  final String v_user_id;
  final List<String> tags;
  final String v_first_name; // Add this field
  final String v_store_city; //
  final String v_store_country; //
  final String v_store_name; //
  final String order_files; //
  final String priceRange; // Use RangeValues for price range
  final RangeValues min_orderRange;
  final String product_type; //
  final String articleStyle; //
  final String fabric; //
  final String quantity; //
  final String targetPrice; //
  final int order_status; //

  // final String size; //

  VendorStoreData({
    required this.tags,
    required this.v_user_id,
    required this.v_first_name,
    required this.v_store_city,
    required this.v_store_country,
    required this.v_store_name,
    required this.order_files,
    required this.priceRange,
    required this.min_orderRange,
    required this.product_type,
    required this.articleStyle,
    required this.fabric,
    required this.quantity,
    required this.targetPrice,
    required this.order_status,

    // required this.size,
  });
}

class OrderShowScreen extends StatefulWidget {
  const OrderShowScreen({Key? key});

  @override
  State<OrderShowScreen> createState() => _OrderShowScreenState();
}

class _OrderShowScreenState extends State<OrderShowScreen> {
  Uuid uuid = Uuid();
  late List<VendorStoreData> vendorStoreDataList = [];

  @override
  void initState() {
    super.initState();
    // Call the method to fetch data when the widget is created
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      String userId = user!.uid;
      // Fetch the data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('order_details')
          .where('c_user_id', isEqualTo: userId)
          .get();

      // Extract data from the documents
      List<VendorStoreData> data = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (documentData != null) {
          String v_user_id = documentData['v_user_id'] ?? '';
          dynamic tagsData = documentData['product_size'];

          // Fetch user data using v_user_id with a where condition
          QuerySnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('user_profile')
              .where('v_user_id', isEqualTo: v_user_id)
              .get();
          // Fetch data from product Basic Information
          QuerySnapshot PBISnapshot = await FirebaseFirestore.instance
              .collection('product_basic_info')
              .where('v_user_id', isEqualTo: v_user_id)
              .get();
          // Fetch data from OrderDB
          QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
              .collection('order_details')
              .get();
          // Check if user data exists
          if (userSnapshot.docs.isNotEmpty &&
              PBISnapshot.docs.isNotEmpty &&
              orderSnapshot.docs.isNotEmpty) {
            // Extract user data from the first document (assuming v_user_id is unique)
            DocumentSnapshot userDocument = userSnapshot.docs.first;

            // Extract Vendor Data
            DocumentSnapshot PBIDocument = PBISnapshot.docs.first;

            // Extract Vendor Data
            DocumentSnapshot orderDocument = orderSnapshot.docs.first;

            // Extract user-specific data
            // You can customize this part based on your user profile document structure
            Map<String, dynamic>? userData =
                userDocument.data() as Map<String, dynamic>?;
            // Extract Vendor Data
            Map<String, dynamic>? PBIData =
                PBIDocument.data() as Map<String, dynamic>?;
            // Extract Order Data from the current documentSnapshot
            Map<String, dynamic>? orderData =
                documentSnapshot.data() as Map<String, dynamic>?;

            // Move the declaration and initialization of articleStyle here
            String articleStyle = orderData?['articleStyle'] ?? '';
            String fabric = orderData?['fabric'] ?? '';
            String quantity = orderData?['quantity'] ?? '';
            String targetPrice = orderData?['targetPrice'] ?? '';
            int order_status = orderData?['order_status'] ?? '';
            String order_files = orderData?['order_files'] ?? '';

            // String size = orderData?['size'] ?? '';
            print("articleR $articleStyle");
            print("articleR $fabric");
            print("articleR $quantity");
            print("articleR $targetPrice");
            //  print("articleR $size");

            setState(() {
              articleStyle = orderData?['articleStyle'] ?? '';
            });
            Map<String, dynamic>? OrderRangeData = PBIData?['min_order'];
            // Extract price range as RangeValues
            double minOrder = (OrderRangeData?['minOrder'] ?? 0.0).toDouble();
            double maxOrder = (OrderRangeData?['maxOrder'] ?? 0.0).toDouble();
            RangeValues min_orderRange = RangeValues(minOrder, maxOrder);

            String product_type = PBIData?['product_type'] ?? '';
            String price_range = PBIData?['price_range'] ?? '';

            // Add the data to the list
            data.add(VendorStoreData(
              tags: tagsData is List<String> ? tagsData : [],
              v_user_id: v_user_id,
              // Add user-specific data to the VendorStoreData object
              // Modify this part based on your user profile structure
              // For example, you might have user-specific fields like user_name, user_location, etc.
              v_first_name: userData?['v_first_name'] ?? '',
              v_store_city: userData?['v_store_city'] ?? '',

              v_store_country: userData?['v_store_country'] ?? '',
              v_store_name: userData?['v_store_name'] ?? '',
              priceRange: price_range,
              min_orderRange: min_orderRange,
              product_type: product_type,
              articleStyle: articleStyle,
              fabric: fabric,
              quantity: quantity,
              targetPrice: targetPrice,
              order_status: order_status,
              order_files: order_files,

              //  size: size,
            ));
            print("vendor name" + userData?['v_first_name'] ?? '');
          }
        }
      }
      setState(() {
        vendorStoreDataList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (VendorStoreData vendorStoreData in vendorStoreDataList)
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 20),
              child: Container(
                height: MediaQuery.of(context).size.height / 3.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  vendorStoreData.v_store_name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      vendorStoreData.v_store_country,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      vendorStoreData.v_store_city,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Divider(
                              height: 10,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Article Style: ${vendorStoreData.articleStyle}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Fabric: ${vendorStoreData.fabric}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity: ${vendorStoreData.quantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Target Price: ${vendorStoreData.targetPrice}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        var url =
                                            "${vendorStoreData.order_files}";

                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'error launching $url';
                                        }
                                      },
                                      child: Text(
                                        "Product File",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       //  'Size: ${vendorStoreData.size}',
                                    //       'Size: ',
                                    //       style: const TextStyle(
                                    //         fontSize: 14,
                                    //         color: Colors.black,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: vendorStoreData.tags.map((tag) {
                                    return Padding(
                                      padding: EdgeInsets.all(1),
                                      child: _buildTag(tag),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            OrderProgressBar(
                              currentStep: vendorStoreData.order_status,
                              onUpdate: (int) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(fontSize: 8),
        ),
      ),
    );
  }
}
