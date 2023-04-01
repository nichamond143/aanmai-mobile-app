import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecuredText;
  final IconData icon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecuredText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        controller: controller,
        obscureText: obsecuredText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.grey,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF68922)),
              borderRadius: BorderRadius.circular(25.0)),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
