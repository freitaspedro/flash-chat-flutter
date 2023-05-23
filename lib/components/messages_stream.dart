import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {

  final FirebaseFirestore instance;

  MessagesStream({this.instance});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: instance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        print('snapshot.hasData ${snapshot.hasData}');
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        snapshot.data.docs.forEach((message) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          print('$messageText from $messageSender');
          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText
          );
          messageBubbles.add(messageBubble);
        });
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}