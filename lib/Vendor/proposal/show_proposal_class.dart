import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:final_pro/Client/order/order_form_scree.dart';
import 'package:final_pro/Client/order/progress_bar.dart';
import 'package:final_pro/Client/order/text_form.dart';
import 'package:final_pro/widgets/pickImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class VendorProposalClass {
  final String c_user_id;
  final String propo_id;
  // final String v_first_name; // Add this field
  final String c_city; //
  final String c_country; //
  final String c_company_name; //
  final String quantity; //
  final String target_price; //
  final String date; //
  final String time; //
  final String estimated_date; //
  final String propo_heading;
  final String embellishment;
  final String fabric;
  // Vendor
  final String v_store_name;
  final String v_store_city; //
  final String v_store_country; //
  VendorProposalClass({
    required this.c_user_id,
    required this.propo_id,
    required this.c_city,
    required this.c_country,
    required this.c_company_name,
    required this.quantity,
    required this.target_price,
    required this.date,
    required this.time,
    required this.estimated_date,
    // Vendor
    required this.v_store_name,
    required this.v_store_city,
    required this.v_store_country,

    // required this.v_store_name,
    // required this.articleStyle,
    // required this.fabric,
    // required this.quantity,
    // required this.targetPrice,
    // required this.order_status,
    // required this.size,
    required this.propo_heading,
    required this.embellishment,
    required this.fabric,
  });
}

class ProposalShowScreen extends StatefulWidget {
  const ProposalShowScreen({Key? key});

  @override
  State<ProposalShowScreen> createState() => _ProposalShowScreenState();
}

class _ProposalShowScreenState extends State<ProposalShowScreen> {
  Uuid uuid = Uuid();
  late List<VendorProposalClass> Proposal_Data_List = [];
  TextEditingController Bid_estimated_date = TextEditingController();
  String Bid_target_price = "";
  String Bid_description = "";
  String Bid_quantity = "";
  String Biding_id = Uuid().v4();
  DateTime Bid_currentDate = DateTime.now(); // Store the current date
  DateTime Bid_currenttime = DateTime.now(); // Store the current date

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
      // Fetch the data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('proposal')
          .where('proposal_status', isEqualTo: "1")
          .get();

      // Extract data from the documents
      List<VendorProposalClass> data = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (documentData != null) {
          String c_user_id = documentData['c_user_id'];
          String propo_id = documentData['propo_id'];
          // Create a VendorProposalClass object and add it to the list
          print("Client ID:  $propo_id");
          // Fetch user data using c_user_id with a where condition
          QuerySnapshot ClientSnapshot = await FirebaseFirestore.instance
              .collection('client_profile')
              .where('c_user_id', isEqualTo: c_user_id)
              .get();
          DocumentSnapshot ClientDocument = ClientSnapshot.docs.first;
// You can customize this part based on your user profile document structure
          Map<String, dynamic>? ClientData =
              ClientDocument.data() as Map<String, dynamic>?;
          FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          String v_user_id = user!.uid;
//////////////////// Vendor Data ////////////////////////////////
          QuerySnapshot VendorSnapshot = await FirebaseFirestore.instance
              .collection('user_profile')
              .where('v_user_id', isEqualTo: v_user_id)
              .get();
          DocumentSnapshot VendorDocument = VendorSnapshot.docs.first;
// You can customize this part based on your user profile document structure
          Map<String, dynamic>? VendorData =
              VendorDocument.data() as Map<String, dynamic>?;
          data.add(VendorProposalClass(
            propo_heading: documentData['propo_heading'] ?? '',
            embellishment: documentData['embellishment'] ?? '',
            fabric: documentData['fabric'] ?? '',
            c_user_id: documentData['c_user_id'] ?? '',
            propo_id: documentData['propo_id'] ?? '',
            quantity: documentData['quantity'] ?? '',
            target_price: documentData['target_price'] ?? '',
            estimated_date: documentData['estimated_date'] ?? '',
            date: documentData['date'] ?? '',
            time: documentData['time'] ?? '',
            c_company_name: ClientData?['c_company_name'] ?? '',
            c_country: ClientData?['c_country'] ?? '',
            c_city: ClientData?['c_store_city'] ?? '',

            /////// Vendor
            v_store_name: VendorData?['v_store_name'] ?? '',
            v_store_country: VendorData?['v_store_country'] ?? '',
            v_store_city: VendorData?['v_store_city'] ?? '',

            // v_user_id: v_user_id,
            // v_first_name: '', // You need to fetch this data or provide a default value
            // v_store_city: '',
            // v_store_country: '',
            // v_store_name: '',
            // articleStyle: '',
            // fabric: '',
            // quantity: '',
            // targetPrice: '',
            // order_status: 0,
          ));
          print(
            "DFSD: " + VendorData?['v_store_name'] ?? '',
          );
          print("DFSD: " + VendorData?['v_store_country'] ?? '');
          print("DFSD: " + VendorData?['v_store_city'] ?? '');
          print("DFSD: " + documentData?['embellishment'] ?? '');
          // Set the value to the state variable only if it's empty
          // if (propo_heading.isEmpty) {
          //   setState(() {
          //     propo_heading = propo_Heading;
          //     date = date;
          //   });
          // }
        }
      }
      // Update the state with the fetched data
      setState(() {
        Proposal_Data_List = data;
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
          for (VendorProposalClass Proposal_Data in Proposal_Data_List)
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 20),
              child: Container(
                height: 210,
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
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Proposal_Data.c_company_name,
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
                                      Proposal_Data.c_country,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      Proposal_Data.c_city,
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
                                          Proposal_Data.propo_heading,
                                          style: const TextStyle(
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
                                          "Quantity: " + Proposal_Data.quantity,
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
                                              Proposal_Data.target_price,
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
                                              Proposal_Data.estimated_date,
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
                              onPressed: () {
                                _Bidform(
                                  context,
                                  Proposal_Data.c_user_id,
                                  Proposal_Data.propo_id,
                                  Proposal_Data.v_store_name,
                                  Proposal_Data.v_store_country,
                                  Proposal_Data.v_store_city,
                                  Proposal_Data.propo_heading,
                                  Proposal_Data.embellishment,
                                  Proposal_Data.fabric,
                                );
                              },
                              child: Text('Bid'),
                            ),
                            Divider(
                              height: 10,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      Proposal_Data.date,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color.fromARGB(167, 74, 72, 72),
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
                                      Proposal_Data.time,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color.fromARGB(167, 74, 72, 72),
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

  void _Bidform(
      BuildContext context,
      String c_user_id,
      String propo_id,
      String v_store_country,
      String v_store_city,
      String v_store_name,
      String propo_heading,
      String embellishment,
      String fabric) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Biding Form'),
          content: _buildDialogContent(context),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                SaveProposal(c_user_id, propo_id, v_store_country, v_store_city,
                    v_store_name, propo_heading, embellishment, fabric);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
      );

      if (pickedDate != null) {
        // Update the text in the TextFormField when a date is selected
        setState(() {
          Bid_estimated_date.text = "${pickedDate.toLocal()}".split(' ')[0];
        });
      }
    }

    TextEditingController descriptionController = TextEditingController();
    int maxWordLimit = 250;
    return Container(
      width: 340.0,
      height: 300.0,
      child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              filled: true,
              fillColor: Color.fromARGB(68, 217, 216, 218),
              hintText: "Quotation Price",
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                Bid_target_price = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email!");
              }
              return null;
              // reg expression
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              filled: true,
              fillColor: Color.fromARGB(68, 217, 216, 218),
              hintText: "Quantity",
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                Bid_quantity = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email!");
              }
              return null;
              // reg expression
            },
          ),
          SizedBox(height: 10),
          //        Container(
          //   padding: EdgeInsets.all(16.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //         onPressed: uploadFileAndShowResult,
          //         child: Text('Upload File'),
          //       ),
          //       SizedBox(height: 16.0),
          //       uploadedFileName != null
          //           ? Text('Uploaded File: $uploadedFileName')
          //           : Container(),
          //     ],
          //   ),
          // ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: Bid_estimated_date,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromARGB(68, 217, 216, 218),
                    hintText: "Select Date",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  onTap: () async {
                    await _selectDate(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Select a Date!";
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  await _selectDate(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: descriptionController,
            maxLines: null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLength: maxWordLimit * 10,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              filled: true,
              fillColor: Color.fromARGB(68, 217, 216, 218),
              hintText: "Enter your description (max 250 words)",
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                Bid_description = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Description!";
              }

              // Check word limit
              int wordCount = value.split(' ').length;
              if (wordCount > maxWordLimit) {
                return "Description exceeds the word limit of $maxWordLimit words.";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  void SaveProposal(
      String c_user_id,
      String propo_id,
      String v_store_country,
      String v_store_city,
      String v_store_name,
      String propo_heading,
      String embellishment,
      String fabric) async {
    String biding_id = Uuid().v4();

    //  print("HELLOBUDDY" +);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String v_user_id = user!.uid;
    await firestore.collection('biding/').add({
      'biding_id': biding_id,
      'Bid_target_price': Bid_target_price,
      'Bid_description': Bid_description,
      'Bid_selectedDate': Bid_estimated_date.text,
      'c_user_id': c_user_id,
      'v_store_country': v_store_country,
      'propo_heading': propo_heading,
      'embellishment': embellishment,
      'fabric': fabric,
      'v_store_city': v_store_city,
      'v_store_name': v_store_name,
      'v_user_id': v_user_id,
      'Bid_quantity': Bid_quantity,
      "propo_id": propo_id,
      'date':
          DateFormat('yyyy-MM-dd').format(Bid_currentDate), // Use current date
      'time': DateFormat('HH:mm').format(Bid_currenttime),
    });
  }
}
