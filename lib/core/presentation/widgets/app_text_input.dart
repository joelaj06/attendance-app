import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  AppTextInput({
    required this.onChanged,
    required this.validator,
    required this.hintText,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  final String? Function(String?) validator;
  final Function(String?) onChanged;
  Widget? suffixIcon;
  bool? obscureText = false;
  final String? hintText;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
