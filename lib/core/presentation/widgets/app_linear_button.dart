import 'package:flutter/material.dart';
class AppLinearButton extends StatelessWidget {

  AppLinearButton({required this.text,
    required this.onPressed,Key? key}) : super(key: key);


  String text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),),
        child:  Text(
            text,
          style: const TextStyle(
            fontSize: 20,
          //  fontWeight: FontWeight.w900,
          ),
        ),);
  }
}
