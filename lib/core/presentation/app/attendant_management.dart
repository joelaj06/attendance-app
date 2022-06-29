import 'package:attendance_system/core/presentation/routes/app_route.dart';
import 'package:attendance_system/core/presentation/routes/pages.dart';
import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
class AttendantManagement extends StatelessWidget {
  const AttendantManagement ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attendance Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nexa',
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColorSA,
        secondary: secondaryColorS1,
      ),

      ),
      getPages: Pages.pages,
      initialRoute: AppRoutes.root,
      initialBinding: AuthBindings(),
      localizationsDelegates: const[
        MonthYearPickerLocalizations.delegate
      ],
    );
  }
}
