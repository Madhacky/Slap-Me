import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:slap_me/providers/Login_Or_Register.dart';
import 'package:slap_me/views/chatusers.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        Future.delayed(Duration(milliseconds: 100), () {
  // Do something
});
        
        if(snapshot.hasData){
          return ChatUsers();
      }else if(snapshot.connectionState==ConnectionState.waiting){
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Center(child: Lottie.asset('assets/logo/icon.json'),),);
      }
        
        else{
          return LoginOrRegister();
        }
      },),
    );
  }
}