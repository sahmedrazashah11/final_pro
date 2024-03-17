// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fyp_project/Vendor/chat/vendor_chat_view.dart';

// class _VendorChatScreenState extends State<VendorChatScreen> {
//   late User user;
//   final TextEditingController _messageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the current user when the widget is created
//     FirebaseAuth auth = FirebaseAuth.instance;
//     user = auth.currentUser!;
//   }

//   void _sendMessage() async {
//     String message = _messageController.text;
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user = auth.currentUser;
//     String senderId = user!.uid;

//     // Save the message to Firestore
//     await FirebaseFirestore.instance
//         .collection('messages')
//         .doc(widget.roomId)
//         .collection('messages')
//         .add({
//       'content': message,
//       'senderId': senderId,
//       'receiverId': widget.receiverId,
//       'receiverName': widget.receiverName,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     // Clear the message input
//     _messageController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.receiverName),
//       ),
//       body: Column(
//         children: [
//           // Display chat messages using a StreamBuilder
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('messages')
//                   .doc(widget.roomId)
//                   .collection('messages')
//                   .where('senderId', isEqualTo: widget.receiverId)
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }

//                 // Extract messages from the snapshot
//                 List<DocumentSnapshot> messages = snapshot.data!.docs;

//                 // Display the messages
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     Map<String, dynamic> messageData =
//                         messages[index].data() as Map<String, dynamic>;

//                     String content = messageData['content'];
//                     String senderId = messageData['senderId'];

//                     // Determine the alignment and color based on the sender
//                     Alignment alignment = senderId == user!.uid
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft;

//                     Color color =
//                         senderId == user!.uid ? Colors.blue : Colors.grey;

//                     return ListTile(
//                       title: Align(
//                         alignment: alignment,
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           margin: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: color,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             content,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           // Message input field and send button
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
