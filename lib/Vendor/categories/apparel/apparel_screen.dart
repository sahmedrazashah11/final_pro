import 'package:flutter/material.dart';
import 'package:final_pro/Client/categories/apparel/components/apparel_companies.dart';

class ApparelScreen extends StatefulWidget {
  const ApparelScreen({super.key});

  @override
  State<ApparelScreen> createState() => _ApparelScreenState();
}

class _ApparelScreenState extends State<ApparelScreen> {
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
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Row(
              children: [
                Text(
                  "Apparel",
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
          const ApparelCompanies()
        ],
      ),
    );
  }
}
