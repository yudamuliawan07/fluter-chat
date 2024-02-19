import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController mycontroller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
     super.key,
    required this.mycontroller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mycontroller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey)
      ),
    );
  }
}
