import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slap_me/models/message.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Sign in
  Future<UserCredential> signInwithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
          await AuthService.updateUserData({
            "lastActive":Timestamp.now(),
            
          });
      //add user if doesnt already exists
      _firestore.collection('users').doc(userCredential.user!.uid).set(
          {"uid": userCredential.user!.uid, "email": email},
          SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//Sign Up
  Future<UserCredential> signUpwithEmailPassword(
      String email, String password, String firstname, String lastname) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

//after signup create new collection for chat
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "name": firstname,
        "email": email,
        "image": "",
        "lastActive": Timestamp.now(),
        "isOnline": true
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

//add text message
  static Future<void> addTextMessage({
    required String content,
    required String recieverId,
  }) async {
    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverId: recieverId,
        content: content,
        sentTime: Timestamp.now(),
        messageType: MessageType.text);
    await _addMsgtoChat(recieverId, message);
  }

  static Future<void> _addMsgtoChat(
    String recieverId,
    Message message,
  ) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chat")
        .doc(recieverId)
        .collection("messages")
        .add(message.toJson());
    await _firestore
        .collection("users")
        .doc(recieverId)
        .collection("chat")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages")
        .add(message.toJson());
  }

  //add image message
  static Future<void> addImageMessage({
    required String file,
    required String recieverId,
  }) async {
    print(file);
    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverId: recieverId,
        content: file,
        sentTime: Timestamp.now(),
        messageType: MessageType.image);

    await _addMsgtoChat(recieverId, message);
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).update(data);
}
