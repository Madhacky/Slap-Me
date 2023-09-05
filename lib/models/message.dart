import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String content;
  final Timestamp sentTime;
  final MessageType messageType;

  const Message({
    required this.senderId,
    required this.recieverId,
    required this.content,
    required this.sentTime,
    required this.messageType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      senderId: json["senderId"],
      recieverId: json["recieverId"],
      content: json["content"],
      sentTime: json["sentTime"],
      messageType: json["messageType"]=='text'?MessageType.text:MessageType.image,
      
      );


  Map<String, dynamic> toJson() => {
        "recieverId": recieverId,
        "senderId": senderId,
        "sentTime": sentTime,
        "content": content,
        "messageType": messageType.toJson(),
      };
}

enum MessageType {
  text,
  image;

  String toJson() => name;
  MessageType fromJson()=>name as MessageType;
}
