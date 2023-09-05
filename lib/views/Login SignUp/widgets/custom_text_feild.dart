import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final bool obscureText;
  const CustomTextField(
      {required this.textEditingController,
      required this.hinttext,
      required this.obscureText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(isDense: true,
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
            color: Colors.white,
          )),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey)),
      obscureText: obscureText,
    );
  }
}
