import 'package:flutter/material.dart';

class ContactChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButton(Icons.mail_outline, Colors.blue),
          _buildButton(Icons.chat_bubble_outline, Colors.green),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        // Add your button action here
        print("button pressed!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(
        icon,
        weight: 10,
        color: Colors.white,
      ),
      label: Text(
        '',
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact and Chat Widget'),
        ),
        body: Center(
          child: ContactChatWidget(),
        ),
      ),
    ),
  );
}
