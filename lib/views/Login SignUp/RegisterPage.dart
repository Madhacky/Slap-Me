
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:slap_me/providers/authservice.dart';
import 'package:slap_me/views/Login%20SignUp/widgets/custom_button.dart';
import 'package:slap_me/views/Login%20SignUp/widgets/custom_text_feild.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({required this.onTap, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  //Sign Up
  void signUp() async {
    //if password do not match
    if (_passwordController.text != _confirmpasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password does not match')));
    } else {
      final _authService = Provider.of<AuthService>(context, listen: false);
      try {
        _authService.signUpwithEmailPassword(
            _emailController.text, _passwordController.text,_firstnameController.text,_lastnameController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
//if all good
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie.asset('assets/logo/icon.json', height: 150), //logo

                //Welcome Back Message
                Text(
                  "Let\'s create an account for you :)",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),

                CustomTextField(
                  textEditingController: _firstnameController,
                  hinttext: 'First name',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  textEditingController: _lastnameController,
                  hinttext: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                //email feild
                CustomTextField(
                  textEditingController: _emailController,
                  hinttext: 'E-mail',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),

                //password feild
                CustomTextField(
                  textEditingController: _passwordController,
                  hinttext: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),

                //Confirm Password feild
                CustomTextField(
                  textEditingController: _confirmpasswordController,
                  hinttext: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                //Register in button
                CustomButton(
                  onTap: signUp,
                  Buttontext: 'Sign-Up',
                ),
                const SizedBox(
                  height: 25,
                ),
                //Forgot password ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account ?  '),
                    GestureDetector(
                        onTap: widget.onTap,
                        //    (){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        // },
                        child: Text(
                          'Sign-In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
