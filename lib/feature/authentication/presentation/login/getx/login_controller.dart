import 'package:attendance_system/core/presentation/routes/app_route.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class LoginController extends GetxController{

  // authController
  final AuthController _authController = Get.find<AuthController>();

  // global form key
  final formKey = GlobalKey<FormState>();

  // Reactive variables
  RxBool isObscure = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isLoading = false.obs;


  void login(){
    bool value = false;
    final isValid = formKey.currentState!.validate();
    if(isValid) {
      isLoading(value);
      debugPrint('before logging in $isLoading');
      dynamic result =
      _authController.signIn(email: email.value.trim(),
          password: password.value.trim(),);
      isLoading(value);
      debugPrint('after logging in $isLoading');
     // Get.offAllNamed<dynamic>(AppRoutes.base);
      debugPrint('logging in...');
      if(result == null){
      //  isLoading(false);
        debugPrint('Error signing in..');
      }
    }
  }
  void navigateToSignUpPage(){
    Get.toNamed(AppRoutes.singUp);
  }

  void onEmailInputChange(String value){
    email(value);
  }

  void onPasswordInputChange(String value){
    password(value);
  }

  String? validateEmail(String? value){
    String? errorMessage ;
    if(value!.isEmpty || !value.contains('@')){
      return errorMessage = 'Please enter a valid email address.';
    }else {
      return errorMessage;
    }
  }

  String? passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }
}