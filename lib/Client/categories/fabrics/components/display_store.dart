import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Client/chat/chat_view.dart';
import 'package:final_pro/Client/order/order_form_scree.dart';
import 'package:final_pro/Client/order/text_form.dart';
import 'package:final_pro/Vendor/chat/vendor_chat_view.dart';
import 'package:uuid/uuid.dart';

class VendorStoreData {
  final String productName;
  final String v_user_id;
  final List<String> tags;
  final String imageUrl;
  final String v_first_name; // Add this field
  final String v_store_city; //
  final String v_store_country; //
  final String v_store_name; //
  final String priceRange; // Use RangeValues for price range
  final RangeValues min_orderRange; // Use RangeValues for price range
  //final String min_order; //
  final String product_type; //
  VendorStoreData({
    required this.productName,
    required this.tags,
    required this.imageUrl,
    required this.v_user_id,
    required this.v_first_name,
    required this.v_store_city,
    required this.v_store_country,
    required this.v_store_name,
    required this.priceRange,
    required this.min_orderRange,
    required this.product_type,
  });
}

class WidgetVendorsStores extends StatefulWidget {
  const WidgetVendorsStores({Key? key});

  @override
  State<WidgetVendorsStores> createState() => _WidgetVendorsStoresState();
}

class _WidgetVendorsStoresState extends State<WidgetVendorsStores> {
  Uuid uuid = Uuid();

// Use this function to generate a unique ID
  String generateUniqueId() {
    return uuid.v4();
  }

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
      String clientID = user!.uid;
      // Fetch the data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('product_basic_info')
          .get();

      // Extract data from the documents
      List<VendorStoreData> data = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (documentData != null) {
          String productName = documentData['product_title'] ?? '';
          String v_user_id = documentData['v_user_id'] ?? '';
          dynamic tagsData = documentData['product_size'];
          String imageUrl = documentData['bannar_Image'] ?? '';

          List<String> tags;
          if (tagsData is String) {
            tags = [tagsData];
          } else if (tagsData is List) {
            tags = List<String>.from(tagsData);
          } else {
            tags = [];
          }

          if (imageUrl != null) {
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
            // Fetch data from product Basic Information
            QuerySnapshot ClientSnapshot = await FirebaseFirestore.instance
                .collection('client_profile')
                .where('c_user_id', isEqualTo: clientID)
                .get();
            // Check if user data exists
            if (userSnapshot.docs.isNotEmpty) {
              // Extract user data from the first document (assuming v_user_id is unique)
              DocumentSnapshot userDocument = userSnapshot.docs.first;

              // Extract Vendor Data
              DocumentSnapshot PBIDocument = PBISnapshot.docs.first;

              DocumentSnapshot ClientDocument = ClientSnapshot.docs.first;

              // Extract user-specific data
              // You can customize this part based on your user profile document structure
              Map<String, dynamic>? userData =
                  userDocument.data() as Map<String, dynamic>?;
              // Extract Vendor Data
              Map<String, dynamic>? PBIData =
                  PBIDocument.data() as Map<String, dynamic>?;

              Map<String, dynamic>? ClientData =
                  ClientDocument.data() as Map<String, dynamic>?;

              Map<String, dynamic>? OrderRangeData = PBIData?['min_order'];
              if (userData != null) {
                // Extract user-specific data
                String v_first_name = userData['v_first_name'] ?? '';
                String v_store_city = userData['v_store_city'] ?? '';
                String v_store_country = userData['v_store_country'] ?? '';
                String v_store_name = userData['v_store_name'] ?? '';

                String c_user_id = ClientData?['c_user_id'] ?? '';
                print("clientid" + c_user_id);
                // Extract price range as RangeValues
                // double minPrice =
                //     (priceRangeData?['minPrice'] ?? 0.0).toDouble();
                // double maxPrice =
                //     (priceRangeData?['maxPrice'] ?? 0.0).toDouble();
                // RangeValues priceRange = RangeValues(minPrice, maxPrice);
                double minOrder =
                    (OrderRangeData?['minOrder'] ?? 0.0).toDouble();
                double maxOrder =
                    (OrderRangeData?['maxOrder'] ?? 0.0).toDouble();
                RangeValues min_orderRange = RangeValues(minOrder, maxOrder);
                // dynamic min_orderData = PBIData?['min_order'];
                // String min_order =
                //     (min_orderData is String) ? min_orderData : '';
                String product_type = PBIData?['product_type'] ?? '';
                String price_range = PBIData?['price_range'] ?? '';

                print('Min Price: $product_type');
                // Add the data to the list
                data.add(VendorStoreData(
                  productName: productName,
                  tags: tags,
                  imageUrl: imageUrl,
                  v_user_id: v_user_id,
                  // Add user-specific data to the VendorStoreData object
                  // Modify this part based on your user profile structure
                  // For example, you might have user-specific fields like user_name, user_location, etc.
                  v_first_name: v_first_name,
                  v_store_city: v_store_city,
                  v_store_country: v_store_country,
                  v_store_name: v_store_name,
                  priceRange: price_range,
                  min_orderRange: min_orderRange,
                  product_type: product_type,
                ));
                print("vendor name" + v_first_name);
              }
            }
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
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 200,
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
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Image.network(
                            vendorStoreData.imageUrl,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 130,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                User? user = auth.currentUser;
                                String clientID = user!.uid;
                                // Navigate to the order form screen with the selected user's ID and the generated order ID
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VendorChatScreen(
                                      currentUserId: clientID,
                                      currentUserName: clientID,
                                      receiverId: vendorStoreData.v_user_id,
                                      receiverName:
                                          vendorStoreData.v_first_name,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Chat"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Generate a unique order ID (you can replace this with your actual order ID logic)
                                String orderId = generateUniqueId();

                                // Navigate to the order form screen with the selected user's ID and the generated order ID
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DynamicForm(
                                      v_user_id: vendorStoreData.v_user_id,
                                      v_store_name:
                                          vendorStoreData.v_store_name,
                                      v_first_name:
                                          vendorStoreData.v_first_name,
                                      v_store_country:
                                          vendorStoreData.v_store_country,
                                      v_store_city:
                                          vendorStoreData.v_store_city,
                                      orderId:
                                          orderId, // Pass the generated order ID
                                    ),
                                  ),
                                );
                              },
                              child: Text("Order"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendorStoreData.productName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendorStoreData.v_store_name,
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
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
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      vendorStoreData.v_store_city,
                                      style: TextStyle(
                                        fontSize: 10,
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
                                  children: [
                                    Text(
                                      "Order Range: ${vendorStoreData.min_orderRange.start} - ${vendorStoreData.min_orderRange.end}",
                                      style: TextStyle(
                                        fontSize: 11,
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
                                      'Price Range: ${vendorStoreData.priceRange}',
                                      style: const TextStyle(
                                        fontSize: 11,
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
                                    Expanded(
                                      child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        text: TextSpan(
                                          text:
                                              'Product Type: ${vendorStoreData.product_type}',
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
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
                            Varifiedimage(),
                            Rating(),
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

  Widget Varifiedimage() {
    return Container(
        child: Row(
      children: [
        Column(children: [
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 25, // Set the desired height for the image
                child: Image.asset(
                  'assets/images/verified.png',
                  fit: BoxFit.fill,
                  width: 35,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 148, 147, 144),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  '5 years',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ])
      ],
    ));
  }

  Widget Rating() {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.orange, size: 15),
            Icon(Icons.star, color: Colors.orange, size: 15),
            Icon(Icons.star, color: Colors.orange, size: 15),
            Icon(Icons.star, color: Colors.orange, size: 15),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '4.0', // Rating
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          ' | (15)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
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
