import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final String? Function(String? value) validator;
  final TextEditingController controller;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.isPassword = false});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  ///local var
  bool isObscureText = false;
  @override
  void initState() {
    isObscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIconConstraints: BoxConstraints(
          minWidth: 60.w,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      obscureText: isObscureText,
      validator: widget.validator,
    );
  }
}
