import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final bool isObscureText;
  final String hintText;
  final String? Function(String? value) validator;
  final TextEditingController controller;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObscureText,
      validator: validator,
    );
  }
}
