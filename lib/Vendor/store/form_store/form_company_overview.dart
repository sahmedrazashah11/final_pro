import 'dart:io';
import 'dart:typed_data';

import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_pro/Models/VendorModels/model_form_company_overview.dart';
import 'package:final_pro/Vendor/Vendor_home_screen.dart';
import 'package:final_pro/Vendor/store/create_store_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/pickImage.dart';

class FormCompanyOverview extends StatefulWidget {
  const FormCompanyOverview({super.key});

  @override
  State<FormCompanyOverview> createState() => _FormCompanyOverviewState();
}

class _FormCompanyOverviewState extends State<FormCompanyOverview> {
  bool _loading = false;

  Uint8List? imageCertification;
  Uint8List? imageProductCertification;
  Uint8List? imagePatents;
  Uint8List? imageTrademark;

  String companyName = "";
  String businessType = "";
  String mainProducts = "";
  String totalEmployee = "";
  String totalAnnualRevenue = "";
  String yearEstablished = "";
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  final _formKey = GlobalKey<FormState>();

  final ImagePicker companyImages = ImagePicker();
  List<XFile>? imagefiles;

  CompanyImages() async {
    try {
      var pickedfiles = await companyImages.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void _SelectImageCertification() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      imageCertification = img;
    });
  }

  void _SelectImageProductCertification() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      imageProductCertification = img;
    });
  }

  void _Select_imagePatents() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      imagePatents = img;
    });
  }

  void _SelectImageTrademark() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      imageTrademark = img;
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
                  // Background Image
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Form Company OverView",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Company Name"),
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

                                hintText: "ABC industry",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  companyName = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your companyName!");
                                }
                                return null;
                                // reg expression
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Country/Region"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: CSCPicker(
                                onCountryChanged: (value) {
                                  setState(() {
                                    countryValue = value;
                                  });
                                },
                                onStateChanged: (value) {
                                  setState(() {
                                    // Check if value is not null before using it
                                    if (value != null) {
                                      stateValue = value;
                                    }
                                  });
                                },
                                onCityChanged: (value) {
                                  setState(() {
                                    // Check if value is not null before using it
                                    if (value != null) {
                                      cityValue = value;
                                    }
                                  });

                                  print("Country Name " +
                                      countryValue +
                                      "State " +
                                      stateValue +
                                      "City " +
                                      cityValue);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                          "Business type",
                                          textAlign: TextAlign.left,
                                        ),
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
                                            fillColor: Color.fromARGB(
                                                68, 217, 216, 218),
                                            // border: UnderlineInputBorder(),

                                            hintText: "Custom manufacturer",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              businessType = value;
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
                                          "Main Products",
                                          textAlign: TextAlign.left,
                                        ),
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
                                            fillColor: Color.fromARGB(
                                                68, 217, 216, 218),
                                            // border: UnderlineInputBorder(),

                                            hintText: "Men’s Shirt",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              mainProducts = value;
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                          "Total employees",
                                          textAlign: TextAlign.left,
                                        ),
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
                                            fillColor: Color.fromARGB(
                                                68, 217, 216, 218),
                                            // border: UnderlineInputBorder(),

                                            hintText: "200",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              totalEmployee = value;
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
                                          "Total Annual Revenue",
                                          textAlign: TextAlign.left,
                                        ),
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
                                            fillColor: Color.fromARGB(
                                                68, 217, 216, 218),
                                            // border: UnderlineInputBorder(),

                                            hintText: "9999",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              totalAnnualRevenue = value;
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                          "Year established",
                                          textAlign: TextAlign.left,
                                        ),
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
                                            fillColor: Color.fromARGB(
                                                68, 217, 216, 218),
                                            // border: UnderlineInputBorder(),

                                            hintText: "1998",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              yearEstablished = value;
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Company Album"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        CompanyImages();
                                      },
                                      child: Text("Select Images")),
                                  Divider(),
                                  Text("Picked Files:"),
                                  Divider(),
                                  imagefiles != null
                                      ? Wrap(
                                          children: imagefiles!.map((imageone) {
                                            return Container(
                                                child: Card(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                child: Image.file(
                                                    File(imageone.path)),
                                              ),
                                            ));
                                          }).toList(),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Certifications"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _SelectImageCertification();
                                },
                                child: Text("Select Images")),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  imageCertification != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      imageCertification!))),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              "https://icons.veryicon.com/png/o/miscellaneous/user-interface-flat-multicolor/5725-select-image.png"),
                                        )
                                  // _image != null
                                  //     ? CircleAvatar(
                                  //         backgroundImage: MemoryImage(_image!),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         backgroundImage: NetworkImage(
                                  //             "assets/images/user_logo.png"),
                                  //       ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Product Certifications"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _SelectImageProductCertification();
                                },
                                child: Text("Select Images")),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  imageProductCertification != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      imageProductCertification!))),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              "https://icons.veryicon.com/png/o/miscellaneous/user-interface-flat-multicolor/5725-select-image.png"),
                                        )
                                  // _image != null
                                  //     ? CircleAvatar(
                                  //         backgroundImage: MemoryImage(_image!),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         backgroundImage: NetworkImage(
                                  //             "assets/images/user_logo.png"),
                                  //       ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Patents"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _Select_imagePatents();
                                },
                                child: Text("Select Images")),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  imagePatents != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      imagePatents!))),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              "https://icons.veryicon.com/png/o/miscellaneous/user-interface-flat-multicolor/5725-select-image.png"),
                                        )
                                  // _image != null
                                  //     ? CircleAvatar(
                                  //         backgroundImage: MemoryImage(_image!),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         backgroundImage: NetworkImage(
                                  //             "assets/images/user_logo.png"),
                                  //       ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Trademarks"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _SelectImageTrademark();
                                },
                                child: Text("Select Images")),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  imageTrademark != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      imageTrademark!))),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              "https://icons.veryicon.com/png/o/miscellaneous/user-interface-flat-multicolor/5725-select-image.png"),
                                        )
                                  // _image != null
                                  //     ? CircleAvatar(
                                  //         backgroundImage: MemoryImage(_image!),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         backgroundImage: NetworkImage(
                                  //             "assets/images/user_logo.png"),
                                  //       ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  SaveCompanyOverview();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 48, 93, 242))),
                                child: const Text('Click')),
                            const SizedBox(
                              height: 8,
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
        ));
  }

  void SaveCompanyOverview() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;
    String CompanyData = await ModelCompanyOv().SaveCompanyOverveiw(
        companyName: companyName,
        businessType: businessType,
        mainProducts: mainProducts,
        totalEmployee: totalEmployee,
        totalAnnualRevenue: totalAnnualRevenue,
        yearEstablished: yearEstablished,
        countryValue: countryValue,
        stateValue: stateValue,
        cityValue: cityValue,
        v_user_id: userId,
        imageCompanyImage: imagefiles ?? [],
        imageCertification: imageCertification!,
        imageProductCertification: imageProductCertification!,
        imagePatents: imagePatents!,
        imageTrademark: imageTrademark!);
    setState(() {
      _loading = true;
    });
    Fluttertoast.showToast(msg: "Data Save");
    Get.snackbar("Dear Vendor", "Company Overview Added");
    Get.to(CreateStore());
  }
}
