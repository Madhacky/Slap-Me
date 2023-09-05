import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slap_me/models/user.dart';
import 'package:slap_me/providers/authgate.dart';
import 'package:slap_me/providers/authservice.dart';
import 'package:slap_me/providers/firebase_provider.dart';
import 'package:slap_me/views/widgets/UserItem.dart';

class ChatUsers extends StatefulWidget {
  const ChatUsers({super.key});

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context,listen: false).getAllUsers();
    // TODO: implement initState
    super.initState();
  }
  // final userData = [
  //   UserModel(
  //       uid: "1",
  //       name: "Sami",
  //       email: "sami@gmail.com",
  //       image: "https://i.pravatar.cc/150?img=66",
  //       lastActive: Timestamp.now(),
  //       isOnline: true),
  //           UserModel(
  //       uid: "2",
  //       name: "mujeeb",
  //       email: "mujeeb@gmail.com",
  //       image: "https://i.pravatar.cc/150?img=67",
  //       lastActive: Timestamp.now(),
  //       isOnline: false),
  //           UserModel(
  //       uid: "3",
  //       name: "Shahjada",
  //       email: "Shahjada@gmail.com",
  //       image: "https://i.pravatar.cc/150?img=68",
  //       lastActive: Timestamp.now(),
  //       isOnline: true),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        actions: [Consumer<AuthService>(
          
          builder: (context,value,child) {
            return IconButton(onPressed: (){
              value.signOut();
            }, icon: Icon(Icons.logout));
          }
        )],
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context,value,child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14),
            separatorBuilder: (context,index)=>SizedBox(height: 7,),
            physics: BouncingScrollPhysics(),
            itemCount: value.users.length,
            itemBuilder: (context,index)=>
            value.users[index].uid!=FirebaseAuth.instance.currentUser!.uid?
            UserItem(user: value.users[index],):const SizedBox());
        }
      ),
    );
  }
}
