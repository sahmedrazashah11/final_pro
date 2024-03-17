import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Client/order/orderBiding.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:uuid/uuid.dart';

class BiderShowScreen extends StatefulWidget {
  const BiderShowScreen({
    Key? key,
    required this.propoId,
  }) : super(key: key);

  final String propoId;
  @override
  State<BiderShowScreen> createState() => _ShowBiderScreenState();
}

class _ShowBiderScreenState extends State<BiderShowScreen> {
  late Future<List<Map<String, dynamic>>> _dataList;

  Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();
    // Fetch data from Firebase using propoId
    _dataList = fetchData();
  }

// Use this function to generate a unique ID
  String generateUniqueId() {
    return uuid.v4();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('biding')
        .where('propo_id', isEqualTo: widget.propoId)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bider Show Screen')),
      body: FutureBuilder(
        future: _dataList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            return HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: 700,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              isFixedFooter: true,
              footerWidgets: _getTitleWidget(),
              leftSideItemBuilder: (context, index) =>
                  _generateFirstColumnRow(dataList, index),
              rightSideItemBuilder: (context, index) =>
                  _generateRightHandSideColumnRow(dataList, index),
              itemCount: dataList.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black38,
                height: 1.0,
                thickness: 0.0,
              ),
              leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              itemExtent: 55,
            );
          }
        },
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Name', 100),
      _getTitleItemWidget('Target Price', 100),
      _getTitleItemWidget('Quantity', 100),
      _getTitleItemWidget('Estimated Date', 100),
      _getTitleItemWidget('Country', 100),
      _getTitleItemWidget('City', 100),
      _getTitleItemWidget('Description', 100),
      _getTitleItemWidget('Order', 100),
      // Add more titles as needed for other fields
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(
      List<Map<String, dynamic>> dataList, int index) {
    Map<String, dynamic> data = dataList[index];
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['v_store_name'] ?? ''),
        ),
        // Add more containers as needed for other fields
      ],
    );
  }

  Widget _generateRightHandSideColumnRow(
      List<Map<String, dynamic>> dataList, int index) {
    Map<String, dynamic> data = dataList[index];
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['Bid_target_price'] ?? ''),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['Bid_quantity'] ?? ''),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['Bid_selectedDate'] ?? ''),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['v_store_country'] ?? ''),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(data['v_store_city'] ?? ''),
        ),

        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDescriptionDialog(
                      context, data['Bid_description'] ?? '');
                },
                child: Text('Show'),
              ),
            ],
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.amber, // Change this to the desired color
                ),
                onPressed: () {
                  String orderId = generateUniqueId();

                  // Navigate to the order form screen with the selected user's ID and the generated order ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BidingDynamicForm(
                        v_user_id: data['v_user_id'],
                        v_store_name: data['v_store_name'],
                        v_first_name: data['v_store_name'],
                        v_store_country: data['v_store_country'],
                        v_store_city: data['v_store_city'],
                        Bid_quantity: data['Bid_quantity'],
                        biding_id: data['biding_id'],
                        propo_heading: data['propo_heading'],
                        Bid_target_price: data['Bid_target_price'],
                        embellishment: data['embellishment'],
                        fabric: data['fabric'],

                        orderId: orderId, // Pass the generated order ID
                      ),
                    ),
                  );
                },
                child: Text('Order'),
              ),
            ],
          ),
        ),
        // Container(
        //   width: 100,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.center,
        //   child: ElevatedButton(
        //     child:
        //         Text("Order now".toUpperCase(), style: TextStyle(fontSize: 12)),
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        //       backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero,
        //           side: BorderSide(color: Colors.red),
        //         ),
        //       ),
        //     ),
        //     onPressed: () {

        //     }, // Adjust this based on your actual field name
        //   ),
        // ),
        // Add more containers as needed for other fields
      ],
    );
  }

  void _showDescriptionDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Description'),
          content: SingleChildScrollView(
            child: Text(description),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
