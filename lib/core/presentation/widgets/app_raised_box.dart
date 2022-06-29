import 'package:flutter/material.dart';
class AppRaisedBox extends StatelessWidget {
   AppRaisedBox({required this.child,Key? key}) : super(key: key);

  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow:  [
          BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 7,
            spreadRadius: 1.5,
            offset: const Offset(1.0, 3.0),),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,vertical: 2.0,),
        child: child,
      ),
    );
  }
}
