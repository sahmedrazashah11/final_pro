import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/Client/Client_home_screen.dart';
import 'package:final_pro/screens/Client%20Screen/client_Signup.dart';
import 'package:get/get.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({super.key});

  @override
  State<ClientLogin> createState() => _ClientLogin();
}

final _auth = FirebaseAuth.instance;

class _ClientLogin extends State<ClientLogin> {
  late String email;
  late String password;
  bool _obscureText = true;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Stack(
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
                      'assets/images/sv_logo.png',
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Client Login",
                      textAlign: TextAlign.center,
                    ),

                    // Email Field
                    const SizedBox(
                      height: 20,
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
                          return "Please Enter Your Password!";
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    // Animated Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: -10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CheckboxExample(),
                              Text(
                                "Remember me",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Forgot Password ?",
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          print("Logn");
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            print("Logn");
                            Get.to(const ClientHomeScreen());
                          } catch (e) {
                            print(e);
                          }
                          AlertDialog(
                            title: const Text("Login Successful"),
                            content:
                                const Text("You have successfully logged in!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                      const ClientHomeScreen()); // Close the dialog
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 48, 93, 242))),
                        child: const Text('Login')),
                    const SizedBox(height: 5),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/google_logo.png',
                        width: 40,
                        height: 40,
                      ),
                      label: const Text("Sign in with Google"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(122, 48, 93, 242))),
                      //borderRadius: BorderRadius.circular(25),
                    ),
                    const SizedBox(height: 5),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/facebook_logo.png',
                        width: 30,
                        height: 40,
                      ),
                      label: const Text("Sign in with Facebook"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(122, 48, 93, 242))),
                      //borderRadius: BorderRadius.circular(25),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You don't have an account yet?",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const ClientSignUp());
                          },
                          child: const Text("Sign up",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.amber)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.grey;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
