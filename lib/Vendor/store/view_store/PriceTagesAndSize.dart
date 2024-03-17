import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PriceTagesAndSize extends StatelessWidget {
  final String userId;

  PriceTagesAndSize({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('product_basic_info').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("No data found for the user");
        } else {
          Map<String, dynamic> productData = snapshot.data!.data() ?? {};
               print("userIDddd" + userId);
               print("userIDddd ${productData['priceRange'] ?? ""}");
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Range: ${productData['priceRange'] ?? ""}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Min. order: ${productData['minOrder'] ?? ""} Pieces'),
                  Text(
                    'Description: ${productData['description'] ?? ""}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text(
                    'Size',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Add your size widget or customization here
                  // ...
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text(
                    'Purchase Details:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          'Shipping:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Contact supplier '),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          'Payments:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Enjoy encrypted and secure payments'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          'Returns & Refund:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Eligible for returns and refunds. View details'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
