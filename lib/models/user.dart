import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final Timestamp lastActive;
  final bool isOnline;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.lastActive,
    required this.isOnline,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      image: json["image"],
      lastActive: json["lastActive"],
      isOnline: json["isOnline"]
      );


       Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['lastActive'] = this.lastActive;
    data['isOnline'] = this.isOnline;

    return data;
  }
}
