import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
   AppTextField({required this.text, required this.icon,Key? key}) : super(key: key);


  IconData icon;
  String? text;
  @override
  Widget build(BuildContext context) {
    double vertPad = 12;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [
            Container(
              decoration: BoxDecoration(
                color: primaryColorSA,
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0)
                )
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: vertPad, horizontal: 8),
                child: Icon(icon,
                color: secondaryColorS1,),
              ),),
            const SizedBox(width: 10,),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: vertPad, horizontal: 8),
              child: Text(text!,
                style:  TextStyle(
                    fontSize: 22,
                    color: primaryColorS1
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
