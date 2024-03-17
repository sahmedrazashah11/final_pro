import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:final_pro/Client/categories/apparel/apparel_screen.dart';
import 'package:final_pro/Client/order/firebase_api.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({
    Key? key,
    required this.v_user_id,
    required this.v_store_name,
    required this.v_first_name,
    required this.v_store_country,
    required this.v_store_city,
    required this.orderId, // New parameter for order ID
  }) : super(key: key);

  final String v_user_id;
  final String v_store_name;
  final String v_first_name;
  final String v_store_country;
  final String v_store_city;
  final String orderId; // New parameter for order ID
  @override
  State<DynamicForm> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<DynamicForm> {
  String? folderPath;
  final _formKey = GlobalKey<FormState>();
  List<File?> _pickedFiles = [];
  List<Map<String, dynamic>> _formFieldsList = [];
  var size;
  var storeName = 'Hello';
  bool isChecked = false;
// Form Fields Controller
  TextEditingController _storeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the controller's text with the value of v_store_name
    _storeNameController.text = widget.v_store_name ?? '';
  }

  Uint8List? fileBytes;
  late String fileName = '';

  UploadTask? task;
  File? file;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      _handleFilePicking(result.files);
    }
  }

  void _handleFilePicking(List<PlatformFile> files) {
    setState(() {
      _pickedFiles = files.map((file) => File(file.path!)).toList();
    });
  }

  void _duplicateFormFields() {
    // Create a new entry with unique keys based on the current timestamp
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final Map<String, dynamic> newFormFields = {
      'articleStyle_$timestamp': '',
      'fabric_$timestamp': '',
      'embellishment_$timestamp': '',
      'targetPrice_$timestamp': '',
      'quantity_$timestamp': '',
      'size_$timestamp': '',
    };

    setState(() {
      _formFieldsList.add(newFormFields);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Order Form",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      for (int i = 0; i < _formFieldsList.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          "Store Name:",
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[
                                                  200], // Light gray background color
                                              borderRadius: BorderRadius.circular(
                                                  8), // Optional: Add border radius
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(widget.v_store_name),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          "Vendor Name:",
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[
                                                  200], // Light gray background color
                                              borderRadius: BorderRadius.circular(
                                                  8), // Optional: Add border radius
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(widget.v_first_name),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Region:",
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .grey[200], // Light gray background color
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: Add border radius
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${widget.v_store_country}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${widget.v_store_city}',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Article Style:"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(68, 217, 216, 218),
                                // border: UnderlineInputBorder(),

                                hintText: "UNISEX BURN WASH RAGLAN",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _formFieldsList[i]['articleStyle'] = value;
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
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Fabric:"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(68, 217, 216, 218),
                                // border: UnderlineInputBorder(),

                                hintText: "60% Cotton 40% Polyester",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _formFieldsList[i]['fabric'] = value;
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
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Embellishment:"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(68, 217, 216, 218),
                                // border: UnderlineInputBorder(),

                                hintText: "All",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _formFieldsList[i]['embellishment'] = value;
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
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Target Price:"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(68, 217, 216, 218),
                                // border: UnderlineInputBorder(),

                                hintText: "All",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _formFieldsList[i]['targetPrice'] = value;
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
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Quantity:"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(68, 217, 216, 218),
                                // border: UnderlineInputBorder(),

                                hintText: "All",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _formFieldsList[i]['quantity'] = value;
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
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Size"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomCheckBoxGroup(
                              buttonTextStyle: const ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.orange,
                                textStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                selectedTextStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              autoWidth: false,
                              wrapAlignment: WrapAlignment.center,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: const [
                                "S",
                                "M",
                                "L",
                                "XL",
                                "XXL",
                              ],
                              disabledValues: const [
                                "",
                              ],
                              buttonValuesList: const [
                                "S",
                                "M",
                                "L",
                                "XL",
                                "XXL",
                              ],
                              checkBoxButtonValues: (values) {
                                size = values;

                                setState(() {
                                  _formFieldsList[i]['size'] = values;
                                });
                              },
                              spacing: 0,
                              defaultSelected: const ["Small"],
                              horizontal: false,
                              enableButtonWrap: false,
                              width: 70,
                              absoluteZeroSpacing: false,
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                              padding: 6,
                              // enableShape: true,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      selectFile();
                                    },
                                    child: Text("Select Files"),
                                  ),
                                  Divider(),
                                  Text("Picked Files:"),
                                  Divider(),
                                  fileName != null
                                      ? Wrap(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(8.0),
                                              child: Card(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons
                                                          .insert_drive_file),
                                                      SizedBox(height: 8.0),
                                                      Text(
                                                        fileName,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ElevatedButton(
                        onPressed: _duplicateFormFields,
                        child: Text('Duplicate Fields'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Contract(context);
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future<void> _submitForm() async {
    CollectionReference orderCollection =
        FirebaseFirestore.instance.collection('order_details');

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;

    for (int i = 0; i < _formFieldsList.length; i++) {
      String articleStyle = _formFieldsList[i]['articleStyle'];
      String fabric = _formFieldsList[i]['fabric'];
      String embellishment = _formFieldsList[i]['embellishment'];
      String targetPrice = _formFieldsList[i]['targetPrice'];
      String quantity = _formFieldsList[i]['quantity'];
      String size = _formFieldsList[i]['size'].join(', ');
      // if (fileBytes != null) {
      //   print("file is here");
      //   folderPath = await uploadFileAndGetUrl();
      // }
      String fileUrl = folderPath ?? '';
      // Use the file URL obtained during file upload
      // String fileUrl = /* Obtain the file URL from the upload process */;
      if (file == null) return;

      final fileName = basename(file!.path);
      final destination = 'files/$fileName';

      task = FirebaseApi.uploadFile(destination, file!);
      setState(() {});

      if (task == null) return;

      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
      // Create a document with a unique ID
      DocumentReference docRef = await orderCollection.add({
        'articleStyle': articleStyle,
        'fabric': fabric,
        'embellishment': embellishment,
        'targetPrice': targetPrice,
        'quantity': quantity,
        'size': size,
        'c_user_id': userId,
        'order_status': 1,
        'order_files': urlDownload,
        'v_user_id': widget.v_user_id,
        'v_store_name': widget.v_store_name,
        'v_first_name': widget.v_first_name,
        'v_store_country': widget.v_store_country,
        'v_store_city': widget.v_store_city,
        'order_id': widget.orderId,
      });

      print('Order ${i + 1} saved with ID: ${docRef.id}');
    }

    Fluttertoast.showToast(
      msg: 'Order submitted successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    Get.to(ApparelScreen);
  }

  void Contract(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Dialog Title'),
              content: Container(
                height: 300,
                child: ListView(
                  children: [
                    Text(
                      "This Digital Agreement (Agreement) is entered into by and between [Client's Name], hereinafter referred to as the Client, and [Vendor's Name], hereinafter referred to as the Vendor, collectively referred to as the \"Parties.\"\n\n"
                              "1. Scope of Work:\n"
                              "1.1 The Vendor agrees to provide the products/services specified in the order placed by the Client through the [Your App Name] platform.\n"
                              "1.2 The Client agrees to pay the agreed-upon amount for the products/services as specified in the order.\n\n"
                              "2. Delivery and Acceptance:\n"
                              "2.1 The Vendor agrees to deliver the products/services within the agreed-upon timeframe and meeting the specifications outlined in the order.\n"
                              "2.2 The Client agrees to inspect and accept the delivered products/services promptly upon receipt.\n\n"
                              "3. Payment:\n"
                              "3.1 The Client agrees to make payments through the Stitch Vision platform using the specified payment method.\n"
                              "3.2 The Vendor agrees to receive payments through the Stitch Vision platform as per the agreed-upon terms.\n\n"
                              "4. Changes and Cancellations:\n"
                              "4.1 Changes to the order or cancellations must be requested by the Client within a reasonable time frame and are subject to Vendor approval.\n"
                              "4.2 The Vendor may charge fees for changes or cancellations, as outlined in their policies.\n\n"
                              "5. Quality Assurance:\n"
                              "5.1 The Vendor warrants the quality and authenticity of the products/services provided.\n"
                              "5.2 The Client has the right to provide feedback and ratings based on their experience.\n\n"
                              "6. Confidentiality:\n"
                              "6.1 Both Parties agree to keep any confidential information obtained during the course of this agreement confidential and not disclose it to third parties.\n\n"
                              "7. Dispute Resolution:\n"
                              "7.1 In the event of disputes, the Parties agree to attempt resolution through communication.\n"
                              "7.2 Unresolved disputes may be subject to mediation or legal action, as per the laws governing the agreement.\n\n"
                              "8. App Fees:\n"
                              "8.1 Both Parties acknowledge that the Stitch Vision platform may charge fees for its services, and these will be deducted as specified in the app's policies.\n\n"
                              "10. Termination:\n"
                              "10.1 Either Party may terminate this agreement with written notice if the other Party breaches a material term and fails to remedy the breach within a reasonable time.\n\n"
                              "11. Entire Agreement:\n"
                              "11.1 This Agreement constitutes the entire understanding between the Parties and supersedes any prior agreements or understandings, whether written or oral.\n\n"
                              "IN WITNESS WHEREOF, the Parties hereto have executed this Digital Agreement as of the Effective Date.\n\n"
                              "Client's Full Name" +
                          widget.v_first_name +
                          "\n\n"
                              "Vendor's Full Name" +
                          widget.v_first_name +
                          "\n\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'I agree to the terms and conditions.',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                ElevatedButton(
                  onPressed: isChecked
                      ? () {
                          _submitForm();
                          // Perform action when the user agrees
                          Navigator.of(context).pop();
                          // Add your logic here
                        }
                      : null,
                  child: Text('Agree'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
