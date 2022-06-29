import 'package:attendance_system/core/presentation/routes/app_route.dart';
import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/core/presentation/widgets/animation_column.dart';
import 'package:attendance_system/core/presentation/widgets/app_linear_button.dart';
import 'package:attendance_system/core/presentation/widgets/app_text_input.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/getx/signup_controller.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
     //   backgroundColor: primaryColorS1.withOpacity(0.7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
            child: AppAnimatedColumn(
              direction: Axis.vertical,
              duration: const Duration(milliseconds: 900),
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                        //  fontFamily: 'Nexa Bold',
                            color: primaryColorS1,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  AppTextInput(
                    onChanged: (value) => controller.onEmailInputChange(value!),
                    validator: (value) => controller.validateEmail(value),
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 28,),
                  Obx(() {
                    return AppTextInput(
                      onChanged: (value) =>
                          controller.onPasswordInputChange(value!),
                      validator: (value) => controller.passwordValidator(value!),
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
                  const SizedBox(height: 28,),
                  AppLinearButton(
                    text: 'REGISTER',
                    onPressed:() {
                      controller.signUp();
                    },),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
