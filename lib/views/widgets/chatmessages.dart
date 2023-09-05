import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slap_me/models/message.dart';
import 'package:slap_me/providers/firebase_provider.dart';
import 'package:slap_me/views/widgets/MessageBubble.dart';

class ChatMessages extends StatelessWidget {
  final String recieverId;
  ChatMessages({super.key, required this.recieverId});
  //final messages = [
  //   Message(
  //       senderId: '1',
  //       recieverId: "Fb024xzXTtWXRLRRyCdGUFbdMSJ3",
  //       content: "hello",
  //       sentTime: Timestamp.now(),
  //       messageType: MessageType.text),
  //   Message(
  //       senderId: '1',
  //       recieverId: "Fb024xzXTtWXRLRRyCdGUFbdMSJ3",
  //       content: "hello",
  //       sentTime: Timestamp.now(),
  //       messageType: MessageType.text),
  //   Message(
  //       senderId: 'Fb024xzXTtWXRLRRyCdGUFbdMSJ3',
  //       recieverId: "1",
  //       content: "https://i.pravatar.cc/150?img=67",
  //       sentTime: Timestamp.now(),
  //       messageType: MessageType.image),
  //   Message(
  //       senderId: 'Fb024xzXTtWXRLRRyCdGUFbdMSJ3',
  //       recieverId: "1",
  //       content: "hello",
  //       sentTime: Timestamp.now(),
  //       messageType: MessageType.text),
  // ];
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.messages.isEmpty
            ? Expanded(
                child: Center(
                child: Text("Say Hello"),
              ))
            : Expanded(
              child: ListView.builder(
                controller: Provider.of<FirebaseProvider>(context,listen: false).scrollcontroller,
                  shrinkWrap: true,
                  itemCount:value.messages.length,
                  itemBuilder: (context, index) {
                    final isMe = recieverId != value.messages[index].senderId;
                    final isTextMsg =
                        value.messages[index].messageType == MessageType.text;
                    return isTextMsg
                        ? MessageBubble(
                            message: value.messages[index],
                            isMe: isMe,
                            isImage: false,
                          )
                        : MessageBubble(
                            message: value.messages[index],
                            isMe: isMe,
                            isImage: true,
                          );
                  },
                ),
            ));
  }
}
