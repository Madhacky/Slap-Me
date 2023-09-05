import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slap_me/models/user.dart';
import 'package:slap_me/providers/authservice.dart';
import 'package:slap_me/providers/firebase_provider.dart';
import 'package:slap_me/views/widgets/chatTextField.dart';
import 'package:slap_me/views/widgets/chatmessages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});
  final String userId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement r
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AuthService.updateUserData({
          "lastActive": Timestamp.now(),
          "isOnline": true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        AuthService.updateUserData({
          "isOnline": false,
        });
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(recieverId: widget.userId),
            ChatTextField(recieverId: widget.userId)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return value.user != null
              ? Row(
                  children: [
                    value.user!.image == ""
                        ? CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue.shade200,
                            child: const Icon(Icons.person),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(value.user!.image),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          value.user!.name,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          value.user!.isOnline ? "Online" : "Offline",
                          style: TextStyle(
                              fontSize: 14,
                              color: value.user!.isOnline
                                  ? Colors.green
                                  : Colors.grey),
                        )
                      ],
                    )
                  ],
                )
              : const SizedBox();
        }),
      );
}
