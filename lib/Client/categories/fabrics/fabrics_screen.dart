import 'package:flutter/material.dart';
import 'package:final_pro/Client/categories/apparel/components/apparel_companies.dart';
import 'package:final_pro/Client/categories/apparel/components/display_store.dart';

class FabricsScreen extends StatefulWidget {
  const FabricsScreen({super.key});

  @override
  State<FabricsScreen> createState() => _FabricsScreenState();
}

class _FabricsScreenState extends State<FabricsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apparel'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Row(
                children: [
                  Text(
                    "Apparel Vendors",
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromARGB(170, 0, 0, 0),
            ),
            WidgetVendorsStores(),
          ],
        ),
      ),
    );
  }
}
