import 'package:flutter/material.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget({
    super.key,
    required this.controller,
    this.hint = "null",
    required this.icon,
  });

  final TextEditingController controller;
  final String hint;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint,
            border: const OutlineInputBorder()),
        controller: controller,
      ),
    );
  }
}
