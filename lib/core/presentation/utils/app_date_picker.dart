import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../themes/app_theme.dart';

class AppDatePicker {
  Future<DateTime?> showMonthYearDatePicker(BuildContext context) async {
    return await showMonthYearPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2099),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: secondaryColorS2,
                secondary: secondaryColorS2,
                onSecondary: Colors.white,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: secondaryColorS2,

                ),
              ),
              textTheme: const TextTheme(
                  headline4: TextStyle(
                    fontFamily: 'Nexa',
                  ),
                  overline: TextStyle(
                    fontFamily: 'Nexa',
                  ),
                  button: TextStyle(
                    fontFamily: 'Nexa',
                  )),
            ),
            child: child!,
          );
        });

}
}