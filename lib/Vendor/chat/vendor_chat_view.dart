import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VendorChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String currentUserId;
  final String currentUserName;

  VendorChatScreen({
    required this.receiverId,
    required this.receiverName,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  _VendorChatScreenState createState() => _VendorChatScreenState();
}

class _VendorChatScreenState extends State<VendorChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
      ),
      body: ChatWidget(
        currentUserId: widget.currentUserId,
        receiverId: widget.receiverId,
        currentUserName: widget.currentUserName,
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  final String currentUserId;
  final String receiverId;
  final String currentUserName;
  final TextEditingController _messageController = TextEditingController();

  ChatWidget({
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(_getChatRoomId(currentUserId, receiverId))
                .collection('chats')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var messages = snapshot.data!.docs;
              List<Widget> messageWidgets = [];
              for (var message in messages) {
                var messageText = message['text'];
                var messageSender = message['sender'];

                var messageWidget =
                    MessageWidget(messageSender, messageText);
                messageWidgets.add(messageWidget);
              }

              return ListView(
                children: messageWidgets,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _sendMessage(currentUserName, receiverId);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage(String senderName, String receiverId) {
    if (_messageController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('messages')
          .doc(_getChatRoomId(senderName, receiverId))
          .collection('chats')
          .add({
        'text': _messageController.text,
        'sender': senderName,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  String _getChatRoomId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode ? '$user1-$user2' : '$user2-$user1';
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;

  MessageWidget(this.sender, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(sender[0]),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(text),
            ],
          ),
        ],
      ),
    );
  }
}
