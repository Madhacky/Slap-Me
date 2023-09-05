import 'package:flutter/material.dart';
import 'package:slap_me/views/constants.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? Buttontext;
  const CustomButton({this.onTap, required this.Buttontext, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      onPressed: onTap,
      child: Container(
        
        width: 200,
        height: 50,
   
        child: Center(child: Text(Buttontext!,style: TextStyle(color: Colors.white,fontSize: 16),)),
      ),
      color: mainColor,
    );
  }
}
