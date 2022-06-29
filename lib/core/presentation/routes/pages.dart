import 'package:attendance_system/feature/attendant_management/presentation/base/screens/base_screen.dart';
import 'package:attendance_system/feature/attendant_management/presentation/history/getx/history_bindings.dart';
import 'package:attendance_system/feature/attendant_management/presentation/history/screen/history_screen.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/screens/user_details_screen.dart';
import 'package:get/get.dart';
import 'package:attendance_system/core/root/root.dart';
import 'package:attendance_system/feature/attendant_management/presentation/home/getx/home_bindings.dart';
import 'package:attendance_system/feature/attendant_management/presentation/home/screen/home_screen.dart';
import 'package:attendance_system/feature/authentication/presentation/login/getx/login_bindings.dart';
import 'package:attendance_system/feature/authentication/presentation/login/screens/login_screen.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/getx/singup_bindings.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/screens/sign_up_screen.dart';

import 'app_route.dart';

class Pages {
  static List<GetPage<AppRoutes>> pages = [
    GetPage(
      name: AppRoutes.root,
      page: () => Root(),
      bindings:  <Bindings> [
      //  SignUpBindings(),
        LoginBindings(),
        HomeBindings(),
        HistoryBindings(),
   //     ProfileBindings()
      ]
    ),
    GetPage(
      name: AppRoutes.base,
      page: () => BaseScreen(),
      bindings: [
        HomeBindings(),
        HistoryBindings(),
      ]
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.singUp,
      page: () =>  const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: AppRoutes.userDetail,
      page: () =>   UserDetailScreen(),
      binding: SignUpBindings(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () =>  const HomeScreen(),
      binding: HomeBindings(),
    ),

    GetPage(
      name: AppRoutes.history,
      page: () =>  const HistoryScreen(),
      binding: HistoryBindings(),
    ),


  ];
}
