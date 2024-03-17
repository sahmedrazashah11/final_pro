import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BidingDynamicForm extends StatefulWidget {
  const BidingDynamicForm({
    Key? key,
    required this.v_user_id,
    required this.v_store_name,
    required this.v_first_name,
    required this.v_store_country,
    required this.propo_heading,
    required this.v_store_city,
    required this.orderId,
    required this.Bid_quantity,
    required this.Bid_target_price, 
    required this.embellishment, 
    required this.fabric, 
    required this.biding_id, // New parameter for order ID
  }) : super(key: key);

  final String v_user_id;
  final String v_store_name;
  final String v_first_name;
  final String v_store_country;
  final String propo_heading;
  final String Bid_quantity;
  final String v_store_city;
  final String Bid_target_price;
  final String embellishment;
  final String fabric;
  final String biding_id;
  final String orderId; // New parameter for order ID
  @override
  State<BidingDynamicForm> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<BidingDynamicForm> {
  final _formKey = GlobalKey<FormState>();
  List<File?> _pickedFiles = [];
  List<Map<String, dynamic>> _formFieldsList = [];
  var size;
  var storeName = 'Hello';

// Form Fields Controller
  TextEditingController _storeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the controller's text with the value of v_store_name
    _storeNameController.text = widget.v_store_name ?? '';
  }

  Uint8List? fileBytes;
  late String fileName;

  openFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null) {
        fileBytes = result.files.first.bytes;
        fileName = result.files.first.name;
        await uploadFileToStorage();
        setState(() {});
      } else {
        print("No files are selected.");
      }
    } catch (e) {
      print("Error while picking file: $e");
    }
  }

  Future<void> uploadFileToStorage() async {
    try {
      String folderPath =
          'your_folder_name'; // Specify your desired folder name
      String filePath = '$folderPath/$fileName';

      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(filePath);

      // Upload file to Firebase Storage
      await storageRef.putData(fileBytes!);

      // Get the download URL of the uploaded file
      String downloadUrl = await storageRef.getDownloadURL();
      print('File uploaded to: $downloadUrl');

      // Now you can use the downloadUrl as needed (e.g., store it in Firestore).
    } catch (e) {
      print("Error uploading file to storage: $e");
    }
  }

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
                        "Bid Order Form",
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
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey[200], // Light gray background color
                                  borderRadius: BorderRadius.circular(
                                      8), // Optional: Add border radius
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('${widget.propo_heading}'),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Fabric:"),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(widget.fabric),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Embellishment:"),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(widget.embellishment),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Target Price:"),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(widget.Bid_target_price),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Quantity:"),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(widget.Bid_quantity),
                                )),
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
                                      openFiles();
                                    },
                                    child: Text("Select Files"),
                                  ),
                                  Divider(),
                                  Text("Picked Files:"),
                                  Divider(),
//                                   fileName != null
//                                       ? Wrap(
//   children: [
//     Container(
//       margin: EdgeInsets.all(8.0),
//       child: Card(
//         child: Container(
//           height: 100,
//           width: 100,
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.insert_drive_file),
//               SizedBox(height: 8.0),
//               // Text(
//               //   fileName,
//               //   maxLines: 2,
//               //   overflow: TextOverflow.ellipsis,
//               //   textAlign: TextAlign.center,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ],
// )
                                  // : Container(),
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
                        onPressed: _submitForm,
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

  Future<void> _submitForm() async {
    CollectionReference orderCollection =
        FirebaseFirestore.instance.collection('order_details');

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;

    for (int i = 0; i < _formFieldsList.length; i++) {
      // String articleStyle = _formFieldsList[i]['articleStyle'];
      // String fabric = _formFieldsList[i]['fabric'];
      // String embellishment = _formFieldsList[i]['embellishment'];
      // String targetPrice = _formFieldsList[i]['targetPrice'];
      // String quantity = _formFieldsList[i]['quantity'];
      String size = _formFieldsList[i]['size'].join(', ');

      // Use the file URL obtained during file upload
      // String fileUrl = /* Obtain the file URL from the upload process */;

      // Create a document with a unique ID
      DocumentReference docRef = await orderCollection.add({
        'articleStyle': widget.propo_heading,
        'fabric': widget.fabric ,
        'embellishment': widget.embellishment,
        'targetPrice': widget.Bid_target_price,
        'biding_id': widget.biding_id,
        'quantity': widget.Bid_quantity,
        'size': size,
        'c_user_id': userId,
        'order_status': 1,
        //'order_files': fileUrl,
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
  }
}
