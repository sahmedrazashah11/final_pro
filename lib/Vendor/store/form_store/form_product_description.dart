import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_pro/Models/VendorModels/model_form_product_description.dart';
import 'package:final_pro/Models/saveDataFireStroe.dart';
import 'package:final_pro/Vendor/store/view_store/vendor_view_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FormProductDescription extends StatefulWidget {
  const FormProductDescription({super.key});

  @override
  State<FormProductDescription> createState() => _FormProductDescription();
}

class _FormProductDescription extends State<FormProductDescription> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;

  // Fields Variables
  String printingMethods = "";
  String brandName = "";
  String productFeature = "";
  String modelNumber = "";
  String collar = "";
  String fabricWeight = "";
  String avalibleQuantity = "";
  String material = "";
  String technics = "";
  String sleeveStyle = "";
  String gender = "";
  String design = "";
  String patternType = "";
  String style = "";
  String fabricType = "";
  String weavingMethod = "";
  String sampleLead = "";
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
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
                              "Form Product Description",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Printing Methods"),
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

                                hintText: "Heat-transfer Printing",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  printingMethods = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your printingMethods!");
                                }
                                return null;
                                // reg expression
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Place of Origin"),
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
                              height: 15,
                            ),
                            const Text("Brand Name"),
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

                                hintText: "TOMY",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  brandName = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your brandName!");
                                }
                                return null;
                                // reg expression
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Feature"),
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

                                hintText:
                                    "Anti-wrinkle, QUICK DRY, Compressed, Sustainable, Plus Size",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  productFeature = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your productFeature!");
                                }
                                return null;
                                // reg expression
                              },
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
                                          "Model Number",
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

                                            hintText: "R23 H",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              modelNumber = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Your modelNumber!");
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
                                          "Collar",
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

                                            hintText: "O-Neck",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              collar = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Your collar!");
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
                                          "Fabric Weight",
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

                                            hintText: "200 Grams",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              fabricWeight = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Your fabricWeight!");
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
                                          "Available Quantity:",
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
                                              avalibleQuantity = value;
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
                                          "Material",
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

                                            hintText: r"100% Cotton",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              material = value;
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
                                          "Technics",
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

                                            hintText: "Printed",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              technics = value;
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
                                          "Sleeve Style",
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

                                            hintText: "Short sleeve",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              sleeveStyle = value;
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
                                          "Gender",
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropDownTextField(
                                          controller: _cnt,
                                          clearOption: true,
                                          searchDecoration: const InputDecoration(
                                              hintText:
                                                  "enter your custom hint text here"),
                                          validator: (value) {
                                            if (value == null) {
                                              return "Required field";
                                            } else {
                                              return null;
                                            }
                                          },
                                          dropDownItemCount: 6,
                                          dropDownList: const [
                                            DropDownValueModel(
                                                name: 'Male', value: "Male"),
                                            DropDownValueModel(
                                              name: 'Female',
                                              value: "Female",
                                            ),
                                          ],
                                          onChanged: (value) {
                                            DropDownValueModel selectedValue =
                                                value as DropDownValueModel;

                                            // Update the selected value
                                            gender = selectedValue.value;

                                            // Print the selected value
                                            print(
                                                "Selected Vendor Type: $gender");
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
                                          "Design",
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

                                            hintText: r"Blank",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              design = value;
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
                                          "Pattern Type",
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

                                            hintText: "Solid",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              patternType = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Your patternType!");
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
                                          "Style",
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

                                            hintText: r"Vintage",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              style = value;
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
                                          "Fabric Type",
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

                                            hintText: "woven",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              fabricType = value;
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
                                          "Weaving method",
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

                                            hintText: "knitted",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              weavingMethod = value;
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
                                          "7 days sample order lead time",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropDownTextField(
                                          controller: _cnt,
                                          clearOption: true,
                                          searchDecoration: const InputDecoration(
                                              hintText:
                                                  "enter your custom hint text here"),
                                          validator: (value) {
                                            if (value == null) {
                                              return "Required field";
                                            } else {
                                              return null;
                                            }
                                          },
                                          dropDownItemCount: 6,
                                          dropDownList: const [
                                            DropDownValueModel(
                                                name: 'Support',
                                                value: "Support"),
                                            DropDownValueModel(
                                              name: 'Not Support',
                                              value: "Not Support",
                                            ),
                                          ],
                                          onChanged: (val) {
                                            sampleLead = val;
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
                            ElevatedButton(
                                onPressed: () {
                                  print("form Product" +
                                      printingMethods +
                                      countryValue);
                                  saveProDes();
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

  void saveProDes() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;
    print("user ID $userId");
    String proDec = await ModelProductDescription().SaveData(
        printingMethods: printingMethods,
        brandName: brandName,
        productFeature: productFeature,
        modelNumber: modelNumber,
        collar: collar,
        fabricWeight: fabricWeight,
        avalibleQuantity: avalibleQuantity,
        material: material,
        technics: technics,
        sleeveStyle: sleeveStyle,
        gender: gender,
        design: design,
        patternType: patternType,
        style: style,
        fabricType: fabricType,
        weavingMethod: weavingMethod,
        sampleLead: sampleLead,
        countryValue: countryValue,
        stateValue: stateValue,
        cityValue: cityValue,
        address: address,
        v_user_id: userId);
    print("user ID $userId");

    setState(() {
      _loading = true;
    });
    Fluttertoast.showToast(msg: "Product description Save");
    Get.to(VendorViewStore());
  }
}
