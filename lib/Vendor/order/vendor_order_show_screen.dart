import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Client/order/order_form_scree.dart';
import 'package:final_pro/Client/order/progress_bar.dart';
import 'package:final_pro/Client/order/text_form.dart';
import 'package:final_pro/Vendor/chat/vendor_chat_view.dart';
import 'package:final_pro/Vendor/order/status_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class VendorStoreData {
  final String v_user_id;
  final List<String> tags;

  final String priceRange; // Use RangeValues for price range
  final RangeValues min_orderRange; //
  final String product_type; //
  final String articleStyle; //
  final String order_files; //
  final String fabric; //
  final String quantity; //
  final String targetPrice; //
  late final int order_status; //
  final String order_id; //
  final String documentId; //

  // final String size; //

  // Client Fields
  final String c_user_id;
  final String c_company_name;
  final String c_country;
  final String c_store_city;

  VendorStoreData({
    required this.tags,
    required this.v_user_id,
    required this.priceRange,
    required this.min_orderRange,
    required this.product_type,
    required this.articleStyle,
    required this.order_files,
    required this.fabric,
    required this.quantity,
    required this.targetPrice,
    required this.order_status,
    required this.order_id,
    required this.documentId,
    // required this.size,

    // Client Fields
    required this.c_user_id,
    required this.c_company_name,
    required this.c_country,
    required this.c_store_city,
  });
}

class VendorOrderShowScreen extends StatefulWidget {
  const VendorOrderShowScreen({Key? key});

  @override
  State<VendorOrderShowScreen> createState() => _VendorOrderShowScreenState();
}

class _VendorOrderShowScreenState extends State<VendorOrderShowScreen> {
  Uuid uuid = Uuid();
  late List<VendorStoreData> vendorStoreDataList = [];
  //late String documentId;
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
          .where('v_user_id', isEqualTo: userId)
          .get();

      // Extract data from the documents
      List<VendorStoreData> data = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (documentData != null) {
          String v_user_id = documentData['v_user_id'] ?? '';
          String c_user_id = documentData['c_user_id'] ?? '';
          dynamic tagsData = documentData['product_size'];
          print("Client ID " + c_user_id);
          String documentId = documentSnapshot.id;
          // Now you have the document ID, you can use it as needed
          print('Document ID: $documentId');
          // Fetch user data using c_user_id with a where condition
          QuerySnapshot ClientSnapshot = await FirebaseFirestore.instance
              .collection('client_profile')
              .where('c_user_id', isEqualTo: c_user_id)
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
          if (ClientSnapshot.docs.isNotEmpty &&
              PBISnapshot.docs.isNotEmpty &&
              orderSnapshot.docs.isNotEmpty) {
            // Extract user data from the first document (assuming v_user_id is unique)
            DocumentSnapshot ClientDocument = ClientSnapshot.docs.first;

            // Extract Vendor Data
            DocumentSnapshot PBIDocument = PBISnapshot.docs.first;

            // Extract Vendor Data
            DocumentSnapshot orderDocument = orderSnapshot.docs.first;

            // Extract user-specific data
            // You can customize this part based on your user profile document structure
            Map<String, dynamic>? ClientData =
                ClientDocument.data() as Map<String, dynamic>?;
            // Extract Vendor Data
            Map<String, dynamic>? PBIData =
                PBIDocument.data() as Map<String, dynamic>?;
            // Extract Order Data from the current documentSnapshot
            Map<String, dynamic>? orderData =
                documentSnapshot.data() as Map<String, dynamic>?;

            // Move the declaration and initialization of articleStyle here
            String articleStyle = orderData?['articleStyle'] ?? '';
            String fabric = orderData?['fabric'] ?? '';
            String order_files = orderData?['order_files'] ?? '';
            String quantity = orderData?['quantity'] ?? '';
            String targetPrice = orderData?['targetPrice'] ?? '';
            int order_status = orderData?['order_status'] ?? '';
            String order_id = orderData?['order_id'] ?? '';
            setState(() {
              articleStyle = orderData?['articleStyle'] ?? '';
            });

            // Extract price range as RangeValues
            String price_range = PBIData?['price_range'] ?? '';
            Map<String, dynamic>? OrderRangeData = PBIData?['min_order'];
            double minOrder = (OrderRangeData?['minOrder'] ?? 0.0).toDouble();
            double maxOrder = (OrderRangeData?['maxOrder'] ?? 0.0).toDouble();
            RangeValues min_orderRange = RangeValues(minOrder, maxOrder);
            String product_type = PBIData?['product_type'] ?? '';
            dynamic tagsData = orderData?['product_size'];
            List<String> tags;
            if (tagsData is String) {
              tags = [tagsData];
            } else if (tagsData is List) {
              tags = List<String>.from(tagsData);
            } else {
              tags = [];
            }
            // Add the data to the list
            data.add(VendorStoreData(
              tags: tags,
              v_user_id: v_user_id,
              documentId: documentId,
              c_company_name: ClientData?['c_company_name'] ?? '',
              c_country: ClientData?['c_country'] ?? '',
              c_store_city: ClientData?['c_store_city'] ?? '',
              priceRange: price_range,
              min_orderRange: min_orderRange,
              product_type: product_type,
              articleStyle: articleStyle,
              fabric: fabric,
              quantity: quantity,
              targetPrice: targetPrice,
              order_status: order_status,
              order_id: order_id,
              c_user_id: c_user_id,
              order_files: order_files,
              //  size: size,
            ));
            String c_company_name = ClientData?['c_company_name'] ?? '';
            print("CLietn " + order_files);
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
          for (VendorStoreData ClientAndOrderData in vendorStoreDataList)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 260,
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
                                  ClientAndOrderData.c_company_name,
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
                                      ClientAndOrderData.c_country,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      ClientAndOrderData.c_store_city,
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
                                          "Article Style: ${ClientAndOrderData.articleStyle}",
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
                                          'Fabric: ${ClientAndOrderData.fabric}',
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
                                          "Quantity: ${ClientAndOrderData.quantity}",
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
                                          "Target Price: ${ClientAndOrderData.targetPrice}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: ClientAndOrderData.tags.map((tag) {
                                    return Padding(
                                      padding: EdgeInsets.all(1),
                                      child: _buildTag(tag),
                                    );
                                  }).toList(),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Text(
                                //           "Order Range: ${ClientAndOrderData.min_orderRange.start} - ${ClientAndOrderData.min_orderRange.end}",
                                //           style: const TextStyle(
                                //             fontSize: 14,
                                //             color: Colors.black,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: ClientAndOrderData.tags.map((tag) {
                                    return Padding(
                                      padding: EdgeInsets.all(1),
                                      child: _buildTag(tag),
                                    );
                                  }).toList(),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var url =
                                        "${ClientAndOrderData.order_files}";

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
                              currentStep: ClientAndOrderData.order_status,
                              onUpdate: (int newStep) {
                                // Update the UI when the order status changes
                                setState(() {
                                  ClientAndOrderData.order_status = newStep;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                StatusButtonWidget(
                                  currentStatus:
                                      ClientAndOrderData.order_status,
                                  order_id: ClientAndOrderData.documentId,
                                  onStatusChanged: (newStatus, orderId) {
                                    // Handle the updated status and order_id
                                    print(
                                        "Updated Status: $newStatus, Order ID: $orderId");
                                    // You can perform additional actions here if needed
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    User? user = auth.currentUser;
                                    String VendroID = user!.uid;
                                    // Navigate to the order form screen with the selected user's ID and the generated order ID
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VendorChatScreen(
                                          currentUserId: VendroID,
                                          currentUserName: VendroID,
                                          receiverId:
                                              ClientAndOrderData.c_user_id,
                                          receiverName:
                                              ClientAndOrderData.c_company_name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("Chat"),
                                ),
                              ],
                            )
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
