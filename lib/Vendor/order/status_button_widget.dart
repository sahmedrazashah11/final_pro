import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusButtonWidget extends StatefulWidget {
  final int currentStatus;
  final String order_id;
  final Function(int, String) onStatusChanged;

  StatusButtonWidget({
    required this.currentStatus,
    required this.order_id,
    required this.onStatusChanged,
  });

  @override
  _StatusButtonWidgetState createState() => _StatusButtonWidgetState();
}

class _StatusButtonWidgetState extends State<StatusButtonWidget> {
  late int _currentStatus;
  late List<String> _statusTexts;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.currentStatus;
    _statusTexts = [
      "Order Pending",
      "Order Accept",
      "In Process",
      "Waiting Payment",
      "Shipment",
      "Order Complete",
    ];
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _currentStatus = (_currentStatus % 6) + 1;
        });

        try {
          CollectionReference orderDetailsCollection =
              FirebaseFirestore.instance.collection('order_details');

          await orderDetailsCollection.doc(widget.order_id).update({
            'order_status': _currentStatus,
          });

          widget.onStatusChanged(_currentStatus, widget.order_id);

          // Check if the current status is "Order Accept" and show a dialog box
          if (_statusTexts[_currentStatus - 1] == "Order Accept") {
            showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Dialog Title'),
            content: Container(
              height: 300,
              child: ListView(
                children: [
                   Text(
                  "This Digital Agreement (Agreement) is entered into by and between [Client's Name], hereinafter referred to as the Client, and [Vendor's Name], hereinafter referred to as the Vendor, collectively referred to as the \"Parties.\"\n\n"
                          "1. Scope of Work:\n"
                          "1.1 The Vendor agrees to provide the products/services specified in the order placed by the Client through the [Your App Name] platform.\n"
                          "1.2 The Client agrees to pay the agreed-upon amount for the products/services as specified in the order.\n\n"
                          "2. Delivery and Acceptance:\n"
                          "2.1 The Vendor agrees to deliver the products/services within the agreed-upon timeframe and meeting the specifications outlined in the order.\n"
                          "2.2 The Client agrees to inspect and accept the delivered products/services promptly upon receipt.\n\n"
                          "3. Payment:\n"
                          "3.1 The Client agrees to make payments through the Stitch Vision platform using the specified payment method.\n"
                          "3.2 The Vendor agrees to receive payments through the Stitch Vision platform as per the agreed-upon terms.\n\n"
                          "4. Changes and Cancellations:\n"
                          "4.1 Changes to the order or cancellations must be requested by the Client within a reasonable time frame and are subject to Vendor approval.\n"
                          "4.2 The Vendor may charge fees for changes or cancellations, as outlined in their policies.\n\n"
                          "5. Quality Assurance:\n"
                          "5.1 The Vendor warrants the quality and authenticity of the products/services provided.\n"
                          "5.2 The Client has the right to provide feedback and ratings based on their experience.\n\n"
                          "6. Confidentiality:\n"
                          "6.1 Both Parties agree to keep any confidential information obtained during the course of this agreement confidential and not disclose it to third parties.\n\n"
                          "7. Dispute Resolution:\n"
                          "7.1 In the event of disputes, the Parties agree to attempt resolution through communication.\n"
                          "7.2 Unresolved disputes may be subject to mediation or legal action, as per the laws governing the agreement.\n\n"
                          "8. App Fees:\n"
                          "8.1 Both Parties acknowledge that the Stitch Vision platform may charge fees for its services, and these will be deducted as specified in the app's policies.\n\n"
                          "10. Termination:\n"
                          "10.1 Either Party may terminate this agreement with written notice if the other Party breaches a material term and fails to remedy the breach within a reasonable time.\n\n"
                          "11. Entire Agreement:\n"
                          "11.1 This Agreement constitutes the entire understanding between the Parties and supersedes any prior agreements or understandings, whether written or oral.\n\n"
                          "IN WITNESS WHEREOF, the Parties hereto have executed this Digital Agreement as of the Effective Date.\n\n",
                      //     "Client's Full Name" +
                      // widget.v_first_name +
                      // "\n\n"
                      //     "Vendor's Full Name" +
                      // widget.v_first_name +
                      // "\n\n",
                  style: TextStyle(fontSize: 16.0),
                ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'I agree to the terms and conditions.',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: isChecked
                    ? () {
                     // _submitForm();
                        // Perform action when the user agrees
                        Navigator.of(context).pop();
                        // Add your logic here
                      }
                    : null,
                child: Text('Agree'),
              ),
            ],
          );
        },
      );
    },
  );
          }
        } catch (e) {
          print("Error updating order status: $e");
        }
      },
      child: Text(_statusTexts[_currentStatus - 1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentStatus = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status Example'),
      ),
      body: Center(
        child: StatusButtonWidget(
          currentStatus: currentStatus,
          order_id: 'your_order_id', // Replace with your order ID
          onStatusChanged: (newStatus, orderId) {
            setState(() {
              currentStatus = newStatus;
            });

            print('Order ID: $orderId, New Status: $newStatus');
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
