import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen(
      {Key? key, required this.v_user_id, required this.v_store_name})
      : super(key: key);

  final String v_user_id;
  final String v_store_name;

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
 List<File?> _pickedFiles = [];
  var size;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _pickedFiles = result.files.map((file) => File(file.path!)).toList();
      });
    }
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  // productTitle = value;
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
                                  // productTitle = value;
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
                                  // productTitle = value;
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
                                  // productTitle = value;
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
                                  // productTitle = value;
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
                                print(values);
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
                             ElevatedButton(
                      onPressed: _pickFiles,
                      child: Text('Pick Files'),
                    ),
                    SizedBox(height: 10),
                    if (_pickedFiles.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Picked Files:'),
                          for (File? file in _pickedFiles)
                            if (file != null) Text(file.path),
                        ],
                      ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
