import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slap_me/models/message.dart';
import 'package:slap_me/providers/authservice.dart';
import 'package:slap_me/views/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class ChatTextField extends StatefulWidget {
  final String recieverId;
  const ChatTextField({super.key, required this.recieverId});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Message...",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(
                        color: Colors.white,
                      )),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: mainColor,
            radius: 20,
            child: IconButton(
              onPressed: () => sendText(context),
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: mainColor,
            radius: 20,
            child: IconButton(
              onPressed:()=> sendImage(),
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> sendText(BuildContext context) async {
    if (textEditingController.text.isNotEmpty) {
      await AuthService.addTextMessage(
          content: textEditingController.text, recieverId: widget.recieverId);
          textEditingController.clear();
          FocusScope.of(context).unfocus();
    }
              FocusScope.of(context).unfocus();
  }


  Future<void> sendImage() async {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

   
      if (pickedFile != null) {
        setState(() {
             _photo = File(pickedFile.path);
        });
     
      if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
var dowurl = await ref.getDownloadURL();
         AuthService.addImageMessage(recieverId:widget.recieverId,file:dowurl);
    } catch (e) {
      print('error occured');
    }
      } else {
        print('No image selected.');
      }

}
}
