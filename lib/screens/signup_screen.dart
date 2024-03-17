import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_pro/screens/login_screen.dart';
import 'package:final_pro/widgets/pickImage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScrennState();
}

class _SignUpScrennState extends State<SignUpScreen> {
  final List<String> items = ['Client', 'Vender'];
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullname = "";
  final auth = FirebaseAuth.instance;

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
  void selectImage() async {
    final firebaseStorage = FirebaseStorage.instance;

    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

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
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 200,
                        //height: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Full Name"),
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

                          hintText: "ABC",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fullname = value;
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true, //<-- SEE HERE
                          fillColor: Color.fromARGB(68, 217, 216, 218),
                          // border: UnderlineInputBorder(),

                          hintText: "********",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
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
                      const SizedBox(height: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Text(
                              'Select Type',
                              style: TextStyle(
                                  fontSize: 14,
                                  // color: Theme.of(context).hintColor,
                                  color: Colors.black),
                            ),
                            items: _addDividersAfterItems(items),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 140,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              customHeights: _getCustomItemsHeights(),
                            ),
                            iconStyleData: const IconStyleData(
                              openMenuIcon: Icon(Icons.arrow_drop_up),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signUp(email, password);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 48, 93, 242))),
                          child: const Text('SingUp')),
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
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? users = auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = users!.email;
    userModel.user_id = users.uid;
    userModel.fullname = fullname;
    userModel.password = password;
    userModel.user_image = 'file?.path';
    userModel.user_role = selectedValue;
    await firebaseFirestore
        .collection("users")
        .doc(users.uid)
        .set(userModel.toMap());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    Fluttertoast.showToast(msg: "ACCOUNT CREATED");
  }
}
