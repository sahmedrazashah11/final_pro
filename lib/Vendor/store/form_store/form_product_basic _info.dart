import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_pro/Models/VendorModels/model_form_pro_basic_info.dart';
import 'package:final_pro/Vendor/store/view_store/vendor_view_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import '../../../widgets/pickImage.dart';

class FormProductBasicInfo extends StatefulWidget {
  const FormProductBasicInfo({super.key});

  @override
  State<FormProductBasicInfo> createState() => _FormProductBasicInfoState();
}

class _FormProductBasicInfoState extends State<FormProductBasicInfo> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  Uint8List? bannerImage;
  void selectImage() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      bannerImage = img;
    });
  }

  Uint8List? ProductsImage;
  void selectProductsImage() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      ProductsImage = img;
    });
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
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

  var productTitle;
  //RangeValues priceRange = RangeValues(10, 100);
  RangeValues minOrder = RangeValues(10, 100);

  var productType;
  var size;
  var priceRange;
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
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Product Basic Info",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  bannerImage != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      bannerImage!))),
                                        )
                                      : Container(
                                          child: Image.network(
                                              "https://as2.ftcdn.net/v2/jpg/04/28/76/95/1000_F_428769564_NB2T4JM9E2xsxFdXXwqW717HwgaZdpAq.jpg"),
                                        )
                                ],
                              ),
                            ),
                            const Text("Product Title"),
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

                                hintText: "Half Polo T-Shirt",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  productTitle = value;
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
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "Price Range",
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
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(68, 217, 216, 218),
                                          hintText: "10 - 40",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            priceRange = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please Enter Your Email!");
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "Min Order",
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            '',
                                            textAlign: TextAlign.left,
                                          ),
                                          RangeSlider(
                                            values: minOrder,
                                            min: 0,
                                            max: 200,
                                            divisions: 20,
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                minOrder = values;
                                              });
                                            },
                                            labels: RangeLabels(
                                              'Min: ${minOrder.start.round()}',
                                              'Max: ${minOrder.end.round()}',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Selected Range: ${minOrder.start.round()} - ${minOrder.end.round()}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Add Product Types"),
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

                                hintText: "T-Shirt with Black and Blue Colors",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  productType = value;
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
                            const Text("Banner Image"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  selectImage();
                                },
                                child: Text("Select Image")),
                            const SizedBox(height: 10),
                            const Text("Selects Product"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        openImages();
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
                            ElevatedButton(
                                onPressed: () {
                                  print(priceRange);
                                  saveProBasicInfo();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 48, 93, 242))),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                )),
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

  void saveProBasicInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;
    print("user ID $userId");
    print("Images $bannerImage");
    // String prodata = await ModelProBaic().SaveData(
    //   productTitle: productTitle,
    //   priceRange: priceRange,
    //   minOrder: minOrder,
    //   productType: productType,
    //   size: size,
    //   v_user_id: userId,
    //   bannerImage: bannerImage!,
    //   imagefiles: imagefiles ?? [],
    // );
    print("user ID $userId");

    setState(() {
      _loading = true;
    });
    Fluttertoast.showToast(msg: "Product Upload");
    Get.to(VendorViewStore());
  }
}
