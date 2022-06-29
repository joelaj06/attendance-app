import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/core/presentation/widgets/app_linear_button.dart';
import 'package:attendance_system/core/presentation/widgets/app_loading_box.dart';
import 'package:attendance_system/core/presentation/widgets/app_text_input.dart';
import 'package:attendance_system/feature/authentication/presentation/login/getx/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //  backgroundColor: primaryColorS1.withOpacity(0.7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Obx(
          () => AppLoadingTransparentBox(
            loading: controller.isLoading.value,
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                              color: primaryColorS1,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    AppTextInput(
                      onChanged: (value) =>
                          controller.onEmailInputChange(value!),
                      validator: (value) => controller.validateEmail(value),
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return AppTextInput(
                        onChanged: (value) =>
                            controller.onPasswordInputChange(value!),
                        validator: (value) =>
                            controller.passwordValidator(value!),
                        suffixIcon: IconButton(
                          icon: controller.isObscure.value
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            controller.isObscure.value =
                                !controller.isObscure.value;
                          },
                        ),
                        obscureText: controller.isObscure.value,
                        hintText: 'Password',
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 20),
                    AppLinearButton(
                      text: 'LOGIN',
                      onPressed: () {
                        controller.login();
                      },
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        const Text('Don\'t have an account? '),
                        TextButton(
                          onPressed: (){
                            controller.navigateToSignUpPage();
                          },
                          child:  Text('Register',
                          style: TextStyle(
                            color: primaryColorS1,
                          ),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
