import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

class AppGenderSelection extends StatelessWidget {
   AppGenderSelection({
     required this.onChanged,
     required this.selectedGender,
     Key? key}) : super(key: key);

  Function(Gender?) onChanged;
  Gender? selectedGender;
  @override
  Widget build(BuildContext context) {

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: GenderPickerWithImage(
          showOtherGender: false,
          verticalAlignedText: false,

          // to show what's selected on app opens, but by default it's Male
          selectedGender:selectedGender,
          selectedGenderTextStyle:  TextStyle(
              color: secondaryColorS2, fontWeight: FontWeight.bold),
          unSelectedGenderTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal),
          onChanged: onChanged,
          //Alignment between icons
          equallyAligned: true,
          animationDuration: const Duration(milliseconds: 300),
          isCircular: true,
          linearGradient:  LinearGradient(
              colors: [primaryColorS1, secondaryColorS1],
              tileMode: TileMode.clamp,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: const [0.0, 1.0]),
          // default : true,
          opacityOfGradient: 0.4,
          padding: const EdgeInsets.all(3),
          size: 50, //default : 40
        ),
      );
    }
}
