import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class FormProductionCapacity extends StatefulWidget {
  const FormProductionCapacity({super.key});

  @override
  State<FormProductionCapacity> createState() => _FormProductionCapacityState();
}

class _FormProductionCapacityState extends State<FormProductionCapacity> {
  final _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;

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
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Form Production Capacity",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            //// Production Equipment
                            Container(
                              child: Column(
                                children: [
                                  const Text(
                                    "Production Equipment",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Cutting Machine",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "10",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Pneumatic Fusing",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "4",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // secondName = value;
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Machine",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "3",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Sewing Machine",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "120",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // secondName = value;
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Button Machine",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "10",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Ironing Machine",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "15",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // secondName = value;
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///   Factory Information
                            Container(
                              child: Column(
                                children: [
                                  const Text(
                                    "Factory Information",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Factory Size",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText:
                                                      "10,000-30,000 square meters",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Annual Output Value",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText:
                                                      r"US$10 Million - US$50 Million",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "No. of Production Lines",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText: "Above 10",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  firstName = value;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Contract Manufacturing",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText:
                                                      "OEM Service Offered, Design Service Offered, Buyer Label Offered",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // secondName = value;
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text(
                                                "Factory Country/Region",
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled: true, //<-- SEE HERE
                                                  fillColor: Color.fromARGB(
                                                      68, 217, 216, 218),
                                                  // border: UnderlineInputBorder(),

                                                  hintText:
                                                      "No. 3, Tianlao Road, Jishan Street, Yuecheng District, Shaoxing City, ZhejiangProvince, China",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // secondName = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please Enter Your Email!");
                                                  }
                                                  return null;
                                                  // reg expression
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 48, 93, 242))),
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
}
