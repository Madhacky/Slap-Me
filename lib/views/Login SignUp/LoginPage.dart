import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:slap_me/providers/authservice.dart';
import 'package:slap_me/views/Login%20SignUp/widgets/custom_button.dart';
import 'package:slap_me/views/Login%20SignUp/widgets/custom_text_feild.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
   LoginPage({required this.onTap,super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Sign In 
  void signIn()async{
    final _authService=Provider.of<AuthService>(context,listen: false);
    try{
     await _authService.signInwithEmailPassword(_emailController.text, _passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
            //  Lottie.asset('assets/logo/icon.json',height: 150),       //logo

                //Welcome Back Message
                Text(
                  "Welcome back you \'ve been missed !",
                  style: TextStyle(fontSize: 16),
                ),    const SizedBox(height: 50,),       
                //email feild
                CustomTextField(
                  textEditingController: _emailController,
                  hinttext: 'E-mail',
                  obscureText: false,
                ), const SizedBox(height: 15,),
             
          
                //password feild
              CustomTextField(
                  textEditingController: _passwordController,
                  hinttext: 'Password',
                  obscureText: true,
                ), const SizedBox(height: 50,),
                //Sign in button
          CustomButton(onTap: signIn,Buttontext: 'Sign-In',),
          const SizedBox(height: 25,),
                //Forgot password ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member ?  '),
                    GestureDetector(
                      onTap: widget.onTap,
                      // (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      // },
                      child: Text('Register now',style: TextStyle(fontWeight: FontWeight.bold),))
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
