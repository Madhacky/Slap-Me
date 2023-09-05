import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:slap_me/models/message.dart';
import 'package:slap_me/models/user.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserModel> users = [];
  UserModel? user;
  List<Message> messages = [];
  ScrollController scrollcontroller=ScrollController();
  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection("users")
        .orderBy("lastActive", descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }

  //get user by id
  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  //get messages
  List<Message> getMessages(String recieverId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chat")
        .doc(recieverId)
        .collection("messages").orderBy("sentTime",descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();
      scrolldown();
    });
    return messages;
  }


  void scrolldown(){
    WidgetsBinding.instance.addPostFrameCallback((_) { 
if(scrollcontroller.hasClients){
  scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
}

    });
  }
}
