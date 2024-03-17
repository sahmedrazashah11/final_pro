import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Client/proposal/showBider.dart';
import 'package:uuid/uuid.dart';

class VendorStoreData {
  // final String v_user_id;
  // final String v_first_name; // Add this field
  final String c_city; //
  final String c_country; //
  final String c_company_name; //
  final String quantity; //
  final String target_price; //
  final String date; //
  final String time; //
  final String propo_id; //

  final String estimated_date; //
  // final String v_store_name; //
  // final String articleStyle; //
  // final String fabric; //
  // final String quantity; //
  // final String targetPrice; //
  // final int order_status; //

  final String propo_heading;

  // final String size; //

  VendorStoreData({
    // required this.v_user_id,
    // required this.v_first_name,
    required this.c_city,
    required this.c_country,
    required this.propo_id,
    required this.c_company_name,
    required this.quantity,
    required this.target_price,
    required this.date,
    required this.time,
    required this.estimated_date,
    required this.propo_heading,
  });
}

class ProposalShowScreen extends StatefulWidget {
  const ProposalShowScreen({Key? key});

  @override
  State<ProposalShowScreen> createState() => _ProposalShowScreenState();
}

class _ProposalShowScreenState extends State<ProposalShowScreen> {
  Uuid uuid = Uuid();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  late List<VendorStoreData> vendorStoreDataList = [];
  // String propo_heading = '';
  String date = '';
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
          .collection('proposal')
          .where('c_user_id', isEqualTo: userId)
          .where('proposal_status', isEqualTo: "1")
          .get();
      // Extract data from the documents
      List<VendorStoreData> data = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (documentData != null) {
          String c_user_id = documentData['c_user_id'];
          String propo_id = documentData['propo_id'];
          QuerySnapshot ClientSnapshot = await FirebaseFirestore.instance
              .collection('client_profile')
              .where('c_user_id', isEqualTo: c_user_id)
              .get();
          DocumentSnapshot ClientDocument = ClientSnapshot.docs.first;
// You can customize this part based on your user profile document structure
          Map<String, dynamic>? ClientData =
              ClientDocument.data() as Map<String, dynamic>?;

          data.add(VendorStoreData(
            propo_heading: documentData['propo_heading'] ?? '',
            quantity: documentData['quantity'] ?? '',
            propo_id: documentData['propo_id'] ?? '',
            target_price: documentData['target_price'] ?? '',
            estimated_date: documentData['estimated_date'] ?? '',
            date: documentData['date'] ?? '',
            time: documentData['time'] ?? '',
            c_company_name: ClientData?['c_company_name'] ?? '',
            c_country: ClientData?['c_country'] ?? '',
            c_city: ClientData?['c_store_city'] ?? '',
          ));
        }
      }
      // Update the state with the fetched data
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
                      child: InkWell(
                        onTap: () {
                          print("GGGF" + vendorStoreData.propo_id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BiderShowScreen(
                                propoId: vendorStoreData
                                    .propo_id, // Pass the generated order ID
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vendorStoreData.c_company_name,
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
                                        vendorStoreData.c_country,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        vendorStoreData.c_city,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            vendorStoreData.propo_heading,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
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
                                            "Quantity: " +
                                                vendorStoreData.quantity,
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
                                            "Target Price: " +
                                                vendorStoreData.target_price,
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
                                      Row(
                                        children: [
                                          Text(
                                            'Estimated Date: ' +
                                                vendorStoreData.estimated_date,
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
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  User? user = auth.currentUser;
                                  String userId = user!.uid;
                                  String documentId = vendorStoreData.propo_id;

                                  QuerySnapshot querySnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('proposal')
                                          .where('c_user_id', isEqualTo: userId)
                                          .where('propo_id',
                                              isEqualTo: documentId)
                                          .get();

                                  // Check if there are any documents in the query snapshot
                                  if (querySnapshot.docs.isNotEmpty) {
                                    // Extract the first document reference
                                    DocumentReference documentReference =
                                        querySnapshot.docs[0].reference;
                                    String fieldToUpdate = 'proposal_status';
                                    dynamic newValue = '2';

                                    try {
                                      await documentReference.update({
                                        fieldToUpdate: newValue,
                                      });
                                      print('Value updated successfully.');
                                    } catch (error) {
                                      print('Error updating value: $error');
                                    }
                                  } else {
                                    print('Document not found.');
                                  }
                                },
                                child: Text('Archived'),
                              ),
                              Divider(
                                height: 10,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        vendorStoreData.date,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              Color.fromARGB(167, 74, 72, 72),
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
                                        vendorStoreData.time,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              Color.fromARGB(167, 74, 72, 72),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
