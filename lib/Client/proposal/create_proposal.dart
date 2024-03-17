import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_pro/Client/categories/apparel/apparel_screen.dart';
import 'package:final_pro/Client/order/firebase_api.dart';
import 'package:final_pro/Models/VendorModels/model_form_company_overview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreateProposalScreen extends StatefulWidget {
  const CreateProposalScreen({super.key});

  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String businesstype = "";
  String propo_heading = "";
  String embellishment = "";
  String fabric = "";
  String target_price = "";
  String quantity = "";
  String description = "";
  String estimated_date = "";
  String propo_id = Uuid().v4();
  Uint8List? fileBytes;
  UploadTask? task;
  File? file;
  late String fileName = '';
  DateTime currentDate = DateTime.now(); // Store the current date
  DateTime currenttime = DateTime.now(); // Store the current date
  DateTime selectedDate = DateTime.now(); // Store the selected date
  late SingleValueDropDownController _cnt;
  // late firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  late firebase_storage.FirebaseStorage storage;
  late FilePickerResult? pickedFile;
  late PlatformFile? selectedFile;
  @override
  void initState() {
    storage = firebase_storage.FirebaseStorage.instance;
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2055, 12, 31),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        estimated_date = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Heading:"),
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

                        hintText: "Garments Pants",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        setState(() {
                          propo_heading = value;
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Business type",
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropDownTextField(
                      controller: _cnt,
                      clearOption: true,
                      searchDecoration: const InputDecoration(
                          hintText: "enter your custom hint text here"),
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Apparels', value: "Apparels"),
                        DropDownValueModel(
                          name: 'Yarn',
                          value: "Yarn",
                        ),
                        DropDownValueModel(
                          name: 'Fabrics',
                          value: "Fabrics",
                        ),
                        DropDownValueModel(
                          name: 'Trims',
                          value: "Trims",
                        ),
                      ],
                      onChanged: (value) {
                        DropDownValueModel selectedValue =
                            value as DropDownValueModel;

                        // Update the selected value
                        businesstype = selectedValue.value;

                        // Print the selected value
                        print("Selected Vendor Type: $businesstype");
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
                        hintText: "98",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        setState(() {
                          target_price = value;
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

                        hintText: "",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        setState(() {
                          quantity = value;
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
                          embellishment = value;
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

                        hintText: "100% Cotton",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        setState(() {
                          fabric = value;
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
                    const Text("Description:"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null, // Allows multiline input
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(68, 217, 216, 218),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                      onChanged: (value) {
                        // Handle onChanged event
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Description!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text("Estimated Date: "),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
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
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.insert_drive_file),
                                              SizedBox(height: 8.0),
                                              Text(
                                                fileName,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
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
                    ElevatedButton(
                      onPressed: () {
                        SaveProposal();
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  void SaveProposal() async {
    print('savedata');
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String clientID = user!.uid;
    String filePath = '';
    String downloadURL = ''; // Declare the variable here

    // Use the file URL obtained during file upload
    // String fileUrl = /* Obtain the file URL from the upload process */;
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'proposals/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    await firestore.collection('proposal/').add({
      'businesstype': businesstype,
      'c_user_id': clientID,
      'propo_heading': propo_heading,
      'fabric': fabric,
      'embellishment': embellishment,
      'target_price': target_price,
      'quantity': quantity,
      'description': description,
      'order_files': urlDownload,
      'proposal_status': '1',
      'v_user_id': '',
      'propo_offers': '',
      "propo_id": propo_id,
      'estimated_date': estimated_date, // Use selected date
      'date': DateFormat('yyyy-MM-dd').format(currentDate), // Use current date
      'time': DateFormat('HH:mm').format(currentDate), // Use current time
      // 'file_path': filePath, // Save the file path in Firestore
      // 'file_url': downloadURL, // Save the file URL in Firestore
    });

    setState(() {
      _loading = true;
    });

    Fluttertoast.showToast(msg: "Proposal Created");
    Get.to(ApparelScreen);
  }
}
