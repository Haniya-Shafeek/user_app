import 'package:flutter/material.dart';
class cust_textfield extends StatelessWidget {
  const cust_textfield({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      
      decoration: InputDecoration(
        
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20))),
    );
  }
}