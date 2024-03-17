import 'dart:typed_data';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/screens/login_screen.dart';
import 'package:final_pro/widgets/pickImage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../Models/saveDataFireStroe.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

// import '../Models/user_model.dart';

class VenderSignUp extends StatefulWidget {
  const VenderSignUp({super.key});

  @override
  State<VenderSignUp> createState() => _SignUpScrennState();
}

class _SignUpScrennState extends State<VenderSignUp> {
  bool _loading = false;

  final List<String> items = ['Client', 'Vender'];
  String selectedValue = "";
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _obscureText = true;
  String firstName = "";
  String userType = "vendor";
  String secondName = "";
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String storeName = "";
  late PhoneNumber phoneNumber;
  String selectedVendorType = "";
  late SingleValueDropDownController venderType;
  @override
  void initState() {
    venderType = SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    venderType.dispose();
    super.dispose();
  }

  final auth = FirebaseAuth.instance;
  // final TextEditingController fullname = TextEditingController();
  // final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();
  // final TextEditingController phoneNumber = TextEditingController();
  // final TextEditingController selectedValue = TextEditingController();

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  Uint8List? _image;
  // Function to select image
  void selectImage() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print("image" '${file?.path}');
  }

  // Function to pick image
  Future<Uint8List> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return pickedFile.readAsBytes();
    } else {
      throw 'No image selected.';
    }
  }
  // void selectImage() async {
  //   final firebaseStorage = FirebaseStorage.instance;

  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  //   ImagePicker imagePicker = ImagePicker();
  //   // XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  //   XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  //   print("image" '${file?.path}');

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            // Background Image
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 200,
                        //height: 100,
                      ),

                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     _image != null
                      //         ? CircleAvatar(
                      //             radius: 60,
                      //             backgroundImage: MemoryImage(_image!),
                      //           )
                      //         : const CircleAvatar(
                      //             radius: 60,
                      //             backgroundImage: NetworkImage(
                      //                 "assets/images/user_logo.png"),
                      //           ),
                      //     Positioned(
                      //       bottom: -10,
                      //       child: IconButton(
                      //         onPressed: selectImage,
                      //         icon: const Icon(Icons.add_a_photo_outlined),
                      //         color: Colors.white,
                      //       ),
                      //       // right: -10,
                      //     )
                      //   ],
                      // ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      "assets/images/user_logo.png"),
                                ),
                          Positioned(
                            bottom: -10,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo_outlined),
                              color: Colors.white,
                            ),
                            // right: -10,
                          ),
                          if (_image ==
                              null) // Add this condition to display error message
                            Positioned(
                              top: 0,
                              child: Text(
                                'Please select an image',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "First Name",
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
                                      fillColor:
                                          Color.fromARGB(68, 217, 216, 218),
                                      // border: UnderlineInputBorder(),

                                      hintText: "Muhammad",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        firstName = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please Fill this Field!");
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Second Name",
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
                                      fillColor:
                                          Color.fromARGB(68, 217, 216, 218),
                                      // border: UnderlineInputBorder(),

                                      hintText: "Shah",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        secondName = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please Fill this Field!");
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

                      const Text("Email"),
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

                          hintText: "sv@gmail.com",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
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
                      const Text("Password"),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: const Color.fromARGB(68, 217, 216, 218),
                          hintText: "********",
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Fill this Field!");
                          }
                          return null;
                          // reg expression
                        },
                      ),
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     border: InputBorder.none,
                      //     focusedBorder: InputBorder.none,
                      //     enabledBorder: InputBorder.none,
                      //     errorBorder: InputBorder.none,
                      //     disabledBorder: InputBorder.none,
                      //     filled: true, //<-- SEE HERE
                      //     fillColor: Color.fromARGB(68, 217, 216, 218),
                      //     // border: UnderlineInputBorder(),

                      //     hintText: "********",
                      //     labelStyle: TextStyle(color: Colors.black),
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       password = value;
                      //     });
                      //   },
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return ("Please Enter Your Email!");
                      //     }
                      //     // reg expression
                      //   },
                      // ),

                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Store Name"),
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

                          hintText: "abc pvt ltd",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        onChanged: (value) {
                          setState(() {
                            storeName = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Fill this Field!");
                          }
                          return null;
                          // reg expression
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Where Should Your Store be hosted?"),
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
                      const Text(
                        "Industry Type",
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownTextField(
                          controller: venderType,
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
                            DropDownValueModel(
                                name: 'Apparel', value: "Apparel"),
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
                            // Convert the dynamic type to DropDownValueModel
                            DropDownValueModel selectedValue =
                                value as DropDownValueModel;

                            // Update the selected value
                            selectedVendorType = selectedValue.value;

                            // Print the selected value
                            print("Selected Vendor Type: $selectedVendorType");
                          }),

                      const SizedBox(height: 10),
                      const Text("Phone Number"),
                      const SizedBox(height: 10),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true, //<-- SEE HERE
                          fillColor: Color.fromARGB(68, 217, 216, 218),
                          // border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton2<String>(
                      //       isExpanded: true,
                      //       hint: Text(
                      //         'Select Type',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             // color: Theme.of(context).hintColor,
                      //             color: Colors.black),
                      //       ),
                      //       items: _addDividersAfterItems(items),
                      //       value: selectedValue,
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           selectedValue = value;
                      //         });
                      //       },
                      //       buttonStyleData: const ButtonStyleData(
                      //         padding: EdgeInsets.symmetric(horizontal: 16),
                      //         height: 40,
                      //         width: 140,
                      //       ),
                      //       dropdownStyleData: const DropdownStyleData(
                      //         maxHeight: 200,
                      //       ),
                      //       menuItemStyleData: MenuItemStyleData(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         customHeights: _getCustomItemsHeights(),
                      //       ),
                      //       iconStyleData: const IconStyleData(
                      //         openMenuIcon: Icon(Icons.arrow_drop_up),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      ElevatedButton(
                          onPressed: () {
                            print("hello");
                            signUp(email, password);
                            print(selectedValue);
                            // print("user " + email + " " + fullname);
                            // print("user " + selectedValue!);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 48, 93, 242))),
                          child: const Text(
                            'SingUp',
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have you already account?",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const LoginScreen());
                            },
                            child: const Text("Login",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.amber)),
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
    ));
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String userId = userCredential.user!.uid; // Get the user ID

        saveData(userId); // Pass the user ID to saveData
        print('signup');
      } catch (e) {
        Fluttertoast.showToast(msg: 'e');
      }
    }
  }

  void saveData(String vUserId) async {
    print('savedata');

    String resp = await SaveData().SaveDataImage(
      v_user_id: vUserId, // Pass the user ID here
      email: email,
      password: password,
      firstName: firstName,
      secondName: secondName,
      userType: userType,
      countryValue: countryValue,
      stateValue: stateValue,
      cityValue: cityValue,
      storeName: storeName,
      // phoneNumber: phoneNumber,
      selectedValue: selectedVendorType,
      file: _image!,
    );
    print(email);
    print(firstName);
    //print(phoneNumber);
    print(password);
    print(selectedValue);
    print(selectedVendorType);
    setState(() {
      _loading = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    Fluttertoast.showToast(msg: "ACCOUNT CREATED");
  }
}
