import 'package:flutter/material.dart';
import 'package:slap_me/views/Login%20SignUp/LoginPage.dart';
import 'package:slap_me/views/Login%20SignUp/RegisterPage.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially
  bool showloginpage=true;

  //toggle between sign in and signup page
  void togglepages(){
    setState(() {
      showloginpage=!showloginpage;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
if(showloginpage){
  return LoginPage(onTap: togglepages);
}else{
return RegisterPage(onTap: togglepages);
}
  }
}